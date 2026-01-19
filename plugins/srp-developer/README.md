# SRP Developer Plugin

Developer plugin providing GitHub integration, GCP BigQuery access, and development tools.

## Overview

The SRP Developer plugin provides essential development tools including GitHub code review, PR management, BigQuery data access, and more.

## Features

#### 🐙 GitHub Integration
- View and search pull requests
- Code review and comments
- Issue tracking and management
- Repository information
- Commit history and diffs
- CI/CD status checking

#### ☁️ GCP Developer Access
- BigQuery data queries
- Table schema viewing
- Data analysis and aggregation
- **Read-only**: No data modification allowed

## Prerequisites

### 1. Set Up Environment Variables

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

### 2. GCP Authentication

```bash
gcloud auth application-default login
```

## Installation

```bash
# Navigate to marketplace directory
cd ~/Downloads/srp-claude-code-marketplace

# Install the plugin
/plugin install srp-developer@srp-claude-code-marketplace
```

## Usage

### Available Commands

The plugin provides the following commands with the `srp:` namespace:

| Command | Alias | Skill | Description |
|---------|-------|-------|-------------|
| `srp:github` | `srp:gh` | github-integration | GitHub integration for code review and PR management |
| `srp:gcp` | `srp:bq` | gcp-developer | GCP access for developers - BigQuery and data analysis |

**Usage examples:**
```bash
# Full command names
srp:github
srp:gcp

# Short aliases
srp:gh
srp:bq

# Original skill names (also work)
/github-integration
/gcp-developer
```

### Skill 1: GitHub Integration

**Activate the skill:**
```bash
srp:github  # or srp:gh or /github-integration
```

**Example prompts:**

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

### Skill 2: GCP Developer Access

**Activate the skill:**
```bash
srp:gcp  # or srp:bq or /gcp-developer
```

**Example prompts:**

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

## Configuration

### MCP Servers

The plugin configures the following MCP servers in `.mcp.json`:

**Configuration file location:**
```
plugins/srp-developer/.mcp.json
```

**GitHub MCP Server:**
- Requires `GITHUB_TOKEN` environment variable
- Provides access to GitHub repositories, PRs, issues

**BigQuery MCP Server:**
- Requires `GCP_PROJECT_ID` and `GCP_LOCATION` environment variables
- Requires GCP authentication: `gcloud auth application-default login`
- Provides read-only access to BigQuery datasets

**Full configuration:**
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "bigquery": {
      "command": "uvx",
      "args": [
        "mcp-server-bigquery",
        "--project", "${GCP_PROJECT_ID}",
        "--location", "${GCP_LOCATION}"
      ],
      "env": {}
    }
  }
}
```

## Troubleshooting

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

## Permissions & Security

### GitHub Access
- Read repositories, PRs, issues
- Create and update issues
- Submit code reviews
- Cannot merge PRs or modify repo settings

### GCP Access
- **Read-only**: Query data, view schemas
- Cannot modify data (INSERT, UPDATE, DELETE)
- Cannot create or drop tables
- All queries are logged

### Best Practices
- Only access data you need
- Use LIMIT for exploratory queries
- Follow company data policies
- Do not share sensitive data
- Use environment variables for credentials

## Examples

### Example 1: PR Review Workflow

```bash
/github-integration

Prompt: "Review PR #12 in SerendipityOneInc/srp-claude-code-marketplace"

Claude will:
1. Get PR details and changed files
2. Check CI/CD build status
3. Review code changes
4. Provide feedback and suggestions
5. (Optional) Submit review comments
```

### Example 2: Data Analysis

```bash
/gcp-developer

Prompt: "Analyze the top 10 most active event types from analytics.user_events table yesterday"

Claude will:
1. Query the analytics.user_events table
2. Aggregate by event_type
3. Count active users per type
4. Present results in a table
5. Provide insights and recommendations
```

## Limitations

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

## Support

### Documentation
- Plugin: `plugins/srp-developer/README.md` (this file)
- Skills:
  - `plugins/srp-developer/skills/github-integration/SKILL.md`
  - `plugins/srp-developer/skills/gcp-developer/SKILL.md`

### Getting Help
- Internal support: Contact SRP Team (infra@srp.one)
- GitHub API docs: https://docs.github.com/rest
- BigQuery SQL reference: https://cloud.google.com/bigquery/docs/reference/standard-sql

## Version History

### v1.0.1 (2026-01-19)
- Changed owner email to infra@srp.one

### v1.0.0 (2026-01-16)
- Initial release
- GitHub Integration skill
- GCP Developer skill (BigQuery)

## License

Internal use only by SRP (Serendipity One Inc.) employees.

---

**Plugin Name:** srp-developer
**Version:** 1.0.1
**Author:** SRP Team (infra@srp.one)
**Tags:** github, gcp, bigquery, cicd, developer, code-review
