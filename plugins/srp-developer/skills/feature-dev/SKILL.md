---
name: feature-dev
description: End-to-end feature development workflow from requirement to staging deployment and PR creation
---

# Feature Development Workflow

## CRITICAL WARNING

**THIS WORKFLOW IS MANDATORY. VIOLATION IS NOT ACCEPTABLE.**

If you skip any step or write code before Step 3 is complete, you have FAILED. Follow the steps EXACTLY as defined below.

---

If user has not provided a feature request yet, ask: "Please describe the feature you want to develop." Then WAIT.

After user provides feature request, execute steps in EXACT order: Step 1 → Step 2 → Step 3 → Step 4 → Step 5 → Step 6 → Step 7 → Step 8.

**FORBIDDEN before Step 3 is complete:**
- Do NOT write or modify any code
- Do NOT use Edit or Write tools
- Do NOT plan implementation details

## Step 1: Analyze Requirement

Only summarize user's requirement in plain text. Ask clarifying questions if needed. Do NOT explore codebase.

## Step 2: Create GitHub Issue

```bash
gh issue create --title "[Feature] <description>" --body "<description and acceptance criteria>"
```

Tell user the Issue number and URL.

## Step 3: Create Feature Branch

```bash
git fetch origin main
git checkout -b <issue-number>-<description> origin/main
git push -u origin <issue-number>-<description>
```

Tell user the branch name.

## Step 4: Develop

Implement feature and write tests.

## Step 5: Run Tests

```bash
# Go: go test ./... -v
# Python: pytest -v
# Node: npm test
```

If tests fail, fix and re-run.

## Step 6: Commit and Push

```bash
git add <files>
git commit -m "feat: <description>

Closes #<issue-number>"
git push origin <branch-name>
```

## Step 7: Deploy Staging (Gin/FastAPI only)

Check if project uses Gin or FastAPI. If yes, merge to staging branch or create beta tag.

If not a Gin/FastAPI service, skip to Step 8.

## Step 8: Create Pull Request

```bash
gh pr create --title "feat: <description>" --body "Closes #<issue-number>" --base main
```

Tell user the PR URL.

---

## Workflow Summary

```
Non-service:  Requirement → Issue → Branch → Develop → Test → Push → PR
Gin/FastAPI:  Requirement → Issue → Branch → Develop → Test → Push → Staging → PR
```
