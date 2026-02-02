---
name: weekly-report
description: Generate weekly work report from GitHub and Lark data (周报生成 - 从 GitHub 和飞书数据自动生成周报)
---

# Weekly Report Generator (周报生成器)

自动从 GitHub 提交记录和飞书文档生成周报。

Automatically generate weekly work reports from GitHub commits/PRs and Lark documents.

## Quick Start

### Generate Weekly Report (生成周报)

```
帮我生成上周的周报
Generate my weekly report for last week
帮我总结过去一周的工作
```

## Key Features

### 1. GitHub Data Collection (GitHub 数据收集)

Collect PRs, issues, and commits authored by user:

**Available MCP Tools:**
- `mcp__plugin_github_github__search_pull_requests` - Search PRs by author
- `mcp__plugin_srp-developer_github__search_issues` - Search issues by author
- `mcp__plugin_github_github__list_commits` - List commits in repos

**Search Query Format:**
```
author:<username> [org:<organization>] created:>=<start_date>
```

### 2. Lark Document Collection (飞书文档收集)

Collect documents the user participated in:

**Available MCP Tools:**
- `mcp__plugin_srp-allstaff_lark__docx_builtin_search` - Search cloud documents
- `mcp__plugin_srp-allstaff_lark__docx_v1_document_rawContent` - Get document content

**Key Parameters:**
- `useUAT: true` - Use user access token
- `search_key` - Keywords to search
- `count` - Number of results (max 50)

### 3. Report Generation (报告生成)

Generate structured weekly report in markdown format.

## Workflow

```
1. Clarify Parameters (确认参数)
   - Time range: Monday to Sunday of previous week
   - GitHub username
   - GitHub organization (if applicable)

2. Collect GitHub Data (收集 GitHub 数据)
   - Search PRs: author:<username> created:>=<start_date>
   - Extract: date, repo, PR number, title, summary

3. Collect Lark Documents (收集飞书文档)
   - Search recent documents
   - Filter user-participated documents (meetings, authored docs)
   - Extract key information from content

4. Generate Report (生成报告)
   - Format as structured markdown
   - Present to user for review

5. Iterate (迭代)
   - Adjust based on user feedback
```

## Report Format (报告格式)

```markdown
## 周报 (YYYY-MM-DD ~ YYYY-MM-DD)

### 一、代码开发工作

| 日期 | 仓库 | PR | 内容摘要 |
|------|------|-----|----------|
| MM-DD | repo-name | #N | Brief description |

### 二、文档/会议工作

**MM-DD** Activity Name
- Key point 1
- Key point 2

### 三、下周计划

(User provided or left blank)
```

## Examples (示例)

### Example 1: Basic Weekly Report (基础周报)

**User:**
```
帮我生成上周的周报，我的 GitHub 用户名是 zhangsan，公司是 SerendipityOneInc
```

**Assistant Response:**
```markdown
让我收集你上周 (01-27 ~ 02-02) 的工作数据。

<collects GitHub PRs>
<collects Lark documents>

## 周报 (2026-01-27 ~ 2026-02-02)

### 一、代码开发工作

本周共提交 3 个 PR，全部已合并：

| 日期 | 仓库 | PR | 内容摘要 |
|------|------|-----|----------|
| 02-01 | project-a | #42 | 新增用户认证功能 |
| 01-30 | project-b | #18 | 修复登录页面 bug |
| 01-28 | project-a | #40 | 优化数据库查询性能 |

### 二、文档/会议工作

**01-29** 技术分享会
- 分享主题：微服务架构设计
- 参会人数：15 人

**01-27** 团队周会
- 讨论 Q1 OKR 进展
- 确认下周发布计划

需要我调整格式或补充其他内容吗？
```

### Example 2: English Weekly Report

**User:**
```
Generate my weekly report for last week. GitHub: johndoe, Org: MyCompany
```

**Assistant Response:**
```markdown
Let me collect your work data for last week (01-27 ~ 02-02).

<collects data>

## Weekly Report (2026-01-27 ~ 2026-02-02)

### Code Development

2 PRs merged this week:

| Date | Repository | PR | Summary |
|------|------------|-----|---------|
| 02-01 | api-service | #55 | Add rate limiting middleware |
| 01-29 | web-app | #123 | Fix responsive layout issues |

### Documentation & Meetings

**01-30** Architecture Review
- Reviewed microservices migration plan
- Decided on event-driven approach

Would you like me to adjust the format or add more details?
```

## Common Issues (常见问题)

### Issue 1: Wrong Date Range (日期范围错误)

**Problem:** User expects different week definition

**Solution:**
- Confirm: "周报的时间范围是周一到周日，上一周是 MM-DD ~ MM-DD，对吗？"
- Adjust if user specifies different range

### Issue 2: Missing GitHub Organization (缺少组织名)

**Problem:** No PRs found in personal repos

**Solution:**
- Ask: "你主要的工作代码是在哪个 GitHub organization 下的？"
- Search with `org:<organization>` filter

### Issue 3: Lark Authorization Expired (飞书授权过期)

**Problem:** Lark API returns auth error

**Solution:**
- Provide authorization URL from error message
- Wait for user to complete authorization
- Retry data collection

### Issue 4: Too Much Detail (内容过多)

**Problem:** Report is too long

**Solution:**
- Summarize PR descriptions, don't copy entire body
- Group similar activities
- Focus on key achievements

## Tips for Effective Use (使用技巧)

1. **Prepare GitHub username** - Have your GitHub username and organization ready
2. **Check Lark authorization** - Ensure Lark MCP is authorized before starting
3. **Provide feedback** - Tell the assistant to adjust format if needed
4. **Add context** - Mention important meetings or activities not captured automatically

## Limitations (限制)

- **Lark messages** - Message history requires additional permissions that may not be available
- **Private repos** - Only repos you have access to will be searched
- **Document content** - Only documents you own or participated in are accessible

## Related Skills (相关技能)

- `lark-docs`: Access Lark cloud documents
- `github-integration`: GitHub PR and issue management
