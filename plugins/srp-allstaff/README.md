# SRP AllStaff Plugin (SRP全员插件)

飞书集成工具，为SRP全体员工提供云文档访问和消息管理功能。

Lark/Feishu integration tools for all SRP staff, providing cloud document access and message management capabilities.

## Overview (概述)

The SRP AllStaff plugin provides seamless integration with Lark (Feishu) to access documents, wiki pages, group chats, and messages directly from Claude Code. All operations use the authenticated user's identity and permissions.

SRP全员插件提供与飞书的无缝集成，可以直接在Claude Code中访问文档、知识库、群聊和消息。所有操作都使用用户的身份和权限。

## Features (功能特性)

### 📄 Lark Docs Access (飞书云文档访问)
- Search across all document types (文档、表格、多维表格、知识库)
- Read document content with user permissions
- Navigate wiki spaces and pages
- Access documents, sheets, bitables, and wiki content
- Bilingual support (Chinese and English)

### 💬 Lark Messages (飞书消息管理)
- List all groups the user is a member of
- View group members and their roles
- Read message history from authorized groups
- Send messages to groups and individuals
- Search messages by time range and keywords

## Prerequisites (前置要求)

### 1. Lark Application Credentials (飞书应用凭证)

You need a Lark application with the following permissions:

**Required Scopes (必需权限):**
- `im:chat:readonly` - Read group chats
- `im:message:readonly` - Read messages
- `im:message:send_as_user` - Send messages as user
- `docx:document:readonly` - Read documents
- `wiki:wiki:readonly` - Read wiki content
- `contact:user:id:readonly` - Read user IDs

**How to obtain credentials (如何获取凭证):**

1. Go to [Lark Open Platform](https://open.feishu.cn/app)
2. Create or select your application
3. Navigate to **Credentials & Basic Info**
4. Copy the **App ID** and **App Secret**
5. Configure permissions under **Permissions & Scopes**
6. Publish the app and get admin approval if required

### 2. Environment Variables (环境变量)

Set up the following environment variables with your Lark application credentials:

```bash
# Add to ~/.zshrc or ~/.bashrc
export LARK_APP_ID="cli_your_app_id_here"
export LARK_APP_SECRET="your_app_secret_here"

# Reload shell configuration
source ~/.zshrc  # or source ~/.bashrc
```

**Verify environment variables are set:**
```bash
echo $LARK_APP_ID
echo $LARK_APP_SECRET
```

### 3. MCP Server Configuration (MCP服务器配置)

The plugin uses the Lark MCP server with the following configuration in `.mcp.json`:

```json
{
  "mcpServers": {
    "lark": {
      "command": "npx",
      "args": [
        "-y",
        "@larksuiteoapi/lark-mcp",
        "mcp",
        "-a",
        "${LARK_APP_ID}",
        "-s",
        "${LARK_APP_SECRET}",
        "--oauth",
        "--token-mode",
        "auto"
      ],
      "env": {}
    }
  }
}
```

This configuration is automatically included when you install the plugin.

## Installation (安装)

### Step 1: Verify Environment Variables

Ensure your Lark credentials are set:

```bash
echo $LARK_APP_ID
echo $LARK_APP_SECRET
```

If not set, refer to the Prerequisites section above.

### Step 2: Install the Plugin

```bash
# Navigate to the marketplace directory
cd ~/Downloads/srp-claude-code-marketplace

# Install the plugin
/plugin install srp-allstaff@srp-claude-code-marketplace
```

### Step 3: Verify Installation

Check that the plugin is installed:
```bash
/plugin list
```

You should see `srp-allstaff` in the list of installed plugins.

## Usage (使用方法)

### Skill 1: Lark Docs Access (飞书云文档)

**Activate the skill:**
```bash
/lark-docs
```

**Example prompts (示例提示):**

Chinese (中文):
```
搜索包含'OKR'的文档
获取这个文档的内容：https://example.feishu.cn/docx/abc123
在知识库中搜索关于'架构设计'的内容
显示张三创建的所有文档
```

English:
```
Search for documents containing 'product roadmap'
Get the content of this document: https://example.feishu.cn/wiki/xyz789
Search wiki for 'system architecture' documentation
Show all documents owned by John
```

**Key operations:**
- 📝 Search documents by keyword
- 📖 Read document content
- 🔍 Search wiki pages
- 👤 Find documents by owner
- 🔗 Access documents via URL

### Skill 2: Lark Messages (飞书消息)

**Activate the skill:**
```bash
/lark-messages
```

**Example prompts (示例提示):**

Chinese (中文):
```
显示我加入的所有群聊
产品团队群有哪些成员?
获取工程团队群最近的消息
给产品团队发消息："会议推迟到明天"
```

English:
```
List all my group chats
Show members of the "Engineering Team" group
Get recent messages from the "Product Team" group
Send message to "Engineering Team": "Meeting rescheduled to tomorrow"
```

**Key operations:**
- 📋 List all groups
- 👥 View group members
- 💬 Read message history
- ✉️ Send messages
- 🔍 Search messages by time

## Configuration (配置)

### MCP Server Configuration

The plugin automatically configures the Lark MCP server. The configuration is located at:

```
plugins/srp-allstaff/.mcp.json
```

**Configuration details:**
- Uses authenticated token (from `npx @larksuiteoapi/lark-mcp login`)
- Token is automatically managed by the Lark MCP server
- No environment variables needed in the MCP configuration

### Plugin Metadata

Plugin information is defined in:
```
plugins/srp-allstaff/.claude-plugin/plugin.json
```

## Troubleshooting (故障排除)

### Issue 1: "Invalid token" or "Authentication failed"

**Problem:** MCP server cannot authenticate with Lark API.

**Solutions:**

1. Verify environment variables are set correctly:
   ```bash
   echo $LARK_APP_ID
   echo $LARK_APP_SECRET
   ```
2. Verify your Lark app credentials are valid in [Lark Open Platform](https://open.feishu.cn/app)
3. Ensure the app has the required scopes/permissions enabled
4. Check that the app is published and approved (if required)
5. Restart Claude Code after setting environment variables

**Alternative: Use login command (optional)**

If you prefer not to use environment variables, you can also authenticate using:
```bash
npx -y @larksuiteoapi/lark-mcp login -a cli_your_app_id -s your_app_secret
```

However, the plugin is configured to use environment variables by default.

### Issue 2: "Permission denied" when accessing documents

**Problem:** Cannot access certain documents or groups.

**Solutions:**
1. Verify you have access to the document in Feishu web/mobile app
2. Check that the document URL is correct
3. Ensure the document hasn't been deleted or moved
4. Ask the document owner to grant you access

### Issue 3: "Group not found" when accessing messages

**Problem:** Cannot find or access a specific group.

**Solutions:**
1. Verify you are a member of the group
2. Check the group name spelling
3. Use `/lark-messages` and list all groups first
4. The group may have been archived or deleted

### Issue 4: Cannot send messages

**Problem:** Message sending fails.

**Solutions:**
1. Check that you have permission to send messages in the group
2. Verify the group allows bot messages
3. Ensure your Lark app has `im:message:send_as_user` permission
4. Check that the message content format is valid

### Issue 5: MCP server fails to start

**Problem:** Plugin loads but MCP server doesn't start.

**Solutions:**
1. Ensure `@larksuiteoapi/lark-mcp` package is accessible via npx
2. Check Node.js is installed: `node --version`
3. Verify network access to npm registry
4. Try manually running: `npx -y @larksuiteoapi/lark-mcp --help`

## Permissions & Security (权限与安全)

### User Identity (用户身份)
- All operations use the authenticated user's Lark identity
- OAuth flow ensures secure authentication
- Token refresh is handled automatically

### Permission Model (权限模型)
- Document access: User's actual Lark permissions apply
- Message access: Can only access groups the user is a member of
- No privilege elevation: Cannot access restricted resources

### Data Privacy (数据隐私)
- No data is stored or logged by the plugin
- All API calls go directly to Lark servers
- Follows Lark's data privacy and security policies

### Best Practices (最佳实践)
- Only access documents and messages you need
- Respect company data handling policies
- Do not share sensitive information outside authorized channels
- Use environment variables for credentials (never hardcode)

## Examples (示例场景)

### Example 1: Daily Standup Summary (每日站会总结)

```
/lark-messages

Prompt: "获取工程团队群昨天的所有消息,并总结关键讨论点"

Result: Claude will:
1. Find the "Engineering Team" group
2. Retrieve yesterday's messages
3. Summarize key discussion points
4. Highlight action items and decisions
```

### Example 2: Find Architecture Documentation (查找架构文档)

```
/lark-docs

Prompt: "在知识库中搜索'微服务架构',然后总结最重要的3个设计原则"

Result: Claude will:
1. Search wiki for "微服务架构"
2. Retrieve relevant documentation
3. Extract and summarize the top 3 design principles
```

### Example 3: Team Communication (团队沟通)

```
/lark-messages

Prompt: "给产品团队群的所有成员发送提醒：明天下午2点产品评审会"

Result: Claude will:
1. Find the "Product Team" group
2. Compose the message
3. Send to the group
4. Confirm delivery
```

## Limitations (限制)

### Current Limitations
- Cannot edit or create documents (read-only)
- Cannot modify group settings or membership
- Wiki editing not supported
- File upload requires separate workflow
- Cannot access archived groups or messages

### Known Issues
- Large message histories may take time to load
- Document search limited to 50 results per query
- Group names must match exactly for searching
- OAuth token refresh may occasionally fail (retry works)

## Future Enhancements (未来增强)

Planned features for future versions:
- 📅 Calendar integration
- ✅ Approval workflow management
- 📎 File upload and management
- 🔧 Document creation and editing
- 📊 Bitable (multi-dimensional table) operations
- 🔔 Notification management
- 📱 Mobile app integration

## Support (支持)

### Documentation
- Plugin: `plugins/srp-allstaff/README.md` (this file)
- Skills:
  - `plugins/srp-allstaff/skills/lark-docs/SKILL.md`
  - `plugins/srp-allstaff/skills/lark-messages/SKILL.md`
- Lark Open Platform: https://open.feishu.cn/document

### Getting Help
- Internal support: Contact SRP Team (team@srp.one)
- Lark API docs: https://open.feishu.cn/document
- Claude Code docs: https://code.claude.com/docs

## Version History (版本历史)

### v1.0.0 (2026-01-16)
- Initial release
- Lark Docs Access skill
- Lark Messages skill
- OAuth authentication support
- Bilingual documentation (Chinese and English)

## License (许可证)

Internal use only by SRP (Serendipity One Inc.) employees.

---

**Plugin Name:** srp-allstaff
**Version:** 1.0.0
**Author:** SRP Team (team@srp.one)
**Tags:** lark, feishu, documents, messaging, allstaff
