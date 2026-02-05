# dim_gem_user_replica_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view`
**层级**: 未分类
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| created_timestamp | TIMESTAMP | NULLABLE | - |
| deleted_timestamp | TIMESTAMP | NULLABLE | - |
| model_id | STRING | NULLABLE | - |
| model_url | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.gem` (gem)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:16
**扫描工具**: scan_metadata_v2.py
