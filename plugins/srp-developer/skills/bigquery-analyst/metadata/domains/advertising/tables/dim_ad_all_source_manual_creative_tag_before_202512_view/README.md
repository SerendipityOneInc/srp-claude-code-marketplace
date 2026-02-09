# dim_ad_all_source_manual_creative_tag_before_202512_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_all_source_manual_creative_tag_before_202512_view`
**层级**: 未分类
**业务域**: advertising
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-17
**最后更新**: 2025-12-17

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| source | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| account_id | INTEGER | NULLABLE | - |
| account_name | STRING | NULLABLE | - |
| campaign_id | INTEGER | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| ad_group_id | FLOAT | NULLABLE | - |
| ad_group_name | STRING | NULLABLE | - |
| ad_id | FLOAT | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| ad_category | STRING | NULLABLE | - |
| account_put_type | STRING | NULLABLE | - |
| account_open_agency | STRING | NULLABLE | - |
| f_creative_id | STRING | NULLABLE | - |
| f_creative_name | STRING | NULLABLE | - |
| f_creative_url | STRING | NULLABLE | - |
| f_creative_type | STRING | NULLABLE | - |
| external_website_creative_url | STRING | NULLABLE | - |
| func | STRING | NULLABLE | - |
| language | STRING | NULLABLE | - |
| race | STRING | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| format | STRING | NULLABLE | - |
| video_id | STRING | NULLABLE | - |
| video_url | STRING | NULLABLE | - |
| video_name | STRING | NULLABLE | - |
| video_updated_at | TIMESTAMP | NULLABLE | bq-datetime |
| video_created_at | TIMESTAMP | NULLABLE | bq-datetime |
| image_id | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| image_name | STRING | NULLABLE | - |
| image_created_at | TIMESTAMP | NULLABLE | bq-datetime |
| image_updated_at | TIMESTAMP | NULLABLE | bq-datetime |
| internal_creative_id | STRING | NULLABLE | - |
| internal_creative_url | STRING | NULLABLE | - |
| post_id | STRING | NULLABLE | - |
| external_creative_id | STRING | NULLABLE | - |
| video_expire_time | DATE | NULLABLE | %E4Y-%m-%d |
| creative_seq | INTEGER | NULLABLE | - |
| impression | INTEGER | NULLABLE | - |
| click | INTEGER | NULLABLE | - |
| conversion | INTEGER | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |
| creative_install_cnt | INTEGER | NULLABLE | - |
| creative_new_user_cnt | INTEGER | NULLABLE | - |
| creative_d0_active_cnt | INTEGER | NULLABLE | - |
| creative_d1_retention_cnt | INTEGER | NULLABLE | - |
| creative_lt7_cnt | INTEGER | NULLABLE | - |
| cost_rate | FLOAT | NULLABLE | - |
| cum_cost_rate | FLOAT | NULLABLE | - |
| ______ | FLOAT | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_all_source_manual_creative_tag_before_202512_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:55
**扫描工具**: scan_metadata_v2.py
