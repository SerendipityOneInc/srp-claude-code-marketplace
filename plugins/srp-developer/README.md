# SRP Developer Plugin (SRP开发者插件)

开发者专用插件，扩展 srp-allstaff 功能，增加 GitHub 集成、GCP 只读访问等开发工具。

Developer-specific plugin that extends srp-allstaff with GitHub integration, GCP read-only access, and other development tools.

## Overview (概述)

The SRP Developer plugin builds on the srp-allstaff foundation, adding essential development tools including GitHub code review, PR management, BigQuery data access, and more.

SRP开发者插件基于 srp-allstaff 基础，增加了 GitHub 代码审查、PR 管理、BigQuery 数据访问等核心开发工具。

## Features (功能特性)

### 📦 Inherited from srp-allstaff (继承自 srp-allstaff)
- 📄 Lark Docs Access (飞书云文档访问)
- 💬 Lark Messages (飞书消息管理)

### 🆕 Developer-Specific Features (开发者专属功能)

#### 🐙 GitHub Integration (GitHub 集成)
- View and search pull requests
- Code review and comments
- Issue tracking and management
- Repository information
- Commit history and diffs
- CI/CD status checking

#### ☁️ GCP Read-Only Access (GCP 只读访问)
- BigQuery data queries
- Table schema viewing
- Data analysis and aggregation
- **Read-only**: No data modification allowed

## Prerequisites (前置要求)

### 1. Install srp-allstaff First (先安装 srp-allstaff)

This plugin depends on srp-allstaff:
```bash
/plugin install srp-allstaff@srp-claude-code-marketplace
```

### 2. Set Up Environment Variables (设置环境变量)

**Lark (from srp-allstaff):**
```bash
export LARK_APP_ID="cli_your_app_id"
export LARK_APP_SECRET="your_app_secret"
```

**GitHub:**
```bash
export GITHUB_TOKEN="ghp_your_github_token"
```

**GCP:**
```bash
export GCP_PROJECT_ID="srpproduct-dc37e"
export GCP_LOCATION="us-east1"
```

**Reload shell:**
```bash
source ~/.zshrc  # or source ~/.bashrc
```

### 3. GCP Authentication (GCP 认证)

```bash
gcloud auth application-default login
```

## Installation (安装)

```bash
# Navigate to marketplace directory
cd ~/Downloads/srp-claude-code-marketplace

# Install the plugin
/plugin install srp-developer@srp-claude-code-marketplace
```

## Usage (使用方法)

### Skill 1: GitHub Integration (GitHub 集成)

**Activate the skill:**
```bash
/github-integration
```

**Example prompts:**

Chinese (中文):
```
显示 SerendipityOneInc/srp-claude-code-marketplace 的 PR 列表
审查 PR #10 的代码变更
创建一个 issue：添加 DevOps 插件功能
检查 PR #15 的构建状态
```

English:
```
List open PRs in SerendipityOneInc/srp-claude-code-marketplace
Review code changes in PR #10
Create an issue: Add DevOps plugin feature
Check CI/CD status of PR #15
```

**Key operations:**
- 📋 List and search PRs
- 🔍 Review code changes
- 📝 Create and manage issues
- ✅ Check CI/CD status
- 💬 Add review comments

### Skill 2: GCP Read-Only Access (GCP 只读访问)

**Activate the skill:**
```bash
/gcp-readonly
```

**Example prompts:**

Chinese (中文):
```
显示所有 BigQuery 表
查询表 analytics.user_events 的前 10 行
分析昨天的用户活跃数据
显示表 dataset.table 的字段结构
```

English:
```
List all BigQuery tables
Query first 10 rows from analytics.user_events
Analyze yesterday's user activity data
Show schema of table dataset.table
```

**Key operations:**
- 📊 Execute SELECT queries
- 📋 List tables and datasets
- 🔍 View table schemas
- 📈 Analyze data
- ⚠️ **Read-only**: No data modification

## Configuration (配置)

### MCP Servers

The plugin configures the following MCP servers:

**GitHub:**
```json
{
  "github": {
    "type": "stdio",
    "command": "npx",
    "args": ["@modelcontextprotocol/server-github"]
  }
}
```

**BigQuery:**
```json
{
  "bigquery": {
    "type": "stdio",
    "command": "uvx",
    "args": [
      "mcp-server-bigquery",
      "--project", "${GCP_PROJECT_ID}",
      "--location", "${GCP_LOCATION}"
    ]
  }
}
```

## Troubleshooting (故障排除)

### Issue 1: "GitHub token invalid"

**Problem:** Cannot authenticate with GitHub API.

**Solutions:**
1. Verify GITHUB_TOKEN is set:
   ```bash
   echo $GITHUB_TOKEN
   ```
2. Create a new token at https://github.com/settings/tokens
3. Required scopes: `repo`, `read:user`, `read:org`
4. Restart Claude Code after setting the token

### Issue 2: "BigQuery permission denied"

**Problem:** Cannot access BigQuery tables.

**Solutions:**
1. Verify GCP authentication:
   ```bash
   gcloud auth application-default login
   ```
2. Check IAM permissions (requires `bigquery.dataViewer` role)
3. Verify GCP_PROJECT_ID is correct
4. Contact GCP admin for access

### Issue 3: "Plugin dependency missing"

**Problem:** srp-allstaff not installed.

**Solutions:**
1. Install srp-allstaff first:
   ```bash
   /plugin install srp-allstaff@srp-claude-code-marketplace
   ```
2. Then reinstall srp-developer

## Permissions & Security (权限与安全)

### GitHub Access (GitHub 访问)
- Read repositories, PRs, issues
- Create and update issues
- Submit code reviews
- Cannot merge PRs or modify repo settings

### GCP Access (GCP 访问)
- **Read-only**: Query data, view schemas
- Cannot modify data (INSERT, UPDATE, DELETE)
- Cannot create or drop tables
- All queries are logged

### Best Practices (最佳实践)
- Only access data you need
- Use LIMIT for exploratory queries
- Follow company data policies
- Do not share sensitive data
- Use environment variables for credentials

## Examples (示例场景)

### Example 1: PR Review Workflow (PR 审查工作流)

```bash
/github-integration

Prompt: "审查 SerendipityOneInc/srp-claude-code-marketplace 的 PR #12"

Claude will:
1. Get PR details and changed files
2. Check CI/CD build status
3. Review code changes
4. Provide feedback and suggestions
5. (Optional) Submit review comments
```

### Example 2: Data Analysis (数据分析)

```bash
/gcp-readonly

Prompt: "分析 analytics.user_events 表中昨天最活跃的 10 个事件类型"

Claude will:
1. Query the analytics.user_events table
2. Aggregate by event_type
3. Count active users per type
4. Present results in a table
5. Provide insights and recommendations
```

### Example 3: Combined Workflow (组合工作流)

```bash
# First, check Lark messages
/lark-messages
Prompt: "显示工程团队群的最新消息"

# Then, review related PR
/github-integration
Prompt: "审查消息中提到的 PR #15"

# Finally, check data impact
/gcp-readonly
Prompt: "查询相关功能的使用数据"
```

## Limitations (限制)

### Current Limitations
- GCP: BigQuery only (GCS and GKE coming soon)
- GitHub: Cannot merge PRs or manage settings
- No CI/CD pipeline triggering (view status only)
- No code quality metrics (coming soon)

### Future Enhancements
- GCS bucket and object access
- GKE cluster and pod information
- CI/CD pipeline integration
- Code quality and test coverage metrics
- Automated code review suggestions
- Integration with monitoring tools

## Support (支持)

### Documentation
- Plugin: `plugins/srp-developer/README.md` (this file)
- Skills:
  - `plugins/srp-developer/skills/github-integration/SKILL.md`
  - `plugins/srp-developer/skills/gcp-readonly/SKILL.md`

### Getting Help
- Internal support: Contact SRP Team (team@srp.one)
- GitHub API docs: https://docs.github.com/rest
- BigQuery SQL reference: https://cloud.google.com/bigquery/docs/reference/standard-sql

## Version History (版本历史)

### v1.0.0 (2026-01-16)
- Initial release
- Depends on srp-allstaff v1.0.0
- GitHub Integration skill
- GCP Read-Only skill (BigQuery)
- Bilingual documentation

## License (许可证)

Internal use only by SRP (Serendipity One Inc.) employees.

---

**Plugin Name:** srp-developer
**Version:** 1.0.0
**Dependencies:** srp-allstaff ^1.0.0
**Author:** SRP Team (team@srp.one)
**Tags:** github, gcp, bigquery, cicd, developer, code-review
