# rpt_favie_feed_user_operation_30days_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_feed_user_operation_30days_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-05-13
**最后更新**: 2025-05-13

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| user_id | STRING | NULLABLE | - |
| event_date | STRING | NULLABLE | - |
| device_ids | STRING | REPEATED | - |
| user_view_cnt | INTEGER | NULLABLE | - |
| user_click_cnt | INTEGER | NULLABLE | - |
| user_search_cnt | INTEGER | NULLABLE | - |
| user_try_on_cnt | INTEGER | NULLABLE | - |
| user_remix_cnt | INTEGER | NULLABLE | - |
| user_share_cnt | INTEGER | NULLABLE | - |
| user_save_cnt | INTEGER | NULLABLE | - |
| product_click_cnt | INTEGER | NULLABLE | - |
| product_link_click_cnt | INTEGER | NULLABLE | - |
| user_stay_duration | FLOAT | NULLABLE | - |
| is_registered_user | BOOLEAN | NULLABLE | - |
| geos | RECORD | REPEATED | - |
| is_effective_user | BOOLEAN | NULLABLE | - |
| user_email | STRING | NULLABLE | - |
| created_date | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.gensmo_dw.dwd_gem_user_behavior_wide_inc_1d` (dwd_gem_user_behavior_wide_inc_1d)
- `srpproduct-dc37e.gensmo_dim.dim_gem_user_full_1d_view` (dim_gem_user_full_1d_view)
- `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d` (dws_gensmo_refer_metrics_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_feed_user_operation_30days_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:57
**扫描工具**: scan_metadata_v2.py
