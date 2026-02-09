# dwd_gem_user_behavior_wide_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_user_behavior_wide_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: user_behavior
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-25
**最后更新**: 2025-02-25

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| task_id | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| search_query_type | STRING | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| event_date | STRING | NULLABLE | - |
| stream_id | STRING | NULLABLE | - |
| is_active_user | BOOLEAN | NULLABLE | - |
| user_pseudo_id | STRING | NULLABLE | - |
| event_time | DATETIME | NULLABLE | - |
| event_timestamp | INTEGER | NULLABLE | - |
| operating_system | STRING | NULLABLE | - |
| items | RECORD | NULLABLE | - |
| timestamp_offset | INTEGER | NULLABLE | - |
| ga_app_version | STRING | NULLABLE | - |
| country | STRING | NULLABLE | - |
| city | STRING | NULLABLE | - |
| region | STRING | NULLABLE | - |
| metro | STRING | NULLABLE | - |
| sub_continent | STRING | NULLABLE | - |
| continent | STRING | NULLABLE | - |
| geo | RECORD | NULLABLE | - |
| engagement_time_sec | INTEGER | NULLABLE | - |
| user_id | INTEGER | NULLABLE | - |
| item_id | STRING | NULLABLE | - |
| number | INTEGER | NULLABLE | - |
| round | INTEGER | NULLABLE | - |
| refer | STRING | NULLABLE | - |
| if_preference | STRING | NULLABLE | - |
| utm_source | STRING | NULLABLE | - |
| query_id | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| engagement_platform | STRING | NULLABLE | - |
| click_src | STRING | NULLABLE | - |
| input_type | STRING | NULLABLE | - |
| item_list_name | STRING | NULLABLE | - |
| action_type | STRING | NULLABLE | - |
| search_term | STRING | NULLABLE | - |
| method | STRING | NULLABLE | - |
| creative_name | STRING | NULLABLE | - |
| promotion_name | STRING | NULLABLE | - |
| item_name | STRING | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| gensmo_active_id | STRING | NULLABLE | - |
| ga_session_id | INTEGER | NULLABLE | - |
| query_session_id | STRING | NULLABLE | - |
| ab_infos | STRING | NULLABLE | - |
| item_list_id | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_user_behavior_wide_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:14:30
**扫描工具**: scan_metadata_v2.py
