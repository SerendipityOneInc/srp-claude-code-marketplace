# rpt_gensmo_ab_product_metrics_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_product_metrics_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-08-20
**最后更新**: 2025-08-20

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| ab_project_name | STRING | NULLABLE | - |
| ab_router_id | STRING | NULLABLE | - |
| ab_router_name | STRING | NULLABLE | - |
| product_external_jump_click_cnt | INTEGER | NULLABLE | - |
| product_detail_pv_cnt | INTEGER | NULLABLE | - |
| product_external_jump_click_user_cnt | INTEGER | NULLABLE | - |
| product_detail_pv_user_cnt | INTEGER | NULLABLE | - |
| product_external_jump_click_in_channel_cnt | INTEGER | NULLABLE | - |
| product_external_jump_click_in_channel_user_cnt | INTEGER | NULLABLE | - |
| product_detail_pv_in_channel_cnt | INTEGER | NULLABLE | - |
| product_detail_pv_in_channel_user_cnt | INTEGER | NULLABLE | - |
| DAU | INTEGER | NULLABLE | - |
| user_channel_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dws_favie_gensmo_product_bysource_metric_inc_1d` (dws_favie_gensmo_product_bysource_metric_inc_1d)
- `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d` (rpt_gensmo_user_active_metrics_inc_1d)
- `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_with_dau_inc_1d` (rpt_favie_gensmo_channel_metric_with_dau_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_product_metrics_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:22
**扫描工具**: scan_metadata_v2.py
