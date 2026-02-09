# rpt_favie_gensmo_feed_with_dau_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_feed_with_dau_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: TABLE
**行数**: 8,130,352 行
**大小**: 0.81 GB
**创建时间**: 2025-06-17
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| user_group | STRING | NULLABLE | - |
| active_user_d1_cnt | INTEGER | NULLABLE | 日活跃用户数 |
| home_pv_cnt | INTEGER | NULLABLE | - |
| home_user_cnt | INTEGER | NULLABLE | - |
| feed_item_list_pv_cnt | INTEGER | NULLABLE | - |
| feed_item_list_user_cnt | INTEGER | NULLABLE | - |
| feed_item_view_pv_cnt | INTEGER | NULLABLE | - |
| feed_item_view_user_cnt | INTEGER | NULLABLE | - |
| feed_item_click_cnt | INTEGER | NULLABLE | - |
| feed_item_click_user_cnt | INTEGER | NULLABLE | - |
| feed_detail_click_cnt | INTEGER | NULLABLE | - |
| feed_item_tryon_click_cnt | INTEGER | NULLABLE | - |
| feed_item_remix_click_cnt | INTEGER | NULLABLE | - |
| feed_item_save_share_click_cnt | INTEGER | NULLABLE | - |
| feed_item_product_click_cnt | INTEGER | NULLABLE | - |
| feed_item_detail_pv_cnt | INTEGER | NULLABLE | - |
| feed_item_detail_click_user_cnt | INTEGER | NULLABLE | - |
| feed_product_detail_click_cnt | INTEGER | NULLABLE | - |
| feed_product_detail_pv_cnt | INTEGER | NULLABLE | - |
| feed_product_detail_user_cnt | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_feed_with_dau_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:15
**扫描工具**: scan_metadata_v2.py
