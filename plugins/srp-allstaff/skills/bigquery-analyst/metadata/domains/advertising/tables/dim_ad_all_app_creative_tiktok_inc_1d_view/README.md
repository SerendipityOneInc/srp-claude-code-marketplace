# dim_ad_all_app_creative_tiktok_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_tiktok_inc_1d_view`
**层级**: 未分类
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-03
**最后更新**: 2025-07-03

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| source | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| advertiser_id | STRING | NULLABLE | - |
| advertiser_name | STRING | NULLABLE | - |
| is_displayable | BOOLEAN | NULLABLE | - |
| creative_id | STRING | NULLABLE | - |
| creative_type | STRING | NULLABLE | - |
| updated_at | TIMESTAMP | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |
| height | INTEGER | NULLABLE | - |
| size | INTEGER | NULLABLE | - |
| width | INTEGER | NULLABLE | - |
| format | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| file_name | STRING | NULLABLE | - |
| signature | STRING | NULLABLE | - |
| material_id | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.fivetran_tiktok_ads.image_history` (image_history)
- `srpproduct-dc37e.fivetran_tiktok_ads.advertiser` (advertiser)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_tiktok_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:44
**扫描工具**: scan_metadata_v2.py
