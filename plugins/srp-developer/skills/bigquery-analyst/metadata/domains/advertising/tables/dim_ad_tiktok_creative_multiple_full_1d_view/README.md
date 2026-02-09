# dim_ad_tiktok_creative_multiple_full_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_tiktok_creative_multiple_full_1d_view`
**层级**: 未分类
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-20
**最后更新**: 2025-11-20

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
| creative_id | STRING | NULLABLE | - |
| f_creative_id | STRING | NULLABLE | - |
| f_creative_url | STRING | NULLABLE | - |
| creative_name | STRING | NULLABLE | - |
| f_creative_name | STRING | NULLABLE | - |
| creative_type | STRING | NULLABLE | - |
| f_creative_type | STRING | NULLABLE | - |
| channel | STRING | NULLABLE | - |
| video_id | STRING | NULLABLE | - |
| video_name | STRING | NULLABLE | - |
| video_url | STRING | NULLABLE | - |
| video_expire_time | STRING | NULLABLE | - |
| post_id | STRING | NULLABLE | - |
| image_id | STRING | NULLABLE | - |
| image_name | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| external_creative_id | STRING | NULLABLE | - |
| internal_creative_url | STRING | NULLABLE | - |
| external_website_creative_url | STRING | NULLABLE | - |
| video_created_at | STRING | NULLABLE | - |
| video_updated_at | TIMESTAMP | NULLABLE | - |
| image_created_at | TIMESTAMP | NULLABLE | - |
| image_updated_at | TIMESTAMP | NULLABLE | - |
| internal_creative_id | STRING | NULLABLE | - |
| format | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.fivetran_tiktok_ads.video_history` (video_history)
- `srpproduct-dc37e.fivetran_tiktok_ads.ad_history` (ad_history)
- `srpproduct-dc37e.fivetran_tiktok_ads.image_history` (image_history)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_tiktok_creative_multiple_full_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:11
**扫描工具**: scan_metadata_v2.py
