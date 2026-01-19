#!/bin/bash

# Claude Code Feishu Notification Script
# Sends notification when Claude needs permission or completes task

WEBHOOK_URL="${FEISHU_WEBHOOK_URL:-}"

if [ -z "$WEBHOOK_URL" ]; then
    exit 0
fi

NOTIFICATION_INPUT=$(cat)
MESSAGE=$(echo "$NOTIFICATION_INPUT" | jq -r '.message // "Notification"' 2>/dev/null)
HOOK_TYPE=$(echo "$NOTIFICATION_INPUT" | jq -r '.hook_type // "unknown"' 2>/dev/null)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

case "$HOOK_TYPE" in
    "permission_prompt")
        EMOJI="🔐"
        TITLE="Waiting for Confirmation"
        TEMPLATE="yellow"
        ;;
    "idle_prompt")
        EMOJI="✅"
        TITLE="Task Completed"
        TEMPLATE="green"
        ;;
    *)
        EMOJI="📢"
        TITLE="Claude Code Notification"
        TEMPLATE="blue"
        ;;
esac

curl -s -X POST "$WEBHOOK_URL" \
    -H 'Content-Type: application/json' \
    -d "{
        \"msg_type\": \"interactive\",
        \"card\": {
            \"header\": {
                \"title\": {
                    \"tag\": \"plain_text\",
                    \"content\": \"$EMOJI $TITLE\"
                },
                \"template\": \"$TEMPLATE\"
            },
            \"elements\": [{
                \"tag\": \"markdown\",
                \"content\": \"**Claude Code needs your attention**\\n\\n$MESSAGE\\n\\nTime: $TIMESTAMP\"
            }]
        }
    }" > /dev/null 2>&1

exit 0
