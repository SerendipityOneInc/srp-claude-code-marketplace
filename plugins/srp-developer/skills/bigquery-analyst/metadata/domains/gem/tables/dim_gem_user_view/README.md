# dim_gem_user_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_user_view`
**层级**: 未分类
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-03-05
**最后更新**: 2025-03-05

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| user_id | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| user_email | STRING | NULLABLE | - |
| user_name | STRING | NULLABLE | - |
| is_registered_user | BOOLEAN | NULLABLE | - |
| is_effective_user | BOOLEAN | NULLABLE | - |
| geos | RECORD | REPEATED | - |
| last_continent | STRING | NULLABLE | - |
| last_sub_continent | STRING | NULLABLE | - |
| last_country | STRING | NULLABLE | - |
| last_region | STRING | NULLABLE | - |
| last_metro | STRING | NULLABLE | - |
| last_city | STRING | NULLABLE | - |
| updated_date | STRING | NULLABLE | - |
| created_date | STRING | NULLABLE | - |
| updated_time | TIMESTAMP | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |
| device_ids | RECORD | REPEATED | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_user_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:18
**扫描工具**: scan_metadata_v2.py
