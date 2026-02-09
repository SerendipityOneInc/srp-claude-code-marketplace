# rpt_favie_gensmo_save_with_dau_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_save_with_dau_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 1,642,321 行
**大小**: 0.45 GB
**创建时间**: 2025-06-24
**最后更新**: 2025-08-01

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
| total_save_click_cnt | INTEGER | NULLABLE | - |
| total_save_click_user_cnt | INTEGER | NULLABLE | - |
| feed_detail_user_cnt | INTEGER | NULLABLE | - |
| feed_detail_save_click_cnt | INTEGER | NULLABLE | - |
| feed_detail_save_click_user_cnt | INTEGER | NULLABLE | - |
| feed_item_similar_save_click_cnt | INTEGER | NULLABLE | - |
| feed_item_similar_save_click_user_cnt | INTEGER | NULLABLE | - |
| feed_item_tryon_save_click_cnt | INTEGER | NULLABLE | - |
| feed_item_tryon_save_click_user_cnt | INTEGER | NULLABLE | - |
| feed_item_general_save_click_cnt | INTEGER | NULLABLE | - |
| feed_item_general_save_click_user_cnt | INTEGER | NULLABLE | - |
| feed_item_product_save_click_cnt | INTEGER | NULLABLE | - |
| feed_item_product_save_click_user_cnt | INTEGER | NULLABLE | - |
| feed_item_styling_save_click_cnt | INTEGER | NULLABLE | - |
| feed_item_styling_save_click_user_cnt | INTEGER | NULLABLE | - |
| tryon_gen_user_cnt | INTEGER | NULLABLE | - |
| tryon_gen_save_click_cnt | INTEGER | NULLABLE | - |
| tryon_gen_save_click_user_cnt | INTEGER | NULLABLE | - |
| product_detail_save_click_cnt | INTEGER | NULLABLE | - |
| product_detail_save_click_user_cnt | INTEGER | NULLABLE | - |
| product_detail_from_search_save_click_cnt | INTEGER | NULLABLE | - |
| product_detail_from_search_save_click_user_cnt | INTEGER | NULLABLE | - |
| full_screen_pic_save_click_cnt | INTEGER | NULLABLE | - |
| full_screen_pic_save_click_user_cnt | INTEGER | NULLABLE | - |
| collage_gen_user_cnt | INTEGER | NULLABLE | - |
| collage_gen_save_click_cnt | INTEGER | NULLABLE | - |
| collage_gen_save_click_user_cnt | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_save_with_dau_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:21
**扫描工具**: scan_metadata_v2.py
