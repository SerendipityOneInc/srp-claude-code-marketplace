# rpt_decofy_subscribe_renewal_ltv_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_renewal_ltv_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 952 行
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
| product_id | STRING | NULLABLE | 订阅产品ID |
| simple_product_id | STRING | NULLABLE | 简化产品ID |
| product_with_trial | INTEGER | NULLABLE | 首单是否使用免费试用，1表示使用，0表示未使用 |
| order_source | STRING | NULLABLE | 订单来源 |
| first_order_due_30d_cnt | INTEGER | NULLABLE | 最近30天首单到期订单数 |
| first_order_renewal_30d_cnt | INTEGER | NULLABLE | 最近30天首单续订订单数 |
| first_order_due_60d_cnt | INTEGER | NULLABLE | 最近60天首单到期订单数 |
| first_order_renewal_60d_cnt | INTEGER | NULLABLE | 最近60天首单续订订单数 |
| default_first_order_renewal_rate | FLOAT | NULLABLE | 兜底首单续订率 |
| second_order_due_30d_cnt | INTEGER | NULLABLE | 最近30天二单到期订单数 |
| second_order_renewal_30d_cnt | INTEGER | NULLABLE | 最近30天二单续订订单数 |
| second_order_due_60d_cnt | INTEGER | NULLABLE | 最近60天二单到期订单数 |
| second_order_renewal_60d_cnt | INTEGER | NULLABLE | 最近60天二单续订订单数 |
| default_second_order_renewal_rate | FLOAT | NULLABLE | 兜底二单续订率 |
| third_more_order_due_30d_cnt | INTEGER | NULLABLE | 最近30天三单到期订单数 |
| third_more_order_renewal_30d_cnt | INTEGER | NULLABLE | 最近30天三单续订订单数 |
| third_more_order_due_60d_cnt | INTEGER | NULLABLE | 最近60天三单到期订单数 |
| third_more_order_renewal_60d_cnt | INTEGER | NULLABLE | 最近60天三单续订订单数 |
| default_third_more_order_renewal_rate | FLOAT | NULLABLE | 兜底三单续订率 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_renewal_ltv_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:11
**扫描工具**: scan_metadata_v2.py
