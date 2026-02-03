# rpt_genmso_user_recap_frequency_rank

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_genmso_user_recap_frequency_rank`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-18
**最后更新**: 2025-11-18

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| user_id | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| geo_country_name | STRING | NULLABLE | - |
| active_cnt | INTEGER | NULLABLE | - |
| app_open_cnt | INTEGER | NULLABLE | - |
| app_foreground_cnt | INTEGER | NULLABLE | - |
| app_exit_cnt | INTEGER | NULLABLE | - |
| avatar_create_cnt | INTEGER | NULLABLE | - |
| search_cnt | INTEGER | NULLABLE | - |
| try_on_cnt | INTEGER | NULLABLE | - |
| try_on_scene_cnt | INTEGER | NULLABLE | - |
| feed_detail_view_cnt | INTEGER | NULLABLE | - |
| feed_detail_view_item_list_cnt | INTEGER | NULLABLE | - |
| dupe_search_trigger_cnt | INTEGER | NULLABLE | - |
| dupe_result_view_cnt | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_genmso_user_recap_frequency_rank`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:11
**扫描工具**: scan_metadata_v2.py
