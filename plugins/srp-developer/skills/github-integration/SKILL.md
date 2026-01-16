---
name: github-integration
description: GitHub integration for code review, PR management, and issue tracking (GitHub集成：代码审查、PR管理、Issue追踪)
---

# GitHub Integration (GitHub 集成)

为开发者提供 GitHub 集成功能，包括代码审查、PR 管理、Issue 追踪、仓库信息查看等。

Provides GitHub integration for developers, including code review, PR management, issue tracking, and repository information.

## Quick Start

### View Pull Requests (查看 PR)

```
显示 SerendipityOneInc/srp-claude-code-marketplace 的 PR 列表
List open PRs in SerendipityOneInc/srp-claude-code-marketplace
```

### Code Review (代码审查)

```
审查 PR #5 的代码变更
Review code changes in PR #5
```

### Manage Issues (管理 Issue)

```
显示所有未关闭的 issue
List all open issues with label "bug"
```

## Key Features

### 1. Pull Request Management (PR 管理)

View, search, and manage pull requests:

**Available MCP Tools:**
- `mcp__github__list_pull_requests` - List PRs in a repository
- `mcp__github__search_pull_requests` - Search PRs with filters
- `mcp__github__get_pull_request` - Get PR details
- `mcp__github__get_pull_request_files` - Get changed files
- `mcp__github__get_pull_request_status` - Get CI/CD status
- `mcp__github__get_pull_request_comments` - Get review comments
- `mcp__github__update_pull_request` - Update PR (title, description, etc.)

**Common Operations:**
- List open/closed PRs
- Filter by author, base branch, labels
- View PR diff and changed files
- Check CI/CD build status
- Read review comments

### 2. Code Review (代码审查)

Review code changes and provide feedback:

**Available MCP Tools:**
- `mcp__github__create_pull_request_review` - Create a review
- `mcp__github__add_comment_to_pending_review` - Add review comments
- `mcp__github__get_pull_request_reviews` - Get existing reviews

**Review Workflow:**
1. Get PR details and changed files
2. Review code changes
3. Add line-specific comments
4. Submit review (approve/request changes/comment)

### 3. Issue Management (Issue 管理)

Track and manage issues:

**Available MCP Tools:**
- `mcp__github__list_issues` - List issues
- `mcp__github__search_issues` - Search issues
- `mcp__github__get_issue` - Get issue details
- `mcp__github__issue_read` - Get issue comments/sub-issues
- `mcp__github__issue_write` - Create/update issues
- `mcp__github__add_issue_comment` - Add comments

**Common Operations:**
- List open issues
- Search by labels, assignee, milestone
- Create new issues
- Update issue status
- Add comments to discussions

### 4. Repository Information (仓库信息)

View repository details and statistics:

**Available MCP Tools:**
- `mcp__github__search_repositories` - Search repositories
- `mcp__github__get_file_contents` - Get file contents
- `mcp__github__list_branches` - List branches
- `mcp__github__list_commits` - List commits
- `mcp__github__get_commit` - Get commit details

**Common Operations:**
- Search repositories
- View file contents
- Check branch list
- Review commit history
- View commit changes

## Common Workflows

### Workflow 1: Review a Pull Request

```markdown
1. User: "审查 PR #10"
2. Get PR details: mcp__github__get_pull_request
   - owner: "SerendipityOneInc"
   - repo: "project-name"
   - pull_number: 10
3. Get changed files: mcp__github__get_pull_request_files
4. Get build status: mcp__github__get_pull_request_status
5. Review code and provide feedback
6. User can approve or request changes
```

### Workflow 2: Search and Track Issues

```markdown
1. User: "显示所有标记为 bug 的未解决 issue"
2. Search issues: mcp__github__search_issues
   - query: "is:open label:bug repo:owner/repo"
3. Display issue list with titles and links
4. User can select specific issues to view details
5. Get issue details: mcp__github__get_issue
```

### Workflow 3: Check CI/CD Status

```markdown
1. User: "检查 PR #15 的构建状态"
2. Get PR status: mcp__github__get_pull_request_status
   - owner: "SerendipityOneInc"
   - repo: "project-name"
   - pull_number: 15
3. Display build/check results
4. Show failed checks if any
```

## Examples (示例)

### Example 1: List Open PRs (列出开放的 PR)

**User (Chinese):**
```
显示 SerendipityOneInc/srp-claude-code-marketplace 仓库中所有开放的 PR
```

**Assistant Response:**
```markdown
I'll list all open PRs in the srp-claude-code-marketplace repository.

<uses mcp__github__list_pull_requests>
- owner: "SerendipityOneInc"
- repo: "srp-claude-code-marketplace"
- state: "open"

Found 3 open pull requests:

1. **Feature: Add developer plugin** (#12)
   - Author: @allenz-srp
   - Created: 2026-01-15
   - Status: ✓ All checks passed
   - [View PR](https://github.com/SerendipityOneInc/srp-claude-code-marketplace/pull/12)

2. **Fix: Update marketplace JSON schema** (#11)
   - Author: @developer
   - Created: 2026-01-14
   - Status: ⚠️ 1 check pending
   - [View PR](https://github.com/SerendipityOneInc/srp-claude-code-marketplace/pull/11)

3. **Docs: Improve README** (#10)
   - Author: @contributor
   - Created: 2026-01-13
   - Status: ✗ 2 checks failed
   - [View PR](https://github.com/SerendipityOneInc/srp-claude-code-marketplace/pull/10)

Would you like me to review any of these PRs?
```

### Example 2: Create Issue (创建 Issue)

**User (English):**
```
Create an issue in SerendipityOneInc/srp-claude-code-marketplace: "Add DevOps plugin" with label "enhancement"
```

**Assistant Response:**
```markdown
I'll create a new issue in the repository.

<uses mcp__github__issue_write>
- method: "create"
- owner: "SerendipityOneInc"
- repo: "srp-claude-code-marketplace"
- title: "Add DevOps plugin"
- body: "Create a new DevOps plugin with Kubernetes management and monitoring capabilities."
- labels: ["enhancement"]

✅ Issue created successfully!

**Issue #25: Add DevOps plugin**
- Status: Open
- Labels: enhancement
- Link: https://github.com/SerendipityOneInc/srp-claude-code-marketplace/issues/25

The issue has been created and is now visible to all repository collaborators.
```

### Example 3: Check PR Build Status (检查 PR 构建状态)

**User (Chinese):**
```
PR #12 的构建状态如何？
```

**Assistant Response:**
```markdown
让我检查 PR #12 的构建状态。

<uses mcp__github__get_pull_request_status>
- owner: "SerendipityOneInc"
- repo: "srp-claude-code-marketplace"
- pull_number: 12

**PR #12 构建状态:**

✅ **All checks passed** (3/3)

1. ✓ **validate-pr** - Passed (2m 15s)
   - JSON validation
   - Schema validation
   - Repository accessibility check

2. ✓ **lint** - Passed (1m 30s)
   - Code style check
   - Markdown linting

3. ✓ **test** - Passed (3m 45s)
   - Unit tests
   - Integration tests

**Summary:** All checks passed successfully. The PR is ready for review and merge.
```

## Important Notes

### Permission Requirements (权限要求)
- Requires GitHub authentication (usually via GITHUB_TOKEN)
- Read permissions: View repos, PRs, issues
- Write permissions: Create/update issues, submit reviews
- Admin permissions: Merge PRs, manage settings (not included in this skill)

### Rate Limits (速率限制)
- GitHub API has rate limits (5000 requests/hour for authenticated)
- Use pagination for large result sets
- Cache frequently accessed data when possible

### Repository Format (仓库格式)
- Always specify owner and repo separately
- Format: `owner/repo` → owner: "SerendipityOneInc", repo: "project-name"
- Repository names are case-sensitive

### Search Syntax (搜索语法)
GitHub search supports powerful query syntax:
- `is:pr` - Pull requests only
- `is:issue` - Issues only
- `is:open` / `is:closed` - Status filter
- `label:bug` - Filter by label
- `author:username` - Filter by author
- `repo:owner/name` - Specific repository

## Error Handling

Common errors and solutions:

1. **"Not Found" (未找到)**
   - Repository doesn't exist or is private
   - PR/Issue number is invalid
   - Check repository name spelling

2. **"Permission denied" (权限被拒绝)**
   - Need to authenticate with GitHub
   - Set GITHUB_TOKEN environment variable
   - Check token has required permissions

3. **"Rate limit exceeded" (超出速率限制)**
   - Too many API requests
   - Wait for rate limit reset
   - Use pagination to reduce requests

## Tips for Effective Use

1. **Use search for complex queries**: More efficient than list + filter
2. **Check build status**: Always verify CI/CD before reviewing
3. **Batch operations**: Group related actions together
4. **Use filters**: Narrow down results with labels, authors, status
5. **Link references**: Always provide GitHub links for easy access

## Related Skills

- `gcp-developer`: Access GCP resources (BigQuery, GCS, GKE)
- Future: `cicd-integration`, `code-quality-tools`

## Prerequisites

### GitHub Authentication

Set up GitHub token as environment variable:
```bash
export GITHUB_TOKEN="ghp_your_github_token_here"
```

**How to create a GitHub token:**
1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Click "Generate new token" (classic)
3. Select scopes: `repo`, `read:user`, `read:org`
4. Copy the token and save it securely
5. Add to environment variables

### MCP Server Configuration

The GitHub MCP server is configured automatically by the plugin:
```json
{
  "github": {
    "type": "stdio",
    "command": "npx",
    "args": ["@modelcontextprotocol/server-github"],
    "env": {}
  }
}
```

## Limitations

- Cannot merge PRs (use GitHub web interface)
- Cannot force push or delete branches
- Cannot manage repository settings
- Cannot create releases or tags
- Review comments are final (cannot edit after submission)

## Future Enhancements

Planned features:
- CI/CD pipeline integration
- Code quality metrics
- Automated code review suggestions
- Integration with Lark for notifications
- Custom workflow automation
