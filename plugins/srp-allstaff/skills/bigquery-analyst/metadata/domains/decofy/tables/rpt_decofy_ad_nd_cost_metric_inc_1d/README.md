# rpt_decofy_ad_nd_cost_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: advertising
**表类型**: TABLE
**行数**: 3,557 行
**大小**: 0.00 GB
**创建时间**: 2025-09-25
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区字段，格式YYYY-MM-DD |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| n_day | INTEGER | NULLABLE | N天 |
| ad_cost | FLOAT | NULLABLE | 广告成本 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:00:44
**扫描工具**: scan_metadata_v2.py
