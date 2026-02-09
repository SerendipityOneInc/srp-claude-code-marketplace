# rpt_favie_gensmo_channel_metric_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-09
**最后更新**: 2025-07-09

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
| item_task_type | STRING | NULLABLE | - |
| item_task_model | STRING | NULLABLE | - |
| channel_user_cnt | INTEGER | NULLABLE | - |
| user_channel_cnt | INTEGER | NULLABLE | - |
| tryon_task_list_pv_cnt | INTEGER | NULLABLE | - |
| tryon_task_list_item_cnt | INTEGER | NULLABLE | - |
| tryon_task_gen_pv_cnt | INTEGER | NULLABLE | - |
| tryon_task_gen_item_cnt | INTEGER | NULLABLE | - |
| tryon_task_complete_pv_cnt | INTEGER | NULLABLE | - |
| tryon_task_complete_item_cnt | INTEGER | NULLABLE | - |
| tryon_task_detail_pv_cnt | INTEGER | NULLABLE | - |
| tryon_task_detail_item_cnt | INTEGER | NULLABLE | - |
| tryon_task_save_cnt | INTEGER | NULLABLE | - |
| tryon_task_save_item_cnt | INTEGER | NULLABLE | - |
| tryon_task_share_cnt | INTEGER | NULLABLE | - |
| tryon_task_share_item_cnt | INTEGER | NULLABLE | - |
| tryon_task_like_cnt | INTEGER | NULLABLE | - |
| tryon_task_like_item_cnt | INTEGER | NULLABLE | - |
| tryon_task_download_cnt | INTEGER | NULLABLE | - |
| tryon_task_download_item_cnt | INTEGER | NULLABLE | - |
| tryon_scene_task_gen_pv_cnt | INTEGER | NULLABLE | - |
| tryon_scene_task_gen_item_cnt | INTEGER | NULLABLE | - |
| collage_task_list_pv_cnt | INTEGER | NULLABLE | - |
| collage_task_list_item_cnt | INTEGER | NULLABLE | - |
| collage_task_gen_pv_cnt | INTEGER | NULLABLE | - |
| collage_task_gen_item_cnt | INTEGER | NULLABLE | - |
| collage_task_complete_pv_cnt | INTEGER | NULLABLE | - |
| collage_task_complete_item_cnt | INTEGER | NULLABLE | - |
| collage_task_detail_pv_cnt | INTEGER | NULLABLE | - |
| collage_task_detail_item_cnt | INTEGER | NULLABLE | - |
| collage_task_save_cnt | INTEGER | NULLABLE | - |
| collage_task_save_item_cnt | INTEGER | NULLABLE | - |
| collage_task_share_cnt | INTEGER | NULLABLE | - |
| collage_task_share_item_cnt | INTEGER | NULLABLE | - |
| collage_task_like_cnt | INTEGER | NULLABLE | - |
| collage_task_like_item_cnt | INTEGER | NULLABLE | - |
| collage_task_download_cnt | INTEGER | NULLABLE | - |
| collage_task_download_item_cnt | INTEGER | NULLABLE | - |
| product_list_pv_cnt | INTEGER | NULLABLE | - |
| product_list_item_cnt | INTEGER | NULLABLE | - |
| product_detail_pv_cnt | INTEGER | NULLABLE | - |
| product_detail_item_cnt | INTEGER | NULLABLE | - |
| product_save_cnt | INTEGER | NULLABLE | - |
| product_save_item_cnt | INTEGER | NULLABLE | - |
| product_share_cnt | INTEGER | NULLABLE | - |
| product_share_item_cnt | INTEGER | NULLABLE | - |
| product_task_like_cnt | INTEGER | NULLABLE | - |
| product_task_like_item_cnt | INTEGER | NULLABLE | - |
| product_download_cnt | INTEGER | NULLABLE | - |
| product_download_item_cnt | INTEGER | NULLABLE | - |
| product_external_jump_cnt | INTEGER | NULLABLE | - |
| product_external_jump_item_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d` (rpt_favie_gensmo_channel_metric_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:05
**扫描工具**: scan_metadata_v2.py
