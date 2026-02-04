# rpt_decofy_subscription_renewal_conversion_rate_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_renewal_conversion_rate_view`
**层级**: RPT (报表层)
**业务域**: subscription
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-08-15
**最后更新**: 2025-08-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| user_group | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| product_id | STRING | NULLABLE | - |
| simple_product_id | STRING | NULLABLE | - |
| order_source | STRING | NULLABLE | - |
| subscription_type | STRING | NULLABLE | - |
| order_category | STRING | NULLABLE | - |
| renewal_type | STRING | NULLABLE | - |
| renewal_user_cnt | INTEGER | NULLABLE | - |
| expires_user_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d` (rpt_decofy_subscription_membership_metrics_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_renewal_conversion_rate_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:22
**扫描工具**: scan_metadata_v2.py
