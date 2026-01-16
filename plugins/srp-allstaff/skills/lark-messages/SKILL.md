---
name: lark-messages
description: Access Lark/Feishu messages and groups with user permissions (飞书消息与群组访问)
---

# Lark Messages (飞书消息与群组)

以用户身份查看和管理飞书群聊和消息，包括查看群列表、群成员、历史消息等。

Access and manage Lark group chats and messages as the authenticated user, including viewing group lists, members, and message history.

## Quick Start

### List My Groups (查看我的群聊)

```
显示我加入的所有群聊
List all my group chats
```

### Get Group Members (查看群成员)

```
显示"产品团队"群的所有成员
Show members of the "Engineering Team" group
```

### Read Messages (读取消息)

```
获取"产品团队"群最近的消息
Get recent messages from the "Engineering Team" group
```

### Send Messages (发送消息)

```
在"产品团队"群发送消息："会议推迟到明天"
Send message to "Engineering Team": "Meeting rescheduled to tomorrow"
```

## Key Features

### 1. Group Management (群组管理)

List and search groups that the user is a member of:

**Available MCP Tools:**
- `mcp__lark__im_v1_chat_list` - Get user's group chats
- `mcp__lark__im_v1_chat_create` - Create a new group (admin only)

**List Parameters:**
- `page_size`: Number of groups per page (max 100)
- `page_token`: For pagination
- `sort_type`: Sort by creation time or activity
  - `ByCreateTimeAsc`: By creation time (ascending)
  - `ByActiveTimeDesc`: By recent activity (descending)

### 2. Group Members (群成员)

View and manage group membership:

**Available MCP Tools:**
- `mcp__lark__im_v1_chatMembers_get` - Get group member list
- `mcp__lark__contact_v3_user_batchGetId` - Get user IDs by email/mobile

**Member Information:**
- Member ID (open_id, union_id, user_id)
- Member name
- Join time
- Member role (owner, admin, member)

### 3. Message Access (消息访问)

Read message history from groups:

**Available MCP Tools:**
- `mcp__lark__im_v1_message_list` - Get chat history
- `mcp__lark__im_v1_message_create` - Send messages

**Message List Parameters:**
- `container_id`: Group chat_id or thread_id
- `container_id_type`: "chat" or "thread"
- `sort_type`: Sort by creation time (asc/desc)
- `page_size`: Messages per page (max 100)
- `start_time` & `end_time`: Time range filter (Unix timestamp)

### 4. Send Messages (发送消息)

Send messages to groups or individuals:

**Message Types:**
- `text`: Plain text messages
- `post`: Rich text messages
- `image`: Image messages
- `file`: File attachments
- `interactive`: Card messages

## Common Workflows

### Workflow 1: Find and Read Group Messages

```markdown
1. User: "显示工程团队群的最新消息"
2. Assistant uses: mcp__lark__im_v1_chat_list
   - Get list of user's groups
3. Find group matching "工程团队"
4. Assistant uses: mcp__lark__im_v1_message_list
   - container_id: chat_id
   - container_id_type: "chat"
   - page_size: 20
5. Display recent messages with timestamps and senders
```

### Workflow 2: Get Group Member List

```markdown
1. User: "谁在产品团队群里?"
2. Assistant uses: mcp__lark__im_v1_chat_list
   - Find group matching "产品团队"
3. Assistant uses: mcp__lark__im_v1_chatMembers_get
   - chat_id: found_chat_id
   - page_size: 100
4. Display member list with names and roles
```

### Workflow 3: Send Message to Group

```markdown
1. User: "给工程团队发消息：今天的会议取消了"
2. Assistant uses: mcp__lark__im_v1_chat_list
   - Find group matching "工程团队"
3. Assistant uses: mcp__lark__im_v1_message_create
   - receive_id_type: "chat_id"
   - receive_id: found_chat_id
   - msg_type: "text"
   - content: JSON with text
4. Confirm message sent
```

## Examples (示例)

### Example 1: List Groups (列出群聊)

**User (Chinese):**
```
显示我加入的所有工作群
```

**Assistant Response:**
```markdown
我会列出你加入的所有群聊。

<uses mcp__lark__im_v1_chat_list>
- sort_type: ByActiveTimeDesc
- page_size: 50

你加入了以下 8 个群聊:

1. **产品团队** (12 members)
   - 最后活跃: 5分钟前
   - ID: oc_xxx123

2. **工程部全体** (45 members)
   - 最后活跃: 1小时前
   - ID: oc_xxx124

3. **设计团队** (8 members)
   - 最后活跃: 2小时前
   - ID: oc_xxx125

4. **周报汇总** (25 members)
   - 最后活跃: 1天前
   - ID: oc_xxx126

[... more groups ...]

需要查看哪个群的详细信息?
```

### Example 2: Read Group Messages (读取群消息)

**User (English):**
```
Show me the last 10 messages from the "Product Team" group
```

**Assistant Response:**
```markdown
I'll get the recent messages from the Product Team group.

<uses mcp__lark__im_v1_chat_list to find the group>
<uses mcp__lark__im_v1_message_list>
- container_id: oc_xxx123
- container_id_type: "chat"
- page_size: 10
- sort_type: ByCreateTimeDesc

Here are the last 10 messages from **Product Team**:

---

**张三** (5 min ago):
今天的产品评审会推迟到下午3点

**李四** (10 min ago):
好的,收到

**王五** (15 min ago):
@张三 新版本的原型图已经更新了,请查看 [链接]

**张三** (20 min ago):
👍

**李四** (25 min ago):
这周的sprint目标完成了80%,还剩两个任务

[... more messages ...]

Would you like me to get more messages or search for specific content?
```

### Example 3: Get Group Members (获取群成员)

**User (Chinese):**
```
产品团队群有哪些成员?
```

**Assistant Response:**
```markdown
我会获取产品团队群的成员列表。

<uses mcp__lark__im_v1_chat_list to find the group>
<uses mcp__lark__im_v1_chatMembers_get>
- chat_id: oc_xxx123
- page_size: 100

**产品团队** 共有 12 位成员:

**管理员:**
1. 张三 (群主) - @zhangsan
2. 李四 (管理员) - @lisi

**成员:**
3. 王五 - @wangwu
4. 赵六 - @zhaoliu
5. 孙七 - @sunqi
6. 周八 - @zhouba
7. 吴九 - @wujiu
8. 郑十 - @zhengshi
9. 钱十一 - @qianshiyi
10. 孙十二 - @sunshier
11. 李十三 - @lishisan
12. 周十四 - @zhoushisi

需要了解某位成员的更多信息吗?
```

### Example 4: Send Message (发送消息)

**User (English):**
```
Send a message to the "Engineering Team" group: "Code review session at 3 PM today"
```

**Assistant Response:**
```markdown
I'll send that message to the Engineering Team group.

<uses mcp__lark__im_v1_chat_list to find the group>
<uses mcp__lark__im_v1_message_create>
- receive_id_type: "chat_id"
- receive_id: oc_xxx124
- msg_type: "text"
- content: {"text": "Code review session at 3 PM today"}

✅ Message sent successfully to **Engineering Team** group.

The message "Code review session at 3 PM today" has been delivered to all 45 members.
```

### Example 5: Search Messages by Time Range (按时间范围搜索消息)

**User (Chinese):**
```
显示产品团队群昨天的所有消息
```

**Assistant Response:**
```markdown
我会获取产品团队群昨天的消息。

<calculate time range for yesterday>
<uses mcp__lark__im_v1_message_list>
- container_id: oc_xxx123
- container_id_type: "chat"
- start_time: 1705104000 (2024-01-13 00:00:00)
- end_time: 1705190400 (2024-01-14 00:00:00)
- sort_type: ByCreateTimeAsc

找到 **昨天 (2024-01-13)** 的 24 条消息:

**上午:**
- 09:15 张三: 早上好,今天的站会改到10点
- 09:20 李四: 收到
- 10:05 王五: 昨天提的bug已经修复了

**下午:**
- 14:30 赵六: 新功能的设计稿已更新
- 15:45 张三: @all 请大家review一下Q1的路线图
- 16:20 孙七: 看起来不错,建议增加移动端适配

[... more messages grouped by time ...]

总共 24 条消息。需要查看具体某条消息的详情吗?
```

## Important Notes

### Permission Boundaries (权限边界)
- Can only access groups the user is a member of
- Cannot read messages from groups the user hasn't joined
- Message sending requires appropriate group permissions
- Some groups may restrict who can send messages

### Group Identification (群组识别)
- Groups are identified by `chat_id` (e.g., oc_xxx123)
- Use group names to search, then get chat_id
- Cache chat_id for frequently accessed groups
- Group names may not be unique - confirm with user if multiple matches

### Message Format (消息格式)
- Text messages: Simple string content
- Rich text: JSON with formatting and mentions
- Attachments: Require file_key from upload
- @mentions: Use user's open_id

### Rate Limits (速率限制)
- API calls have rate limits per user
- Batch operations when possible
- Use pagination for large result sets
- Monitor for rate limit errors

## Error Handling

Common errors and solutions:

1. **"Group not found" (群聊未找到)**
   - User is not a member of this group
   - Group name may be misspelled
   - Use group list to find exact name

2. **"Permission denied" (权限被拒绝)**
   - User doesn't have permission to perform this action
   - Check group settings and user role

3. **"Message send failed" (消息发送失败)**
   - Bot doesn't have send permission in the group
   - Group may be archived or deleted
   - Check message content format

4. **"Invalid token" (无效令牌)**
   - MCP server authentication failed
   - Verify LARK_APP_ID and LARK_APP_SECRET
   - Ensure OAuth token is valid

## Tips for Effective Use

1. **Use descriptive group names**: When searching, use clear keywords
2. **Check before sending**: Confirm the correct group before sending messages
3. **Respect privacy**: Only access messages when necessary
4. **Time ranges**: Use time filters to narrow down message searches
5. **Pagination**: For groups with many messages, fetch in batches
6. **User IDs**: Get user open_id when mentioning specific people

## Advanced Features

### Thread Messages (话题消息)
- Access threaded replies within messages
- Use `container_id_type: "thread"` for thread messages
- Thread ID can be obtained from message responses

### Message Search (消息搜索)
- While there's no direct search API, you can:
  1. Get message history
  2. Filter locally by keyword
  3. Use time ranges to narrow scope

### Group Creation (创建群聊)
- Requires appropriate permissions
- Can specify initial members
- Set group name, description, and settings
- Add bots to the group

## Related Skills

- `lark-docs`: Access Lark cloud documents
- Future: `lark-calendar`, `lark-approval`, `lark-contacts`

## Privacy & Security

- All operations use the authenticated user's identity
- Cannot access private conversations without permission
- Message content is only accessible to authorized group members
- Follow company policies for message access and data handling
