# dwd_growth_ad_tiktok_video_fivetran_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_growth_ad_tiktok_video_fivetran_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-27
**最后更新**: 2025-10-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| source | STRING | NULLABLE | - |
| campaign_id | INTEGER | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| ad_group_id | INTEGER | NULLABLE | - |
| ad_group_name | STRING | NULLABLE | - |
| ad_id | INTEGER | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| creative_id | INTEGER | NULLABLE | - |
| creative_type | STRING | NULLABLE | - |
| impression | INTEGER | NULLABLE | - |
| click | INTEGER | NULLABLE | - |
| conversion | INTEGER | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.fivetran_tiktok_ads.creative_metrics` (creative_metrics)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_growth_ad_tiktok_video_fivetran_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:27
**扫描工具**: scan_metadata_v2.py
