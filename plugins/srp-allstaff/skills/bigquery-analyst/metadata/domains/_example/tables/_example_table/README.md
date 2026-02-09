# table_name

**表全名**: `project.dataset.table_name`
**层级**: RPT
**业务域**: domain_name

---

## 📊 表说明

表的业务含义和用途

---

## 📋 字段定义

| 字段名 | 类型 | 说明 |
|--------|------|------|
| dt | DATE | 日期分区 |
| ... | ... | ... |

---

## 🔗 数据血缘

**上游依赖**:
- `project.dataset.upstream_table`

**下游使用**:
- `project.dataset.downstream_table`

---

## 🔍 查询示例

```sql
SELECT * FROM `project.dataset.table_name`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY);
```
