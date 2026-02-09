# dwd_favie_gem_search_query_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_search_query_inc_1d`
**层级**: DWD (明细层)
**业务域**: search
**表类型**: TABLE
**行数**: 1,986,633 行
**大小**: 114.04 GB
**创建时间**: 2025-10-07
**最后更新**: 2025-10-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| trace_id | STRING | NULLABLE | - |
| task_id | STRING | NULLABLE | - |
| raw_query | STRING | NULLABLE | - |
| qr_query | STRING | NULLABLE | - |
| qp_query | STRING | NULLABLE | - |
| rewrite_queries | STRING | REPEATED | - |
| query_modality | STRING | NULLABLE | - |
| query_image_url | STRING | NULLABLE | - |
| query_image_description | STRING | NULLABLE | - |
| query_image_height | INTEGER | NULLABLE | - |
| query_image_width | INTEGER | NULLABLE | - |
| query_image_tag | STRING | NULLABLE | - |
| query_intention | STRING | NULLABLE | - |
| query_source | STRING | NULLABLE | - |
| collage_title | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| is_internal_user | BOOLEAN | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| query_results | STRING | REPEATED | - |
| log_timestamp | TIMESTAMP | NULLABLE | - |
| receive_timestamp | TIMESTAMP | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gem_search_query_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:42
**扫描工具**: scan_metadata_v2.py
