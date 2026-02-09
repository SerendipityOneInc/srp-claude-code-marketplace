# rpt_favie_gensmo_tryon_gen_bysource_metric_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_gen_bysource_metric_view`
**层级**: RPT (报表层)
**业务域**: tryon
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
| tryon_gen_action_cnt | INTEGER | NULLABLE | - |
| tryon_gen_panel_pv_cnt | INTEGER | NULLABLE | - |
| tryon_gen_panel_click_cnt | INTEGER | NULLABLE | - |
| ap_back_btn | INTEGER | NULLABLE | - |
| ap_try_on_result_entity_list_entity | INTEGER | NULLABLE | - |
| ap_menu_btn | INTEGER | NULLABLE | - |
| ap_retry_btn | INTEGER | NULLABLE | - |
| ap_menu_download_look_btn | INTEGER | NULLABLE | - |
| ap_comment_list_search_advice_bubble | INTEGER | NULLABLE | - |
| ap_like_btn | INTEGER | NULLABLE | - |
| ap_scenario_btn | INTEGER | NULLABLE | - |
| ap_remix_btn | INTEGER | NULLABLE | - |
| ap_menu_ai_closet_btn | INTEGER | NULLABLE | - |
| ap_share_btn | INTEGER | NULLABLE | - |
| ap_dislike_btn | INTEGER | NULLABLE | - |
| screenshot | INTEGER | NULLABLE | - |
| ap_save_btn | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d` (dws_favie_gensmo_tryon_by_event_metric_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_gen_bysource_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:36
**扫描工具**: scan_metadata_v2.py
