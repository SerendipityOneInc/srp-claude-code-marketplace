# Weekly Report Linear Integration Design

Date: 2026-02-02

## Overview

Add Linear issue tracking to the weekly-report skill, enabling users to include their Linear activity in weekly reports alongside GitHub PRs and Lark meetings.

## Requirements

### Data to Collect

| Type | Filter Criteria | Purpose |
|------|-----------------|---------|
| Completed issues | assignee=me, completedAt in report period | Show accomplishments |
| In-progress issues | assignee=me, status not Done | Show ongoing work |
| Created issues | creator=me, createdAt in report period | Show new initiatives |

### Display Format

- Separate section: "项目任务 (Linear)"
- Simple format: `[Status] Title`
- Grouped by: Completed / In Progress / Newly Created
- Empty groups are hidden

## Technical Design

### MCP Tools (via Rube)

```
LINEAR_GET_CURRENT_USER     - Get authenticated user's ID
LINEAR_LIST_LINEAR_ISSUES   - List issues with filters
LINEAR_RUN_QUERY_OR_MUTATION - GraphQL for complex queries (created issues)
```

### Data Collection Flow

```
1. Get current user ID
   └─> LINEAR_GET_CURRENT_USER
   └─> Extract: user.id

2. Query completed issues (parallel)
   └─> LINEAR_LIST_LINEAR_ISSUES(assignee_id="me")
   └─> Filter: completedAt within date range
   └─> Filter: state.type = "completed"

3. Query in-progress issues (parallel)
   └─> LINEAR_LIST_LINEAR_ISSUES(assignee_id="me")
   └─> Filter: state.type in ["started", "unstarted"]

4. Query created issues (parallel)
   └─> LINEAR_RUN_QUERY_OR_MUTATION
   └─> GraphQL: issues(filter: {creator: {id: {eq: $userId}}, createdAt: {gte: $startDate}})

5. Deduplicate and group results
   └─> Remove duplicates (same issue may appear in multiple queries)
   └─> Group by display category
```

### Report Section Format

```markdown
### 二、项目任务 (Linear)

**本周完成：**
- [Done] Issue title 1
- [Done] Issue title 2

**进行中：**
- [In Progress] Issue title 3
- [Todo] Issue title 4

**本周新建：**
- [Backlog] Issue title 5
```

### Status Label Mapping

| Linear State Type | Display Label |
|-------------------|---------------|
| completed | [Done] |
| started | [In Progress] |
| unstarted | [Todo] |
| backlog | [Backlog] |
| canceled | [Canceled] |

## Implementation

### Files to Modify

1. `plugins/srp-allstaff/skills/weekly-report/SKILL.md`
   - Add "Linear Issue Collection" section in Key Features
   - Update Workflow with Linear data collection step
   - Add Linear section to Report Format template
   - Add Common Issues for Linear (auth, empty results)

### SKILL.md Changes

#### Key Features - Add Section 4:

```markdown
### 4. Linear Issue Collection (Linear 任务收集)

Collect issues the user worked on:

**Available MCP Tools (via Rube):**
- `LINEAR_GET_CURRENT_USER` - Get current user ID
- `LINEAR_LIST_LINEAR_ISSUES` - List issues by assignee/status
- `LINEAR_RUN_QUERY_OR_MUTATION` - GraphQL for complex queries

**Three queries to run:**
1. Completed issues: assignee_id="me", filter by completedAt
2. In-progress issues: assignee_id="me", status not Done
3. Created issues: GraphQL filter by creator and createdAt

**Status mapping:**
- completed → [Done]
- started → [In Progress]
- unstarted → [Todo]
- backlog → [Backlog]
```

#### Workflow - Add Step 2.5:

```markdown
2.5 Collect Linear Issues (收集 Linear 任务)
    - Get current user ID via LINEAR_GET_CURRENT_USER
    - Query completed issues in date range
    - Query in-progress issues assigned to user
    - Query issues created by user in date range
    - Group by status for display
```

#### Report Format - Add Section:

```markdown
### 二、项目任务 (Linear)

**本周完成：**
- [Done] Issue title

**进行中：**
- [In Progress] Issue title

**本周新建：**
- [Backlog] Issue title
```

## Version Update

- srp-allstaff: 1.0.5 → 1.0.6
- marketplace: 1.0.3 → 1.0.4
