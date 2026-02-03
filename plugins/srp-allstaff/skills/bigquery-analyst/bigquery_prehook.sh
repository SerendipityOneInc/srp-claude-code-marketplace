#!/bin/bash
# BigQuery PreHook - 成本和安全检查
# 版本: 1.0.0
# 用途: 在执行 BigQuery SQL 前进行成本估算和安全检查

# 不使用 set -e，因为某些命令失败是预期的（如 bc 未安装）

# 提取 SQL（第一个参数）
SQL="$1"

# 如果没有传入 SQL，退出
if [ -z "$SQL" ]; then
    echo "❌ 错误: 未提供 SQL 语句"
    exit 1
fi

echo "🔍 BigQuery PreHook 安全检查..."
echo ""

# ====================================
# 1. 检查破坏性操作
# ====================================
echo "📋 [1/3] 检查破坏性操作..."

if echo "$SQL" | grep -iE "\b(DROP|DELETE|TRUNCATE|UPDATE|INSERT)\b" > /dev/null; then
    echo "❌ 拒绝执行: 包含破坏性操作 (DROP/DELETE/TRUNCATE/UPDATE/INSERT)"
    echo ""
    echo "💡 提示: 此 Skill 仅支持只读查询 (SELECT)"
    echo "   如需执行写操作，请使用 BigQuery Console 或 bq 命令行工具"
    exit 1
fi

echo "   ✅ 通过 - 无破坏性操作"
echo ""

# ====================================
# 2. 成本检查（dry-run）
# ====================================
echo "💰 [2/3] 成本预估检查..."

# 执行 dry-run 获取成本信息
DRY_RUN_OUTPUT=$(bq query --dry_run --use_legacy_sql=false --project_id=srpproduct-dc37e "$SQL" 2>&1)
DRY_RUN_EXIT_CODE=$?

# 检查 dry-run 是否成功
if [ $DRY_RUN_EXIT_CODE -ne 0 ]; then
    # 检查是否是认证问题
    if echo "$DRY_RUN_OUTPUT" | grep -qi "auth\|login\|credential"; then
        echo "   ⚠️  未检测到 BigQuery 认证，跳过成本检查"
        echo ""
        echo "   💡 如需启用成本检查，请运行:"
        echo "      gcloud auth login"
        echo "      gcloud auth application-default login"
        echo ""
        COST_CHECK_FAILED=true
    else
        echo "   ⚠️  成本检查遇到问题:"
        echo ""
        echo "$DRY_RUN_OUTPUT" | head -10 | sed 's/^/      /'
        echo ""
        echo "   💡 可能原因:"
        echo "      1. SQL 语法错误"
        echo "      2. 表名不存在 (格式: project.dataset.table)"
        echo "      3. 无读权限"
        echo ""
        echo "   ⚠️  跳过成本检查，但允许继续执行（请自行评估）"
        echo ""
        COST_CHECK_FAILED=true
    fi
else
    COST_CHECK_FAILED=false
fi

if [ "$COST_CHECK_FAILED" = false ]; then
    # 提取数据扫描量
    BYTES_PROCESSED=$(echo "$DRY_RUN_OUTPUT" | grep -oE "[0-9]+ (B|KB|MB|GB|TB|PB)" | head -1)

    # 提取 Slot Time
    SLOT_TIME=$(echo "$DRY_RUN_OUTPUT" | grep -oE "[0-9.]+ slot (milliseconds|seconds|minutes|hours)" | head -1)
    SLOT_TIME_VALUE=$(echo "$SLOT_TIME" | grep -oE "[0-9.]+")
    SLOT_TIME_UNIT=$(echo "$SLOT_TIME" | grep -oE "(milliseconds|seconds|minutes|hours)")

    # 将 Slot Time 统一转换为小时
    SLOT_TIME_HOURS=0
    if [ -n "$SLOT_TIME_VALUE" ]; then
        case "$SLOT_TIME_UNIT" in
            "milliseconds")
                SLOT_TIME_HOURS=$(echo "scale=6; $SLOT_TIME_VALUE / 3600000" | bc)
                ;;
            "seconds")
                SLOT_TIME_HOURS=$(echo "scale=6; $SLOT_TIME_VALUE / 3600" | bc)
                ;;
            "minutes")
                SLOT_TIME_HOURS=$(echo "scale=6; $SLOT_TIME_VALUE / 60" | bc)
                ;;
            "hours")
                SLOT_TIME_HOURS=$SLOT_TIME_VALUE
                ;;
        esac
    fi

    # 显示成本信息
    echo "   📊 数据扫描量: ${BYTES_PROCESSED:-未知}"
    echo "   ⏱️  Slot Time: ${SLOT_TIME:-未知}"
    echo ""

    # 检查 Slot Time 是否超过阈值（20 小时）
    THRESHOLD_HOURS=20

    if [ -n "$SLOT_TIME_HOURS" ] && [ $(echo "$SLOT_TIME_HOURS > $THRESHOLD_HOURS" | bc) -eq 1 ]; then
        echo "❌ 拒绝执行: Slot Time ($SLOT_TIME_HOURS hours) 超过 ${THRESHOLD_HOURS} 小时阈值"
        echo ""
        echo "💡 建议:"
        echo "   1. 添加更严格的 WHERE 条件（特别是 dt 分区过滤）"
        echo "   2. 使用更小的时间范围"
        echo "   3. 考虑使用更高层级的聚合表（RPT 层）"
        echo "   4. 分批查询，使用 LIMIT"
        echo ""
        echo "💰 成本估算:"
        echo "   - On-Demand: ~\$$(echo "scale=2; $SLOT_TIME_HOURS * 6.25" | bc) USD"
        echo "   - 20小时阈值约: \$125 USD"
        exit 1
    fi

    # 成本警告（10-20小时）
    WARNING_THRESHOLD_HOURS=10
    if [ -n "$SLOT_TIME_HOURS" ] && [ $(echo "$SLOT_TIME_HOURS > $WARNING_THRESHOLD_HOURS" | bc) -eq 1 ]; then
        echo "   ⚠️  警告: Slot Time ($SLOT_TIME_HOURS hours) 较高，建议优化查询"
        echo "   💰 估算成本: ~\$$(echo "scale=2; $SLOT_TIME_HOURS * 6.25" | bc) USD (On-Demand)"
    else
        echo "   ✅ 通过 - 成本在合理范围内"
    fi

    echo ""
fi

# ====================================
# 3. 层级建议
# ====================================
echo "🏗️  [3/3] 数据层级检查..."

# 检查是否访问 ODS/DWD 层
if echo "$SQL" | grep -iE "\\.ods_|\\.dwd_" > /dev/null; then
    echo "   ⚠️  警告: 正在访问 ODS/DWD 层（明细数据层）"
    echo ""
    echo "💡 建议:"
    echo "   - ODS 层: 原始数据，数据量大，性能较差"
    echo "   - DWD 层: 明细数据，适合需要详细字段的分析"
    echo "   - RPT 层: 预聚合指标，查询性能最优（推荐）"
    echo ""
    echo "   如果不需要明细数据，建议使用 RPT 层表"
elif echo "$SQL" | grep -iE "\\.dws_" > /dev/null; then
    echo "   ✅ 使用 DWS 层（汇总数据层）"
elif echo "$SQL" | grep -iE "\\.rpt_" > /dev/null; then
    echo "   ✅ 使用 RPT 层（报表数据层，推荐）"
else
    echo "   ℹ️  未识别到明确的数据层级"
fi

echo ""

# ====================================
# 4. 额外检查
# ====================================

# 检查是否使用了中文字段别名（会导致成本检查失败）
if echo "$SQL" | grep -E " AS ['\"]?[\x{4e00}-\x{9fa5}]" > /dev/null 2>&1 || \
   echo "$SQL" | perl -ne 'print if / AS [\x{4e00}-\x{9fa5}]/' > /dev/null 2>&1; then
    echo "❌ 错误: 检测到中文字段别名"
    echo "   中文别名会导致 BigQuery dry-run 失败"
    echo ""
    echo "   🔧 请使用英文别名，例如:"
    echo "      ❌ SELECT SUM(points) AS 总积分"
    echo "      ✅ SELECT SUM(points) AS total_points"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "❌ PreHook 检查失败 - 拒绝执行"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 1
fi

# 检查是否有 dt 分区过滤（核心规则 1）
if echo "$SQL" | grep -iE "\bdt\b" | grep -iE ">|<|=|BETWEEN" > /dev/null; then
    echo "✅ 已包含 dt 分区过滤"
else
    echo "⚠️  警告: 未发现 dt 分区过滤"
    echo "   核心规则 1: 所有查询必须包含 dt 分区过滤以控制成本"
fi

# 检查聚合查询是否过滤 user_group（核心规则 2）
# 仅检查 DWS/RPT 层表（通过表名前缀判断）
if echo "$SQL" | grep -iE "(COUNT|SUM|AVG|MAX|MIN)" > /dev/null; then
    # 检查是否查询 DWS 或 RPT 层表
    if echo "$SQL" | grep -iE "FROM.*\.(dws_|rpt_)" > /dev/null; then
        if echo "$SQL" | grep -iE "user_group\s*=\s*'all'" > /dev/null; then
            echo "✅ DWS/RPT 聚合查询已过滤 user_group='all'"
        else
            echo "⚠️  警告: DWS/RPT 聚合查询未过滤 user_group"
            echo "   核心规则 2: DWS/RPT 层聚合查询必须过滤 user_group='all' 避免重复计数"
        fi
    else
        # DWD 层不需要检查 user_group
        echo "✅ DWD 层查询，无需 user_group 过滤"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ PreHook 检查通过 - 允许执行查询"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 允许执行
exit 0
