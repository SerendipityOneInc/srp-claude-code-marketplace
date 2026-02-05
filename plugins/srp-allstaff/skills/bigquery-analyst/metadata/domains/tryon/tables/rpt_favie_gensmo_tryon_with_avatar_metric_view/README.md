# rpt_favie_gensmo_tryon_with_avatar_metric_view

**表全名**: `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_tryon_with_avatar_metric_view`
**层级**: RPT (报表层)
**业务域**: tryon
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
| dt | DATE | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| avatar_id | STRING | NULLABLE | - |
| avatar_url | STRING | NULLABLE | - |
| use_default_model | BOOLEAN | NULLABLE | - |
| tryon_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` (dim_gem_user_replica_view)
- `srpproduct-dc37e.favie_dw.dim_try_on_user_task_view` (dim_try_on_user_task_view)
- `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_inc_1d` (dim_favie_gensmo_user_ids_map_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_tryon_with_avatar_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:18
**扫描工具**: scan_metadata_v2.py
