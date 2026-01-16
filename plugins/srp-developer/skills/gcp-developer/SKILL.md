---
name: gcp-developer
description: GCP access for developers - BigQuery data analysis, GCS viewing, GKE info (GCP开发者访问：BigQuery、GCS、GKE)
---

# GCP Developer Access (GCP 开发者访问)

为开发者提供 GCP 资源的访问权限，包括 BigQuery 数据查询和分析、GCS 对象查看、GKE 集群信息等。

Provides GCP resource access for developers, including BigQuery data queries and analysis, GCS object viewing, and GKE cluster information.

⚠️ **Important**: This skill provides **READ-ONLY** access. No management operations (create, update, delete) are allowed.

## Quick Start

### Query BigQuery (查询 BigQuery)

```
查询 BigQuery 表 `srpproduct-dc37e.dataset.table` 的前 10 行数据
Query the first 10 rows from BigQuery table `srpproduct-dc37e.dataset.table`
```

### List BigQuery Tables (列出 BigQuery 表)

```
显示 srpproduct-dc37e 项目中的所有表
List all tables in srpproduct-dc37e project
```

### Get Table Schema (获取表结构)

```
显示表 dataset.table 的字段结构
Show schema of table dataset.table
```

## Key Features

### 1. BigQuery Data Access (BigQuery 数据访问)

Execute read-only SQL queries against BigQuery:

**Available MCP Tools:**
- `mcp__bigquery__execute-query` - Execute SELECT queries
- `mcp__bigquery__list-tables` - List all tables
- `mcp__bigquery__describe-table` - Get table schema

**Query Capabilities:**
- Execute SELECT queries
- Join multiple tables
- Aggregate data (GROUP BY, COUNT, SUM, AVG)
- Filter and sort results
- Use subqueries and CTEs
- **Restrictions**: No INSERT, UPDATE, DELETE, DROP operations

**Query Parameters:**
- `query`: SQL SELECT statement (BigQuery SQL dialect)
- Results are returned as JSON
- Maximum query execution time: varies by project settings

### 2. Table Management (表管理 - 只读)

View table information and schema:

**List Tables:**
- Get all tables across datasets
- View table names and dataset hierarchy
- No pagination required

**Describe Table:**
- Get complete schema information
- View column names and data types
- See table metadata

## Common Workflows

### Workflow 1: Explore Database

```markdown
1. User: "显示所有可用的 BigQuery 表"
2. List tables: mcp__bigquery__list-tables
3. Display tables grouped by dataset
4. User selects a table to explore
5. Get schema: mcp__bigquery__describe-table
   - table_name: "dataset.table"
6. Display column information
```

### Workflow 2: Query Data

```markdown
1. User: "查询用户活跃数据"
2. Understand requirements
3. Execute query: mcp__bigquery__execute-query
   - query: "SELECT user_id, COUNT(*) as events FROM dataset.events WHERE date >= '2026-01-01' GROUP BY user_id ORDER BY events DESC LIMIT 10"
4. Display results in table format
5. Provide insights or summary
```

### Workflow 3: Data Analysis

```markdown
1. User: "分析最近一周的销售数据"
2. Query relevant tables
3. Aggregate and analyze data
4. Present findings with visualizations (text-based)
5. Suggest follow-up queries if needed
```

## Examples (示例)

### Example 1: List Available Tables (列出可用表)

**User (Chinese):**
```
显示 srpproduct-dc37e 项目中的所有 BigQuery 表
```

**Assistant Response:**
```markdown
我会列出 srpproduct-dc37e 项目中的所有表。

<uses mcp__bigquery__list-tables>

找到以下数据集和表:

**dataset: analytics**
- analytics.user_events
- analytics.page_views
- analytics.conversions

**dataset: product**
- product.users
- product.orders
- product.inventory

**dataset: logs**
- logs.application_logs
- logs.error_logs
- logs.access_logs

共 9 个表。需要查看某个表的详细结构吗?
```

### Example 2: Get Table Schema (获取表结构)

**User (English):**
```
Show me the schema of analytics.user_events table
```

**Assistant Response:**
```markdown
I'll get the schema for the analytics.user_events table.

<uses mcp__bigquery__describe-table>
- table_name: "analytics.user_events"

**Table: analytics.user_events**

| Column Name | Data Type | Mode | Description |
|-------------|-----------|------|-------------|
| event_id | STRING | REQUIRED | Unique event identifier |
| user_id | STRING | REQUIRED | User identifier |
| event_type | STRING | REQUIRED | Type of event |
| event_timestamp | TIMESTAMP | REQUIRED | When event occurred |
| properties | JSON | NULLABLE | Event properties |
| session_id | STRING | NULLABLE | Session identifier |
| device_type | STRING | NULLABLE | Device category |

**Total:** 7 columns

Would you like to query some data from this table?
```

### Example 3: Query Data (查询数据)

**User (Chinese):**
```
查询昨天活跃用户数量最多的前 10 个事件类型
```

**Assistant Response:**
```markdown
我会查询昨天各事件类型的活跃用户数。

<uses mcp__bigquery__execute-query>
- query:
```sql
SELECT
  event_type,
  COUNT(DISTINCT user_id) as active_users
FROM
  analytics.user_events
WHERE
  DATE(event_timestamp) = CURRENT_DATE() - 1
GROUP BY
  event_type
ORDER BY
  active_users DESC
LIMIT 10
```

**查询结果 - 昨天最活跃的事件类型:**

| 事件类型 | 活跃用户数 |
|---------|-----------|
| page_view | 15,234 |
| button_click | 8,956 |
| form_submit | 4,123 |
| video_play | 3,890 |
| search | 3,456 |
| download | 2,345 |
| share | 1,987 |
| comment | 1,654 |
| like | 1,432 |
| bookmark | 1,098 |

**总计:** 44,175 活跃用户

主要发现:
- 页面浏览是最常见的事件，占总活跃用户的 34.3%
- 交互类事件（点击、提交）也有较高的参与度
- 社交类事件（分享、评论）参与度相对较低

需要我进一步分析某个特定事件类型吗?
```

### Example 4: Complex Analytics Query (复杂分析查询)

**User (English):**
```
Analyze user retention: how many users from last week are still active this week?
```

**Assistant Response:**
```markdown
I'll analyze user retention by comparing last week and this week's active users.

<uses mcp__bigquery__execute-query>
- query:
```sql
WITH last_week_users AS (
  SELECT DISTINCT user_id
  FROM analytics.user_events
  WHERE event_timestamp BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 14 DAY)
    AND TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
),
this_week_users AS (
  SELECT DISTINCT user_id
  FROM analytics.user_events
  WHERE event_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
)
SELECT
  COUNT(DISTINCT lw.user_id) as last_week_users,
  COUNT(DISTINCT tw.user_id) as this_week_users,
  COUNT(DISTINCT CASE WHEN tw.user_id IS NOT NULL THEN lw.user_id END) as retained_users,
  ROUND(COUNT(DISTINCT CASE WHEN tw.user_id IS NOT NULL THEN lw.user_id END) * 100.0 / COUNT(DISTINCT lw.user_id), 2) as retention_rate
FROM last_week_users lw
LEFT JOIN this_week_users tw ON lw.user_id = tw.user_id
```

**User Retention Analysis:**

| Metric | Value |
|--------|-------|
| Last Week Active Users | 45,678 |
| This Week Active Users | 48,234 |
| Retained Users | 32,456 |
| **Retention Rate** | **71.06%** |

**Insights:**
- Strong retention rate of 71.06%
- 13,222 users from last week did not return (28.94% churn)
- 15,778 new users joined this week
- Net growth: +2,556 users week-over-week (+5.6%)

**Recommendations:**
- Focus on re-engaging the 13K churned users
- Analyze what features retained users engaged with
- Continue current growth strategies
```

## Important Notes

### Read-Only Restrictions (只读限制)

**Allowed Operations:**
✅ SELECT queries
✅ View table schemas
✅ List tables and datasets
✅ Aggregate and analyze data
✅ Join tables
✅ Use subqueries and CTEs

**Prohibited Operations:**
❌ INSERT, UPDATE, DELETE
❌ DROP or CREATE tables
❌ ALTER table schemas
❌ TRUNCATE tables
❌ MERGE statements
❌ DML operations

### Query Best Practices (查询最佳实践)

1. **Use LIMIT**: Always limit results for exploratory queries
2. **Filter Early**: Use WHERE clauses to reduce data scanned
3. **Avoid SELECT ***: Specify only needed columns
4. **Use Partitions**: Filter by partition columns (usually dates)
5. **Check Costs**: Be mindful of data processed
6. **Use CTEs**: Make complex queries more readable

### BigQuery SQL Dialect (BigQuery SQL 方言)

BigQuery uses Standard SQL with some specific functions:
- Date functions: `CURRENT_DATE()`, `DATE_SUB()`, `TIMESTAMP_TRUNC()`
- String functions: `STRING_AGG()`, `SPLIT()`, `REGEXP_EXTRACT()`
- Array operations: `UNNEST()`, `ARRAY_AGG()`
- Window functions: `ROW_NUMBER()`, `LAG()`, `LEAD()`

### Project and Dataset Access (项目和数据集访问)

- Default project: `srpproduct-dc37e`
- Default location: `us-east1`
- Access depends on user's GCP IAM permissions
- Some datasets may be restricted

## Error Handling

Common errors and solutions:

1. **"Table not found" (表未找到)**
   - Check table name spelling
   - Verify dataset exists
   - Ensure proper format: `dataset.table`

2. **"Permission denied" (权限被拒绝)**
   - User lacks BigQuery read permissions
   - Contact GCP admin to grant access
   - Check IAM roles

3. **"Syntax error" (语法错误)**
   - Review SQL syntax
   - Use BigQuery Standard SQL
   - Check for typos in column names

4. **"Query timeout" (查询超时)**
   - Query is too complex or scans too much data
   - Add filters to reduce data scanned
   - Break into smaller queries

5. **"Quota exceeded" (超出配额)**
   - Too many concurrent queries
   - Wait and retry
   - Contact admin to increase quota

## Security & Compliance

### Data Access Policy (数据访问策略)
- Only read access granted
- No data modification allowed
- All queries are logged
- Follow company data policies

### Sensitive Data (敏感数据)
- Do not query PII without authorization
- Respect data classification levels
- Use aggregated data when possible
- Do not share raw sensitive data

### Best Practices (最佳实践)
- Use for development and analytics only
- Do not use production queries on large tables without testing
- Always add LIMIT for exploratory queries
- Be mindful of query costs

## Prerequisites

### Environment Variables

Set up GCP project configuration:
```bash
export GCP_PROJECT_ID="srpproduct-dc37e"
export GCP_LOCATION="us-east1"
```

### GCP Authentication

Ensure you have authenticated with GCP:
```bash
gcloud auth application-default login
```

Or use a service account key:
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account-key.json"
```

### Required Permissions

Minimum IAM roles required:
- `roles/bigquery.dataViewer` - View table data
- `roles/bigquery.jobUser` - Execute queries
- `roles/bigquery.metadataViewer` - View table metadata

## Tips for Effective Use

1. **Start with schema**: Always check table schema before querying
2. **Use LIMIT**: Test queries with LIMIT 10 first
3. **Aggregate smartly**: Use GROUP BY for summarization
4. **Join efficiently**: Filter before joining large tables
5. **Save common queries**: Document frequently used queries
6. **Use date partitions**: Always filter by date for partitioned tables
7. **Check costs**: Monitor bytes processed in query results

## Related Skills

- `github-integration`: GitHub code and PR management
- Future: `gcs-readonly`, `gke-readonly`, `dataflow-readonly`

## Limitations

### Current Limitations
- BigQuery only (GCS and GKE not yet implemented)
- No query history or saved queries
- No data export capabilities
- No query optimization suggestions
- No automatic error recovery

### Future Enhancements
- GCS bucket and object listing
- GCS file content preview
- GKE cluster and pod information (read-only)
- Cloud SQL read-only access
- Query performance analytics
- Saved query templates
- Data visualization helpers

## GCS and GKE (Coming Soon)

### GCS Read-Only (计划中)
- List buckets
- List objects in buckets
- View object metadata
- Download small files for viewing
- Search for objects

### GKE Read-Only (计划中)
- List clusters
- View cluster configuration
- List namespaces
- View pod status
- Read pod logs
- View service configurations

**Note**: These features require additional MCP server configurations and will be added in future versions.
