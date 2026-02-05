# dim_ad_meta_creative_v2_full_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_meta_creative_v2_full_1d_view`
**层级**: 未分类
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-09
**最后更新**: 2025-11-09

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
| account_id | STRING | NULLABLE | - |
| account_name | STRING | NULLABLE | - |
| campaign_id | STRING | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_group_name | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| ad_category | STRING | NULLABLE | - |
| account_put_type | STRING | NULLABLE | - |
| account_open_agency | STRING | NULLABLE | - |
| channel | STRING | NULLABLE | - |
| conversion | FLOAT | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |
| creative_id | STRING | NULLABLE | - |
| creative_name | STRING | NULLABLE | - |
| creative_type | STRING | NULLABLE | - |
| external_website_creative_url | STRING | NULLABLE | - |
| video_id | STRING | NULLABLE | - |
| video_url | STRING | NULLABLE | - |
| video_name | STRING | NULLABLE | - |
| video_updated_at | TIMESTAMP | NULLABLE | - |
| video_created_at | TIMESTAMP | NULLABLE | - |
| image_id | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| image_name | STRING | NULLABLE | - |
| image_created_at | TIMESTAMP | NULLABLE | - |
| image_updated_at | TIMESTAMP | NULLABLE | - |
| internal_creative_id | STRING | NULLABLE | - |
| internal_creative_url | STRING | NULLABLE | - |
| kol_id | STRING | NULLABLE | - |
| creative_url | STRING | NULLABLE | - |
| creative_source | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.fivetran_facebook_ads_full.ad_image_history` (ad_image_history)
- `srpproduct-dc37e.fivetran_facebook_ads_full.creative_history` (creative_history)
- `srpproduct-dc37e.fivetran_facebook_ads_full.ad_video_history` (ad_video_history)
- `srpproduct-dc37e.fivetran_facebook_ads_full.ad_history` (ad_history)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_meta_creative_v2_full_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:08
**扫描工具**: scan_metadata_v2.py
