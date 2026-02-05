# rpt_gensmo_feed_metrcis_rename_ap_screen_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_feed_metrcis_rename_ap_screen_view`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-08-21
**最后更新**: 2025-08-21

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
| device_id | STRING | NULLABLE | - |
| refer | STRING | NULLABLE | - |
| ap_name | STRING | NULLABLE | - |
| ap_name_new | STRING | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| event_method | STRING | NULLABLE | - |
| event_action_type | STRING | NULLABLE | - |
| event_source | STRING | NULLABLE | - |
| item_type | STRING | NULLABLE | - |
| item_intention | STRING | NULLABLE | - |
| feed_source | STRING | NULLABLE | - |
| home_pv_cnt | INTEGER | NULLABLE | - |
| home_device_id | STRING | NULLABLE | - |
| feed_item_list_pv_cnt | INTEGER | NULLABLE | - |
| feed_item_list_device_id | STRING | NULLABLE | - |
| feed_item_view_pv_cnt | INTEGER | NULLABLE | - |
| feed_item_view_device_id | STRING | NULLABLE | - |
| feed_item_click_cnt | INTEGER | NULLABLE | - |
| feed_item_click_device_id | STRING | NULLABLE | - |
| feed_detail_click_cnt | INTEGER | NULLABLE | - |
| feed_item_tryon_click_cnt | INTEGER | NULLABLE | - |
| feed_item_remix_click_cnt | INTEGER | NULLABLE | - |
| feed_item_save_share_click_cnt | INTEGER | NULLABLE | - |
| feed_item_product_click_cnt | INTEGER | NULLABLE | - |
| feed_item_detail_pv_cnt | INTEGER | NULLABLE | - |
| feed_item_detail_click_device_id | STRING | NULLABLE | - |
| feed_product_detail_click_cnt | INTEGER | NULLABLE | - |
| feed_product_detail_pv_cnt | INTEGER | NULLABLE | - |
| feed_product_detail_device_id | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_feed_metrcis_rename_ap_screen_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:55
**扫描工具**: scan_metadata_v2.py
