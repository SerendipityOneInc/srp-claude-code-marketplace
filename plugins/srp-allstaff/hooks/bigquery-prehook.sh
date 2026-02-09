#!/bin/bash
# BigQuery PreHook - Cost and Security Validation
# Version: 2.0.0
# Purpose: Validate BigQuery SQL before execution via MCP plugin
# Compatible with Claude Code hooks system

# Read hook input from stdin (JSON format from Claude Code)
HOOK_INPUT=$(cat)

# Extract SQL from the MCP tool call
# The hook receives PreToolUse event with structure:
# {
#   "tool_name": "mcp__plugin_srp-developer_bigquery__execute-query",
#   "tool_input": {
#     "query": "SELECT ..."
#   }
# }
SQL=$(echo "$HOOK_INPUT" | jq -r '.tool_input.query // empty')

# If no SQL found, allow the action (might not be a BigQuery query)
if [ -z "$SQL" ]; then
    exit 0
fi

echo "🔍 BigQuery PreHook - Security and Cost Validation" >&2
echo "" >&2

# ====================================
# 1. Check Destructive Operations
# ====================================
echo "📋 [1/3] Checking for destructive operations..." >&2

if echo "$SQL" | grep -iE "\b(DROP|DELETE|TRUNCATE|UPDATE|INSERT|CREATE|ALTER)\b" > /dev/null; then
    echo "" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "❌ BLOCKED: Contains destructive operations" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "" >&2
    echo "💡 This skill only supports read-only queries (SELECT)" >&2
    echo "   For write operations, use BigQuery Console or bq CLI" >&2
    echo "" >&2

    # Output structured JSON response for Claude Code
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Blocked: SQL contains destructive operations (DROP/DELETE/TRUNCATE/UPDATE/INSERT/CREATE/ALTER). This skill only supports read-only queries (SELECT)."
  }
}
EOF
    exit 0
fi

echo "   ✅ Pass - No destructive operations" >&2
echo "" >&2

# ====================================
# 2. Cost Estimation (dry-run)
# ====================================
echo "💰 [2/3] Cost estimation check..." >&2

# Execute dry-run to get cost information
DRY_RUN_OUTPUT=$(bq query --dry_run --use_legacy_sql=false --project_id=srpproduct-dc37e "$SQL" 2>&1)
DRY_RUN_EXIT_CODE=$?

# Check if dry-run succeeded
if [ $DRY_RUN_EXIT_CODE -ne 0 ]; then
    # Check for authentication issues
    if echo "$DRY_RUN_OUTPUT" | grep -qi "auth\|login\|credential"; then
        echo "   ⚠️  BigQuery authentication not detected, skipping cost check" >&2
        echo "" >&2
        echo "   💡 To enable cost checking, run:" >&2
        echo "      gcloud auth login" >&2
        echo "      gcloud auth application-default login" >&2
        echo "" >&2
        COST_CHECK_FAILED=true
    else
        echo "   ⚠️  Cost check encountered an issue:" >&2
        echo "" >&2
        echo "$DRY_RUN_OUTPUT" | head -10 | sed 's/^/      /' >&2
        echo "" >&2
        echo "   💡 Possible causes:" >&2
        echo "      1. SQL syntax error" >&2
        echo "      2. Table does not exist (format: project.dataset.table)" >&2
        echo "      3. No read permissions" >&2
        echo "" >&2
        echo "   ⚠️  Skipping cost check but allowing execution (evaluate manually)" >&2
        echo "" >&2
        COST_CHECK_FAILED=true
    fi
else
    COST_CHECK_FAILED=false
fi

if [ "$COST_CHECK_FAILED" = false ]; then
    # Extract bytes processed
    BYTES_PROCESSED=$(echo "$DRY_RUN_OUTPUT" | grep -oE "[0-9]+ (B|KB|MB|GB|TB|PB)" | head -1)

    # Extract Slot Time
    SLOT_TIME=$(echo "$DRY_RUN_OUTPUT" | grep -oE "[0-9.]+ slot (milliseconds|seconds|minutes|hours)" | head -1)
    SLOT_TIME_VALUE=$(echo "$SLOT_TIME" | grep -oE "[0-9.]+")
    SLOT_TIME_UNIT=$(echo "$SLOT_TIME" | grep -oE "(milliseconds|seconds|minutes|hours)")

    # Convert Slot Time to hours
    SLOT_TIME_HOURS=0
    if [ -n "$SLOT_TIME_VALUE" ]; then
        case "$SLOT_TIME_UNIT" in
            "milliseconds")
                SLOT_TIME_HOURS=$(echo "scale=6; $SLOT_TIME_VALUE / 3600000" | bc 2>/dev/null || echo "0")
                ;;
            "seconds")
                SLOT_TIME_HOURS=$(echo "scale=6; $SLOT_TIME_VALUE / 3600" | bc 2>/dev/null || echo "0")
                ;;
            "minutes")
                SLOT_TIME_HOURS=$(echo "scale=6; $SLOT_TIME_VALUE / 60" | bc 2>/dev/null || echo "0")
                ;;
            "hours")
                SLOT_TIME_HOURS=$SLOT_TIME_VALUE
                ;;
        esac
    fi

    # Display cost information
    echo "   📊 Data to be scanned: ${BYTES_PROCESSED:-Unknown}" >&2
    echo "   ⏱️  Slot Time: ${SLOT_TIME:-Unknown}" >&2
    echo "" >&2

    # Check if Slot Time exceeds threshold (20 hours)
    THRESHOLD_HOURS=20

    if [ -n "$SLOT_TIME_HOURS" ] && command -v bc >/dev/null 2>&1; then
        if [ $(echo "$SLOT_TIME_HOURS > $THRESHOLD_HOURS" | bc 2>/dev/null || echo "0") -eq 1 ]; then
            echo "" >&2
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
            echo "❌ BLOCKED: Slot Time ($SLOT_TIME_HOURS hours) exceeds ${THRESHOLD_HOURS} hour threshold" >&2
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
            echo "" >&2
            echo "💡 Recommendations:" >&2
            echo "   1. Add stricter WHERE conditions (especially dt partition filter)" >&2
            echo "   2. Use a smaller time range" >&2
            echo "   3. Consider using higher-level aggregate tables (RPT layer)" >&2
            echo "   4. Query in batches with LIMIT" >&2
            echo "" >&2
            echo "💰 Cost estimate:" >&2
            ESTIMATED_COST=$(echo "scale=2; $SLOT_TIME_HOURS * 6.25" | bc 2>/dev/null || echo "N/A")
            echo "   - On-Demand: ~\$$ESTIMATED_COST USD" >&2
            echo "   - 20-hour threshold ~\$125 USD" >&2
            echo "" >&2

            # Output structured JSON response
            cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Blocked: Query cost too high. Slot Time ($SLOT_TIME_HOURS hours) exceeds ${THRESHOLD_HOURS} hour threshold (~\$$ESTIMATED_COST USD). Please optimize: 1) Add stricter WHERE/dt filters 2) Use smaller time range 3) Consider RPT layer tables 4) Use LIMIT"
  }
}
EOF
            exit 0
        fi

        # Cost warning (10-20 hours)
        WARNING_THRESHOLD_HOURS=10
        if [ $(echo "$SLOT_TIME_HOURS > $WARNING_THRESHOLD_HOURS" | bc 2>/dev/null || echo "0") -eq 1 ]; then
            ESTIMATED_COST=$(echo "scale=2; $SLOT_TIME_HOURS * 6.25" | bc 2>/dev/null || echo "N/A")
            echo "   ⚠️  Warning: Slot Time ($SLOT_TIME_HOURS hours) is high, consider optimizing query" >&2
            echo "   💰 Estimated cost: ~\$$ESTIMATED_COST USD (On-Demand)" >&2
        else
            echo "   ✅ Pass - Cost within reasonable range" >&2
        fi
    fi

    echo "" >&2
fi

# ====================================
# 3. Core Rules Validation
# ====================================
echo "📝 [3/3] Core rules validation..." >&2

# Check for Chinese field aliases (causes dry-run to fail)
if echo "$SQL" | perl -ne 'print if / AS [\x{4e00}-\x{9fa5}]/' > /dev/null 2>&1; then
    echo "" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "❌ BLOCKED: Chinese field aliases detected" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "" >&2
    echo "   Chinese aliases cause BigQuery dry-run to fail" >&2
    echo "" >&2
    echo "   🔧 Please use English aliases, for example:" >&2
    echo "      ❌ SELECT SUM(points) AS 总积分" >&2
    echo "      ✅ SELECT SUM(points) AS total_points" >&2
    echo "" >&2

    # Output structured JSON response
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Blocked: Chinese field aliases detected. Use English aliases instead (e.g., 'total_points' not '总积分')."
  }
}
EOF
    exit 0
fi

# Check for dt partition filter (Core Rule 1)
if echo "$SQL" | grep -iE "\bdt\b" | grep -iE ">|<|=|BETWEEN" > /dev/null; then
    echo "   ✅ Contains dt partition filter (Core Rule 1)" >&2
else
    echo "   ⚠️  Warning: No dt partition filter detected" >&2
    echo "      Core Rule 1: All queries must include dt partition filter to control costs" >&2
fi

# Check if aggregation queries filter user_group (Core Rule 2)
# Only check DWS/RPT layer tables
if echo "$SQL" | grep -iE "(COUNT|SUM|AVG|MAX|MIN)" > /dev/null; then
    # Check if querying DWS or RPT layer tables
    if echo "$SQL" | grep -iE "FROM.*\.(dws_|rpt_)" > /dev/null; then
        if echo "$SQL" | grep -iE "user_group\s*=\s*'all'" > /dev/null; then
            echo "   ✅ DWS/RPT aggregation query filters user_group='all' (Core Rule 2)" >&2
        else
            echo "   ⚠️  Warning: DWS/RPT aggregation query does not filter user_group" >&2
            echo "      Core Rule 2: DWS/RPT aggregations must filter user_group='all' to avoid double counting" >&2
        fi
    else
        # DWD layer does not need user_group check
        echo "   ✅ DWD layer query, no user_group filter needed" >&2
    fi
fi

echo "" >&2
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
echo "✅ PreHook validation passed - Query allowed" >&2
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
echo "" >&2

# Allow execution (exit 0 with no JSON output means allow)
exit 0
