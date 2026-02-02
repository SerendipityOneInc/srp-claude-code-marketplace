---
name: weekly-report
description: Generate weekly work report from GitHub, Linear, and Lark data (周报生成 - 从 GitHub、Linear 和飞书数据自动生成周报)
---

# Weekly Report Generator (周报生成器)

自动从 GitHub 提交记录、Linear 任务和飞书文档生成周报。

Automatically generate weekly work reports from GitHub commits/PRs, Linear issues, and Lark documents.

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
- `owner_ids` - Filter by document owner (optional)

**IMPORTANT: Multi-Strategy Search (重要：多策略搜索)**

飞书文档的 owner 可能不是用户本人（如智能纪要由会议系统自动生成），因此需要使用多种搜索策略：

**Strategy 1: Search by user name (按用户名搜索)**
```json
{
  "search_key": "智能纪要 <用户中文名>",
  "count": 50
}
```
This captures meeting notes where the user was a presenter or key participant.

**Strategy 2: Search by owner_id (按文档所有者搜索)**
```json
{
  "search_key": "",
  "owner_ids": ["<user_open_id>"],
  "count": 50
}
```
This captures documents created by the user directly.

**Strategy 3: Search by date keywords (按日期关键词搜索)**
```json
{
  "search_key": "2026年1月 会议 培训",
  "count": 50
}
```
Combined with manual filtering by date range.

**Documents to look for (需要关注的文档类型):**
- 智能纪要 / AI notes - Auto-generated meeting summaries (owner is often NOT the user)
- Meeting transcript - Meeting transcriptions
- 培训 / Training materials - Presentations and training sessions
- 分享 / Tech sharing - Knowledge sharing sessions

**Search Strategy (搜索策略):**

IMPORTANT: Must perform multiple searches to capture all meeting-related documents:

1. **User-hosted meetings/trainings (用户主讲的会议/培训):**
   - Search: `智能纪要 {用户中文名}` (e.g., "智能纪要 朱广彬")
   - Search: `AI notes {用户中文名}` (e.g., "AI notes 朱广彬")
   - These capture: 培训、分享会、技术讲座等用户作为主讲人的会议

2. **Regular team meetings (常规团队会议):**
   - Search: `双周会 会议` - Biweekly meetings
   - Search: `周会 会议纪要` - Weekly meetings
   - Filter by date in title (e.g., "Jan 27, 2026" or "2026年1月27日")

3. **Other work documents (其他工作文档):**
   - Search: `培训 分享` - Training and sharing sessions
   - Search user-specific keywords based on their role

**Date Filtering:**
- Check document titles for date patterns matching the report period
- Common formats: "YYYY年M月D日", "Jan DD, YYYY", "MM-DD"

### 3. Linear Issue Collection (Linear 任务收集)

Collect issues the user worked on:

**Available MCP Tools (via Rube):**
- `LINEAR_GET_CURRENT_USER` - Get current user ID
- `LINEAR_LIST_LINEAR_ISSUES` - List issues by assignee/status
- `LINEAR_RUN_QUERY_OR_MUTATION` - GraphQL for complex queries

**Three queries to run:**
1. Completed issues: assignee_id="me", filter by completedAt in date range
2. In-progress issues: assignee_id="me", status not Done
3. Created issues: GraphQL filter by creator and createdAt

**Status mapping:**
- completed → [Done]
- started → [In Progress]
- unstarted → [Todo]
- backlog → [Backlog]
- canceled → [Canceled]

### 4. Report Generation (报告生成)

Generate structured weekly report and publish to Lark document.

**Available MCP Tools:**
- `mcp__plugin_srp-allstaff_lark__docx_builtin_import` - Import markdown as Lark document

**Usage:**
```json
{
  "useUAT": true,
  "data": {
    "file_name": "周报_<中文名>_MMDD-MMDD",
    "markdown": "<markdown content>"
  }
}
```

**Response contains:**
- `url` - Direct link to the created Lark document
- `token` - Document ID for future reference

## Workflow

```
1. Clarify Parameters (确认参数)
   - Time range: Monday to Sunday of previous week
   - GitHub username
   - GitHub organization (if applicable)
   - User's Chinese name (用户中文名) - for searching Lark meeting notes

2. Collect GitHub Data (收集 GitHub 数据)
   - Search PRs: author:<username> created:>=<start_date>
   - Extract: date, repo, PR number, title, summary

2.5 Collect Linear Issues (收集 Linear 任务)
    - Get current user ID via LINEAR_GET_CURRENT_USER
    - Query completed issues in date range (state.type = "completed", completedAt within range)
    - Query in-progress issues assigned to user (state.type in ["started", "unstarted"])
    - Query issues created by user in date range (GraphQL with creator filter)
    - Deduplicate and group by status for display

3. Collect Lark Documents (收集飞书文档) - IMPORTANT: Multiple searches required!
   a. Search user-hosted meetings: "智能纪要 {用户中文名}"
   b. Search user-hosted meetings: "AI notes {用户中文名}"
   c. Search user-hosted trainings: "培训 {用户中文名}"
   d. Search team meetings: "双周会 会议", "周会 会议纪要"
   e. Search with owner_ids for user-created documents
   f. Filter documents by date in title matching report period
   g. Read document content for relevant meetings
   h. Extract key information (topics, participants, action items)

4. Generate Report (生成报告)
   - Format as structured markdown
   - Separate sections for: 主讲的培训/分享, 参与的会议
   - Present to user for review

5. Publish to Lark (发布到飞书)
   - Use `mcp__plugin_srp-allstaff_lark__docx_builtin_import` to create Lark document
   - File name format: "周报_<中文名>_MMDD-MMDD" (飞书限制文件名最多27字符)
   - Return the Lark document URL to user

6. Iterate (迭代)
   - Adjust based on user feedback
```

## Report Format (报告格式)

```markdown
## 周报 (YYYY-MM-DD ~ YYYY-MM-DD)

### 一、代码开发工作

| 日期 | 仓库 | PR | 内容摘要 |
|------|------|-----|----------|
| MM-DD | repo-name | #N | Brief description |

### 二、项目任务 (Linear)

**本周完成：**
- [Done] Issue title

**进行中：**
- [In Progress] Issue title

**本周新建：**
- [Backlog] Issue title

### 三、培训/会议工作

#### 主讲的培训/分享 (如有)

**MM-DD** Training/Sharing Title (主讲)
- 参会人数：N 人
- 培训内容要点
- 待办事项（如有）

#### 参与的会议

**MM-DD** Meeting Name
- Key discussion point 1
- Key discussion point 2
- Action items assigned to user

### 四、下周计划

(User provided or left blank)
```

## Examples (示例)

### Example 1: Basic Weekly Report (基础周报)

**User:**
```
帮我生成上周的周报，我的 GitHub 用户名是 zhangsan，公司是 SerendipityOneInc，中文名是张三
```

**Assistant Response:**
```markdown
让我收集你上周 (01-27 ~ 02-02) 的工作数据。

<collects GitHub PRs>
<searches Lark: "智能纪要 张三">
<searches Lark: "AI notes 张三">
<searches Lark: "双周会 会议">
<reads relevant meeting documents>

## 周报 (2026-01-27 ~ 2026-02-02)

### 一、代码开发工作

本周共提交 3 个 PR，全部已合并：

| 日期 | 仓库 | PR | 内容摘要 |
|------|------|-----|----------|
| 02-01 | project-a | #42 | 新增用户认证功能 |
| 01-30 | project-b | #18 | 修复登录页面 bug |
| 01-28 | project-a | #40 | 优化数据库查询性能 |

### 二、培训/会议工作

#### 主讲的培训/分享

**01-29** 微服务架构设计分享 (主讲)
- 参会人数：15 人
- 培训内容：微服务拆分原则、服务治理、链路追踪
- 待办：整理分享材料发给参会人员

#### 参与的会议

**01-27** Infra 双周会
- 讨论 Q1 OKR 进展
- 确认下周发布计划
- Action: 跟进 XX 系统上线

飞书文档已创建：https://starquest.feishu.cn/docx/xxxxxx

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

Lark document created: https://starquest.feishu.cn/docx/xxxxxx

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

### Issue 5: Missing Meeting Notes (漏掉会议纪要)

**Problem:** User participated in meetings/trainings but they don't appear in report

**Root Cause:** 智能纪要 (AI notes) and meeting transcripts are auto-generated by Lark. The document owner is often the meeting creator or system account, NOT the participant.

**Solution:**
- MUST search by user's Chinese name: `search_key: "智能纪要 <用户中文名>"`
- MUST search for trainings: `search_key: "培训 <用户中文名>"`
- Also search: `search_key: "<用户中文名> 分享"` for tech sharing sessions
- Filter results by date range manually (check document title for date)
- Don't rely solely on `owner_ids` filter

**Example:**
```json
// Search for meeting notes where 朱广彬 presented
{"search_key": "智能纪要 朱广彬", "count": 50, "useUAT": true}

// Search for trainings by 朱广彬
{"search_key": "培训 朱广彬", "count": 50, "useUAT": true}

// Search for tech sharing by 朱广彬
{"search_key": "朱广彬 分享 best practice", "count": 50, "useUAT": true}
```

### Issue 6: Linear Authorization Required (Linear 授权未配置)

**Problem:** Linear tools return auth error or no data

**Solution:**
- Ensure Rube is connected with Linear integration
- Check that LINEAR tools are available via `RUBE_SEARCH_TOOLS`
- If not authorized, ask user to configure Linear connection in Rube

### Issue 7: Empty Linear Results (Linear 结果为空)

**Problem:** No Linear issues found but user has activity

**Solution:**
- Verify date range matches Linear's date format
- Check assignee filter - use "me" or actual user ID
- For created issues, use GraphQL query with creator filter
- Confirm user is using the correct Linear workspace

## Tips for Effective Use (使用技巧)

1. **Prepare GitHub username** - Have your GitHub username and organization ready
2. **Provide Chinese name** - Your Chinese name is needed to search Lark meeting notes and name the document (e.g., "朱广彬")
3. **Check Lark authorization** - Ensure Lark MCP is authorized before starting
4. **Provide feedback** - Tell the assistant to adjust format if needed
5. **Add context** - Mention important meetings or activities not captured automatically
6. **Auto-publish to Lark** - The report will be automatically published as a Lark document with a shareable link

## Limitations (限制)

- **Lark messages** - Message history requires additional permissions that may not be available
- **Private repos** - Only repos you have access to will be searched
- **Document content** - Only documents you own or participated in are accessible
- **Meeting notes ownership** - 智能纪要 (AI notes) are often owned by the meeting system, not the participant. Always search by user name in addition to owner_id.
- **Lark Calendar** - Lark calendar API is not currently integrated. Use document search to find meeting records instead.

## Related Skills (相关技能)

- `lark-docs`: Access Lark cloud documents
- `github-integration`: GitHub PR and issue management
