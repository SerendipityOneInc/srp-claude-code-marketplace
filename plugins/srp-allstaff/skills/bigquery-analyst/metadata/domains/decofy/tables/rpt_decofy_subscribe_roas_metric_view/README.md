# rpt_decofy_subscribe_roas_metric_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_roas_metric_view`
**层级**: RPT (报表层)
**业务域**: subscription
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-09-30
**最后更新**: 2025-09-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_cost | FLOAT | NULLABLE | - |
| LTV_7d | FLOAT | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_roas_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:15
**扫描工具**: scan_metadata_v2.py
