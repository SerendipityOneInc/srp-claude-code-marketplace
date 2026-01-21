# SRP AllStaff Plugin

Lark/Feishu integration and office automation platform for all SRP staff, providing cloud document access, message management, and seamless integration with productivity tools.

## Overview

The SRP AllStaff plugin provides seamless integration with Lark (Feishu) and comprehensive office automation through Rube. Access documents, wiki pages, group chats, messages, and automate workflows across Gmail, Slack, Google Calendar, Google Drive, GitHub, Linear, and more. All operations use the authenticated user's identity and permissions.

## Features

### 📄 Lark Docs Access
- Search across all document types
- Read document content with user permissions
- Navigate wiki spaces and pages
- Access documents, sheets, bitables, and wiki content
- Bilingual support (Chinese and English)

### 💬 Lark Messages
- List all groups the user is a member of
- View group members and their roles
- Read message history from authorized groups
- Send messages to groups and individuals
- Search messages by time range and keywords

### 🔔 Feishu Notifications
- Send notifications when Claude needs user confirmation
- Alert on task completion
- Customizable notification messages via webhook
- Supports Notification and Stop hooks

### 🤖 Office Automation with Rube
Rube provides AI-powered automation across your productivity tools:

**Email & Communication:**
- Gmail: Send emails, summarize today's emails, draft quick responses
- Slack: Catch up on messages, send updates, search conversations
- WhatsApp: Send messages and notifications

**Calendar & Scheduling:**
- Google Calendar: Block deep work time, schedule meetings, check availability
- Automated time management and calendar coordination

**Document Management:**
- Google Drive: Access, search, and manage documents
- Create and organize files across Drive

**Project Management:**
- GitHub: Create issues, review PRs, manage repositories
- Linear: Create and update issues, track project progress
- Notion: Create tasks from emails, manage workspaces

**Other Integrations:**
- PagerDuty: Incident management and alerting
- Twitter: Draft and post tweets
- VSCode: Development workflow automation

**Example Use Cases:**
- Automatically create Linear issues from important emails
- Block calendar time for focused work based on project deadlines
- Summarize daily Slack messages and send digest via email
- Draft PR descriptions based on commit messages
- Create meeting notes in Notion from calendar events

## Prerequisites

### 1. Lark Application Credentials

The plugin uses the SRP shared Lark application with pre-configured permissions:

**Application Details:**
- **App ID:** `cli_a694efeda97c1013`
- **App Name:** SRP Claude Code Integration
- **Pre-configured Scopes:**
  - `im:chat:readonly` - Read group chats
  - `im:message:readonly` - Read messages
  - `im:message:send_as_user` - Send messages as user
  - `docx:document:readonly` - Read documents
  - `wiki:wiki:readonly` - Read wiki content
  - `contact:user:id:readonly` - Read user IDs

**Note:** The application credentials are shared across all SRP staff. You don't need to create a new Lark application - simply use the provided credentials in the environment variables below.

### 2. Rube API Key

Get your Rube API key:

1. Visit [Rube.app](https://rube.app/)
2. Sign up or log in
3. Go to Settings → API Keys
4. Create a new API key
5. Connect the services you want to use (Gmail, Slack, Calendar, etc.)

### 3. Environment Variables

Set up the following environment variables:

```bash
# Add to ~/.zshrc or ~/.bashrc

# Lark credentials
export LARK_APP_ID="cli_a694efeda97c1013"
export LARK_APP_SECRET="<obtain from SRP password manager or contact infra@srp.one>"

# Rube API key for office automation
export RUBE_API_KEY="your_rube_api_key_here"

# Optional: For Feishu notifications
export FEISHU_WEBHOOK_URL="https://open.feishu.cn/open-apis/bot/v2/hook/your_webhook_token"

# Reload shell configuration
source ~/.zshrc  # or source ~/.bashrc
```

**Verify environment variables are set:**
```bash
echo $LARK_APP_ID
echo $LARK_APP_SECRET
echo $RUBE_API_KEY
echo $FEISHU_WEBHOOK_URL  # Optional
```

### 4. MCP Server Configuration

The plugin uses two MCP servers with the following configuration in `.mcp.json`:

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
    },
    "rube": {
      "type": "http",
      "url": "https://rube.app/mcp",
      "headers": {
        "Authorization": "Bearer ${RUBE_API_KEY}"
      }
    }
  }
}
```

**MCP Servers:**
- **Lark MCP**: Provides Lark/Feishu integration
- **Rube MCP**: Provides office automation across multiple services

This configuration is automatically included when you install the plugin.

## Installation

### Step 1: Set Environment Variables

Set the required environment variables:

```bash
# Add to ~/.zshrc or ~/.bashrc
export LARK_APP_ID="cli_a694efeda97c1013"
export LARK_APP_SECRET="<obtain from SRP password manager or contact infra@srp.one>"
export RUBE_API_KEY="your_rube_api_key_here"  # Get from https://rube.app/

# Reload shell
source ~/.zshrc  # or source ~/.bashrc
```

**Verify environment variables:**
```bash
echo $LARK_APP_ID
echo $LARK_APP_SECRET
echo $RUBE_API_KEY
```

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

## Usage

### Available Commands

The plugin provides the following commands with the `srp:` namespace:

| Command | Alias | Skill | Description |
|---------|-------|-------|-------------|
| `srp:lark-docs` | `srp:docs` | lark-docs | Access Lark documents and wiki |
| `srp:lark-messages` | `srp:msg` | lark-messages | Access Lark messages and groups |
| `srp:mac-setup` | - | mac-setup | Mac development environment setup and verification |

**Usage examples:**
```bash
# Full command names
srp:lark-docs
srp:lark-messages
srp:mac-setup

# Short aliases
srp:docs
srp:msg

# Original skill names (also work)
/lark-docs
/lark-messages
/mac-setup
```

### Skill 1: Lark Docs Access

**Activate the skill:**
```bash
srp:lark-docs  # or srp:docs or /lark-docs
```

**Example prompts:**

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

### Skill 2: Lark Messages

**Activate the skill:**
```bash
srp:lark-messages  # or srp:msg or /lark-messages
```

**Example prompts:**

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

### Skill 3: Mac Setup

**Activate the skill:**
```bash
srp:mac-setup  # or /mac-setup
```

**Example prompts:**

```
帮我配置 Mac 开发环境
Setup my Mac for SRP development
检查我的 Mac 开发环境
```

**Workflow:**
1. 🔍 **前置检查** - 检查 Homebrew 和 gcloud 认证状态
2. 📊 **智能检测** - 扫描所有可安装组件的状态
3. ☑️ **用户选择** - 展示缺失组件，让用户选择要安装的内容
4. ⚙️ **执行安装** - 按依赖顺序安装和配置
5. ✅ **验证检查** - 验证安装配置是否正确

**Supported components:**
- **基础工具**: Claude Code, Warp Terminal, Git/GitHub CLI/Git LFS
- **开发环境**: Python 3.13, Anaconda, Cursor IDE, Orbstack
- **云平台 CLI**: Google Cloud SDK, Azure CLI, Oracle CLI, DigitalOcean CLI
- **DevOps 工具**: Terraform, telnet, iftop, node, maven, ansible 等
- **配置项**: pip 镜像配置, GKE 集群配置, Telepresence VPN

### Hooks: Feishu Notifications

The plugin includes notification hooks that send Feishu messages when Claude needs your attention or completes tasks.

**Setup:**

1. Create a custom bot in your Feishu group:
   - Open the group chat in Feishu
   - Click Settings → Bots → Add Bot
   - Create a custom bot and copy the webhook URL

2. Set the webhook URL as an environment variable:
```bash
export FEISHU_WEBHOOK_URL="https://open.feishu.cn/open-apis/bot/v2/hook/your_webhook_token"
```

**Supported hooks:**
- 🔐 **Notification**: Triggers when Claude needs user confirmation
- ✅ **Stop**: Triggers when Claude completes a task

**How it works:**
The notification hook automatically sends a message to your Feishu group when:
- Claude needs permission to run a command
- Claude completes a long-running task
- Claude enters an idle state waiting for user input

### Using Rube for Office Automation

Once configured, you can use natural language to automate tasks across your connected services:

**Example prompts:**

```
# Email management
"Summarize my unread emails from today and send me a digest"
"Send an email to john@example.com about the project update"
"Draft a follow-up email based on the last conversation"

# Calendar management
"Block 2 hours on my calendar for deep work tomorrow afternoon"
"Schedule a meeting with the team next Tuesday at 2pm"
"What's on my calendar for today?"

# Slack integration
"Catch up on messages in the #engineering channel from yesterday"
"Send a message to #general: Meeting moved to 3pm"
"Search for discussions about the new API in Slack"

# Document management
"Find the Q4 planning document in Google Drive"
"Create a new folder in Drive for the marketing project"
"Share the design doc with the team"

# Project management
"Create a Linear issue: Fix login bug on mobile"
"Update issue INF-341 status to In Progress"
"Create a GitHub issue for the API documentation"

# Cross-tool automation
"Create a Linear issue from my latest email about the bug report"
"Schedule time to work on my top 3 Linear issues this week"
"Draft a tweet about our new feature launch"
```

**Available Tools:**
Rube provides tools for all connected services. The specific tools depend on which integrations you've configured in your Rube account. Common tools include:
- Email sending and reading (Gmail)
- Calendar event management (Google Calendar)
- Message sending (Slack, WhatsApp)
- File operations (Google Drive)
- Issue creation and updates (GitHub, Linear, Notion)
- Tweet drafting (Twitter)
- Incident management (PagerDuty)

## Configuration

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

## Troubleshooting

### Issue 1: "Invalid token" or "Authentication failed"

**Problem:** MCP server cannot authenticate with Lark API.

**Solutions:**

1. Verify environment variables are set correctly:
   ```bash
   echo $LARK_APP_ID  # Should output: cli_a694efeda97c1013
   echo $LARK_APP_SECRET  # Should output the secret value
   ```

2. If not set, add them to your shell configuration:
   ```bash
   export LARK_APP_ID="cli_a694efeda97c1013"
   export LARK_APP_SECRET="<obtain from SRP password manager or contact infra@srp.one>"
   source ~/.zshrc  # or source ~/.bashrc
   ```

3. Restart Claude Code after setting environment variables

**Note:** The SRP shared Lark application is pre-configured with all required permissions. If you still have authentication issues after setting the environment variables, contact SRP Team (infra@srp.one).

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

### Issue 6: "Rube authentication failed"

**Problem:** Cannot use Rube automation features.

**Solutions:**
1. Verify RUBE_API_KEY is set:
   ```bash
   echo $RUBE_API_KEY
   ```
2. Check your API key is valid at https://rube.app/
3. Ensure you've connected the services you want to use in Rube dashboard
4. Restart Claude Code after setting the API key

### Issue 7: "Service not connected in Rube"

**Problem:** Cannot use a specific service (Gmail, Slack, etc.).

**Solutions:**
1. Log in to https://rube.app/
2. Go to Connected Services or Integrations
3. Connect the service you want to use
4. Grant necessary permissions
5. Try the operation again

## Permissions & Security

### User Identity
- All operations use the authenticated user's Lark identity
- OAuth flow ensures secure authentication
- Token refresh is handled automatically

### Permission Model
- Document access: User's actual Lark permissions apply
- Message access: Can only access groups the user is a member of
- No privilege elevation: Cannot access restricted resources

### Rube Security
- OAuth-based authentication for connected services
- API key stored as environment variable
- All operations use your authenticated identity
- Rube follows industry-standard security practices
- Granular permissions per connected service

### Data Privacy
- No data is stored or logged by the plugin
- Lark API calls go directly to Lark servers
- Rube acts as a proxy to connected services
- All data handling follows respective service policies (Gmail, Slack, etc.)
- Follows Lark's and Rube's data privacy policies

### Best Practices
- Only access documents and messages you need
- Review and limit Rube service connections to what you actively use
- Regularly audit connected services in Rube dashboard
- Respect company data handling policies
- Do not share sensitive information outside authorized channels
- Use environment variables for credentials (never hardcode)
- Rotate API keys periodically

## Examples

### Example 1: Daily Standup Summary

```
/lark-messages

Prompt: "Get all messages from Engineering Team group from yesterday and summarize key discussion points"

Result: Claude will:
1. Find the "Engineering Team" group
2. Retrieve yesterday's messages
3. Summarize key discussion points
4. Highlight action items and decisions
```

### Example 2: Find Architecture Documentation

```
/lark-docs

Prompt: "Search wiki for 'microservices architecture' and summarize the top 3 design principles"

Result: Claude will:
1. Search wiki for "microservices architecture"
2. Retrieve relevant documentation
3. Extract and summarize the top 3 design principles
```

### Example 3: Team Communication

```
/lark-messages

Prompt: "Send reminder to Product Team group: Product review meeting tomorrow at 2pm"

Result: Claude will:
1. Find the "Product Team" group
2. Compose the message
3. Send to the group
4. Confirm delivery
```

### Example 4: Cross-Platform Workflow Automation

```
Prompt: "Check my urgent emails, create Linear issues for any bug reports, and block time on my calendar to work on them"

Result: Claude will:
1. Access Gmail and filter urgent emails
2. Identify bug reports from email content
3. Create Linear issues with details from emails
4. Estimate time needed
5. Block calendar time for bug fixes
6. Provide summary of actions taken
```

### Example 5: Daily Productivity Routine

```
Prompt: "Give me my daily briefing: summarize today's calendar, recent Slack mentions, and top 3 Linear issues I should focus on"

Result: Claude will:
1. Check Google Calendar for today's schedule
2. Search Slack for messages mentioning you
3. Query Linear for your assigned high-priority issues
4. Generate a concise daily briefing
5. Suggest time blocks for focused work
```

### Example 6: Communication Automation

```
Prompt: "Draft a project update email based on completed Linear issues this week, and send it to the team Slack channel"

Result: Claude will:
1. Query Linear for completed issues this week
2. Draft a comprehensive update email
3. Review with you for approval
4. Send to specified email recipients
5. Post summary in Slack channel
6. Confirm all actions completed
```

## Limitations

### Lark Limitations
- Cannot edit or create documents (read-only)
- Cannot modify group settings or membership
- Wiki editing not supported
- File upload requires separate workflow
- Cannot access archived groups or messages

### Rube Limitations
- Depends on which services you've connected in Rube
- Each service has its own rate limits and permissions
- Some services require OAuth authorization flow
- Complex automations may require multiple steps

### Known Issues
- Large message histories may take time to load
- Document search limited to 50 results per query
- Group names must match exactly for searching
- OAuth token refresh may occasionally fail (retry works)
- Rube service connections need to be refreshed periodically

## Future Enhancements

Planned features for future versions:
- 📎 File upload and management
- 🔧 Document creation and editing
- 📊 Bitable (multi-dimensional table) operations
- 📱 Mobile app integration
- 🤖 Pre-built automation templates for common workflows
- 📋 Workflow scheduling and recurring tasks

## Support

### Documentation
- Plugin: `plugins/srp-allstaff/README.md` (this file)
- Skills:
  - `plugins/srp-allstaff/skills/lark-docs/SKILL.md`
  - `plugins/srp-allstaff/skills/lark-messages/SKILL.md`
  - `plugins/srp-allstaff/skills/mac-setup/SKILL.md`
- Lark Open Platform: https://open.feishu.cn/document
- Rube Documentation: https://rube.app/
- Rube MCP Market: https://mcpmarket.com/server/rube

### Getting Help
- Internal support: Contact SRP Team (infra@srp.one)
- Lark API docs: https://open.feishu.cn/document
- Rube support: https://rube.app/
- Claude Code docs: https://code.claude.com/docs

## Version History

### v1.0.2 (2026-01-21)
- Added mac-setup skill for Mac development environment setup and verification
- Smart detection of installed software and configurations
- Interactive component selection
- Post-installation verification checks
- Includes Cursor IDE extensions list

### v1.0.1 (2026-01-19)
- Added Rube MCP for office automation (Gmail, Slack, Calendar, Drive, GitHub, Linear, PagerDuty, etc.)
- Integrated Feishu notification hooks (merged from feishu-notify plugin)
- Added webhook-based notifications for permission requests and task completion
- Updated documentation with Rube automation examples and setup instructions
- Changed owner email to infra@srp.one

### v1.0.0 (2026-01-16)
- Initial release
- Lark Docs Access skill
- Lark Messages skill
- OAuth authentication support (Chinese and English)

## License

Internal use only by SRP (Serendipity One Inc.) employees.

---

**Plugin Name:** srp-allstaff
**Version:** 1.0.2
**Author:** SRP Team (infra@srp.one)
**Tags:** lark, feishu, documents, messaging, allstaff, automation, rube, gmail, slack, calendar, productivity
