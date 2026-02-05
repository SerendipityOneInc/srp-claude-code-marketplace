# dwd_favie_decofy_subscription_process_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_process_inc_1d`
**层级**: DWD (明细层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 27,842 行
**大小**: 0.00 GB
**创建时间**: 2025-09-08
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| user_id | STRING | NULLABLE | 用户ID |
| process_node | STRING | NULLABLE | 节点类型 |
| trigger_source | STRING | NULLABLE | 触发来源 |
| product_id | STRING | NULLABLE | 产品ID |
| simple_product_id | STRING | NULLABLE | 简化产品ID |
| order_id | STRING | NULLABLE | 订单ID |
| order_category | STRING | NULLABLE | 订单类目 |
| order_type | STRING | NULLABLE | 订单类型 |
| order_subscription_seq | INTEGER | NULLABLE | 订单订阅序号 |
| process_time | TIMESTAMP | NULLABLE | 节点时间 |
| trigger_pay_seq | INTEGER | NULLABLE | trigger_pay序号 |
| subscription_id | STRING | NULLABLE | 订阅ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_process_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:33
**扫描工具**: scan_metadata_v2.py
