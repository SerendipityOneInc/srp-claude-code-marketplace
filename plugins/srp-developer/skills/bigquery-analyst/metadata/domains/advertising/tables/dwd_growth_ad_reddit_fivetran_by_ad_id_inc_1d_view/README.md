# dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| source | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| account_put_type | STRING | NULLABLE | - |
| account_open_agency | STRING | NULLABLE | - |
| ad_category | STRING | NULLABLE | - |
| account_id | STRING | NULLABLE | - |
| account_name | STRING | NULLABLE | - |
| campaign_id | STRING | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_group_name | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| impression | INTEGER | NULLABLE | - |
| click | INTEGER | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |
| conversion | FLOAT | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.reddit_ads.ad_group` (ad_group)
- `srpproduct-dc37e.reddit_ads.ad` (ad)
- `srpproduct-dc37e.reddit_ads.business_account` (business_account)
- `srpproduct-dc37e.reddit_ads.campaign` (campaign)
- `srpproduct-dc37e.reddit_ads.ad_report` (ad_report)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:14
**扫描工具**: scan_metadata_v2.py
