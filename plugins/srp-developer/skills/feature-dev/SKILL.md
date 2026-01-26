---
name: feature-dev
description: End-to-end feature development workflow from requirement to staging deployment and PR creation
---

# Feature Development Workflow

End-to-end feature development workflow: from user requirements to code development, testing, staging deployment, and pull request creation.

## Quick Start

```
Develop a feature: Record user login time to database
Add a new feature: Implement rate limiting for API endpoints
Create feature: Add user avatar upload endpoint
```

## Workflow Overview

```
+-----------------------------------------------------------------------+
|                     Feature Development Workflow                       |
+-----------------------------------------------------------------------+
|                                                                        |
|  +----------+    +----------+    +----------+    +----------+         |
|  | 1. Input |---►| 2. Issue |---►| 3. Branch|---►| 4. Dev   |         |
|  | Feature  |    | Create   |    | Create   |    | & Test   |         |
|  +----------+    +----------+    +----------+    +----------+         |
|                                                        |               |
|                                                        v               |
|  +----------+    +----------+    +----------+    +----------+         |
|  | 8. Done  |◄---| 7. Create|◄---| 6. Push  |◄---| 5. Test  |         |
|  |          |    | PR       |    | Code     |    | Pass     |         |
|  +----------+    +----------+    +----------+    +----------+         |
|                       ^                                                |
|                       |                                                |
|              +------------------+                                      |
|              | For Gin/FastAPI: |                                      |
|              | Deploy Staging   |                                      |
|              | Then Create PR   |                                      |
|              +------------------+                                      |
|                                                                        |
+-----------------------------------------------------------------------+
```

## Detailed Steps

### Phase 1: Requirement Input

**User provides feature description:**
- Clear description of the functionality
- Expected behavior and edge cases
- Any specific technical requirements

**Claude will:**
1. Analyze the requirement
2. Ask clarifying questions if needed
3. Summarize understanding before proceeding

### Phase 2: Create GitHub Issue

**Create a well-structured issue:**

```markdown
## Title Format
[Feature] <Brief description>
[Bug Fix] <Brief description>
[Enhancement] <Brief description>

## Issue Body Template
### Description
<Detailed description of the feature>

### Acceptance Criteria
- [ ] Criteria 1
- [ ] Criteria 2

### Technical Notes
<Implementation considerations>
```

**MCP Tools Used:**
- `mcp__github__create_issue` - Create the issue
- `mcp__github__get_issue` - Verify creation

**Example:**
```bash
# Claude will use MCP tool to create issue
mcp__github__create_issue:
  owner: "SerendipityOneInc"
  repo: "project-name"
  title: "[Feature] Add user login time tracking"
  body: "## Description\n..."
  labels: ["enhancement"]
```

### Phase 3: Create Feature Branch

**Branch naming convention:**
```
<issue-number>-<brief-description>
Example: 42-add-login-tracking
```

**Steps:**
1. Fetch latest main branch
2. Create feature branch from main
3. Link branch to issue (visible in GitHub issue page)

**Commands:**
```bash
# Fetch latest
git fetch origin main

# Create and checkout feature branch
git checkout -b <issue-number>-<feature-name> origin/main

# Push branch to remote (links to issue automatically)
git push -u origin <issue-number>-<feature-name>
```

**Important:** The branch name starting with issue number automatically links it to the issue in GitHub.

### Phase 4: Development & Unit Tests

**Claude will:**
1. **Analyze Codebase:**
   - Understand project structure
   - Identify relevant files to modify
   - Find existing patterns to follow

2. **Implement Feature:**
   - Write clean, maintainable code
   - Follow existing code conventions
   - Add appropriate comments

3. **Write Unit Tests:**
   - Create test cases for new functionality
   - Cover edge cases
   - Follow existing test patterns

**Code Quality Checklist:**
- [ ] Code follows project style guide
- [ ] No hardcoded values (use config/env)
- [ ] Error handling implemented
- [ ] Unit tests cover main scenarios
- [ ] No security vulnerabilities introduced

### Phase 5: Run Tests

**Test Execution:**

```bash
# Go projects
go test ./... -v

# Python projects
pytest -v

# Node.js projects
npm test
```

**If tests fail:**
1. Analyze failure messages
2. Fix the issues
3. Re-run tests
4. Repeat until all pass

**If no tests exist:** Skip this step and proceed to push.

### Phase 6: Push Code

```bash
# Stage changes
git add <specific-files>

# Commit with descriptive message
git commit -m "feat(scope): description

- Detail 1
- Detail 2

Closes #<issue-number>"

# Push to remote
git push origin <branch-name>
```

**Commit Message Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### Phase 7: Deployment Decision

**Check project type:**

```bash
# Check for Go Gin project
ls go.mod && grep -q "github.com/gin-gonic/gin" go.mod

# Check for FastAPI project
ls requirements.txt && grep -q "fastapi" requirements.txt
# Or
ls pyproject.toml && grep -q "fastapi" pyproject.toml
```

**Decision Tree:**

```
Is Gin or FastAPI service?
+-- NO  --> Create PR --> End
+-- YES --> Deploy Staging --> Create PR --> End
```

### Phase 7a: Non-Service Projects

**Create Pull Request:**

```bash
# Using gh CLI
gh pr create \
  --title "feat: <description>" \
  --body "## Summary
- <changes>

## Related Issue
Closes #<issue-number>

## Test Plan
- [ ] Tests pass
- [ ] Manual testing done" \
  --base main
```

**Workflow ends here for non-service projects.**

### Phase 8: Staging Deployment (Gin/FastAPI Services Only)

#### Step 8.1: Check for staging branch

```bash
# Check if staging branch exists on remote
git ls-remote --heads origin staging
```

#### Step 8.2a: If staging branch EXISTS

```bash
# Delete local staging if exists
git branch -D staging 2>/dev/null || true

# Fetch and checkout latest staging
git fetch origin staging
git checkout -b staging origin/staging

# Merge feature branch
git merge <feature-branch> --no-edit

# Push staging (triggers GitHub Action)
git push origin staging
```

#### Step 8.2b: If staging branch DOES NOT EXIST

```bash
# List existing beta tags
git tag -l "*beta*" | sort -V | tail -5

# Determine next version
# If no beta tags: v0.0.1-beta.1
# If exists v0.0.1-beta.3: v0.0.1-beta.4

# Create and push new tag
git tag <new-version>
git push origin <new-version>
```

**Tag Version Logic:**
```
No beta tags     --> v0.0.1-beta.1
v0.0.1-beta.1    --> v0.0.1-beta.2
v0.0.1-beta.3    --> v0.0.1-beta.4
v0.1.0-beta.5    --> v0.1.0-beta.6
```

### Phase 9: Monitor GitHub Actions

**Check deployment status:**

```bash
# Using gh CLI to check workflow runs
gh run list --limit 5

# Get status of latest run
gh run view <run-id>

# Watch run in real-time
gh run watch <run-id>
```

**MCP Tools:**
- `mcp__github__get_pull_request_status` - Check CI status

**If deployment fails:**
1. Get error logs: `gh run view <run-id> --log-failed`
2. Analyze the failure
3. Fix issues on feature branch
4. Run tests locally
5. Re-merge to staging or create new tag
6. Monitor again

**Retry loop until success:**
```
+---------------+
| Deploy Fails  |
+------+--------+
       v
+---------------+
| Analyze Logs  |
+------+--------+
       v
+---------------+
| Fix on        |
| Feature       |
+------+--------+
       v
+---------------+
| Run Tests     |
+------+--------+
       v
+---------------+
| Re-deploy     |<--------+
+------+--------+         |
       v                  |
   Success? ----NO--------+
       |
      YES
       v
+---------------+
| Create PR     |
+------+--------+
       v
+---------------+
| Done!         |
+---------------+
```

### Phase 10: Create Pull Request (After Staging Success)

**For Gin/FastAPI services, after staging deployment succeeds:**

```bash
# Check if PR already exists
gh pr list --head <feature-branch>

# If no PR exists, create one
gh pr create \
  --title "feat: <description>" \
  --body "## Summary
- <changes>

## Related Issue
Closes #<issue-number>

## Staging Deployment
- [x] Deployed to staging
- [x] GitHub Actions passed

## Test Plan
- [ ] Staging environment verified
- [ ] Ready for production review" \
  --base main
```

**Important:** Always create PR after staging deployment succeeds so the code can be reviewed and merged to main for production release.

## Complete Example Workflow

### Example: Add Login Time Tracking Feature

**User Input:**
```
Develop a feature: Record user login time to database and return last login time in user info API
```

**Claude Execution:**

```markdown
## Step 1: Understand Requirement
- Record login timestamp when user logs in
- Store in database
- Return last_login_time in user info API

## Step 2: Create GitHub Issue

<uses mcp__github__create_issue>
- owner: "SerendipityOneInc"
- repo: "user-service"
- title: "[Feature] Record and display user login time"
- body: |
    ## Description
    Record user login timestamp and return it in user info API.

    ## Acceptance Criteria
    - [ ] Store login_time in users table
    - [ ] Update login_time on each login
    - [ ] Return last_login_time in GET /api/user endpoint

    ## Technical Notes
    - Add login_time column to users table
    - Modify login handler to update timestamp
    - Update user info response struct
- labels: ["enhancement"]

Created: Issue #42

## Step 3: Create Feature Branch

$ git fetch origin main
$ git checkout -b 42-login-time-tracking origin/main
$ git push -u origin 42-login-time-tracking

Branch 42-login-time-tracking created and linked to Issue #42

## Step 4: Development

### 4.1 Database Migration
Created: migrations/20260126_add_login_time.sql

### 4.2 Model Update
Modified: models/user.go
- Added LoginTime field

### 4.3 Handler Update
Modified: handlers/auth.go
- Update login_time on successful login

### 4.4 API Response Update
Modified: handlers/user.go
- Include last_login_time in response

### 4.5 Unit Tests
Created: handlers/auth_test.go
- TestLoginUpdatesLoginTime
- TestLoginTimeFormat

## Step 5: Run Tests

$ go test ./... -v
PASS
ok  user-service/handlers  1.234s

All tests passed!

## Step 6: Push Code

$ git add .
$ git commit -m "feat(auth): record user login time

- Add login_time column to users table
- Update login_time on successful authentication
- Return last_login_time in user info API

Closes #42"
$ git push origin 42-login-time-tracking

## Step 7: Check Project Type

Detected: Gin service (github.com/gin-gonic/gin in go.mod)
--> Proceed to staging deployment

## Step 8: Deploy to Staging

$ git ls-remote --heads origin staging
refs/heads/staging exists

$ git branch -D staging
$ git fetch origin staging
$ git checkout -b staging origin/staging
$ git merge 42-login-time-tracking --no-edit
$ git push origin staging

Staging deployment triggered!

## Step 9: Monitor GitHub Actions

$ gh run list --limit 1
STATUS  NAME           BRANCH
OK      Deploy Staging staging

Deployment successful!

## Step 10: Create Pull Request

$ gh pr list --head 42-login-time-tracking
No pull requests found.

$ gh pr create \
  --title "feat(auth): record user login time" \
  --body "## Summary
- Add login_time column to users table
- Update login_time on successful authentication
- Return last_login_time in user info API

## Related Issue
Closes #42

## Staging Deployment
- [x] Deployed to staging
- [x] GitHub Actions passed

## Test Plan
- [x] Unit tests pass
- [x] Staging environment verified" \
  --base main

PR #43 created: https://github.com/SerendipityOneInc/user-service/pull/43

## Summary
- Issue #42 created and linked
- Feature branch: 42-login-time-tracking
- Code changes: 4 files modified, 1 migration added
- Tests: All passing
- Staging: Deployed successfully
- PR #43: Created and ready for review
```

## MCP Tools Reference

### Issue Management
| Tool | Purpose |
|------|---------|
| `mcp__github__create_issue` | Create new issue |
| `mcp__github__get_issue` | Get issue details |
| `mcp__github__update_issue` | Update issue status |
| `mcp__github__add_issue_comment` | Add progress comments |

### Branch & PR Management
| Tool | Purpose |
|------|---------|
| `mcp__github__create_branch` | Create feature branch |
| `mcp__github__create_pull_request` | Create PR |
| `mcp__github__list_pull_requests` | List existing PRs |
| `mcp__github__get_pull_request_status` | Check CI status |

### Code Operations
| Tool | Purpose |
|------|---------|
| `mcp__github__get_file_contents` | Read existing code |
| `mcp__github__list_commits` | View commit history |

## Error Handling

### Common Issues

| Error | Cause | Solution |
|-------|-------|----------|
| Branch already exists | Branch name conflict | Use different name or delete existing |
| Merge conflicts | Diverged branches | Resolve conflicts manually |
| Test failures | Code bugs | Fix and re-run tests |
| Action fails | Build/deploy error | Check logs, fix issues |
| Permission denied | Missing access | Verify GitHub token permissions |

### GitHub Action Failure Recovery

```bash
# 1. Get failure details
gh run view <run-id> --log-failed

# 2. Common fixes:
# - Missing dependency: Update go.mod/requirements.txt
# - Build error: Fix syntax/compilation issues
# - Test failure: Fix failing tests
# - Config error: Check environment variables

# 3. After fixing, commit and re-deploy
git add .
git commit -m "fix: resolve deployment issue"
git push origin <feature-branch>

# 4. Re-merge to staging
git checkout staging
git pull origin staging
git merge <feature-branch>
git push origin staging

# 5. After staging succeeds, create PR if not exists
gh pr list --head <feature-branch>
gh pr create --title "..." --body "..." --base main
```

## Best Practices

### Issue Creation
- Use clear, descriptive titles
- Include acceptance criteria
- Add relevant labels
- Link to related issues/PRs

### Branch Management
- Always branch from latest main
- Use issue number in branch name
- Keep branches focused on single feature

### Code Quality
- Follow existing patterns
- Write meaningful commit messages
- Include unit tests for new code
- Handle errors appropriately

### Deployment
- Test locally before pushing
- Monitor GitHub Actions
- Have rollback plan ready
- Document any environment changes

### Pull Request
- Always create PR after staging success
- Include staging verification status
- Link to related issue
- Provide clear test plan

## Prerequisites

### Required Tools
```bash
# GitHub CLI
brew install gh
gh auth login

# Git
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### Environment Variables
```bash
export GITHUB_TOKEN="ghp_xxxx"
```

### MCP Server Configuration
The GitHub MCP server must be configured in `.mcp.json`:
```json
{
  "mcpServers": {
    "github": {
      "type": "stdio",
      "command": "npx",
      "args": ["@anthropic-ai/mcp-server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

## Workflow Summary

### For Non-Service Projects
```
Requirement --> Issue --> Branch --> Develop --> Test --> Push --> PR --> Done
```

### For Gin/FastAPI Services
```
Requirement --> Issue --> Branch --> Develop --> Test --> Push --> Staging --> Monitor --> PR --> Done
```

## Related Skills

- `github-integration`: GitHub operations reference
- `slurm`: GPU cluster job submission
- `raydata`: Ray Data batch processing

## Limitations

- Cannot handle complex merge conflicts automatically
- Requires manual intervention for failing GitHub Actions that need infrastructure changes
- Does not support creating releases to production (only staging)
- Cannot modify GitHub repository settings
