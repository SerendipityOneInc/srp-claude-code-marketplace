# dim_decofy_subscription_notification_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_decofy_subscription_notification_view`
**层级**: 未分类
**业务域**: subscription
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| consumption_request_reason | STRING | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |
| updated_at | TIMESTAMP | NULLABLE | - |
| deleted_at | TIMESTAMP | NULLABLE | - |
| notification_type | STRING | NULLABLE | - |
| notification_uuid | STRING | NULLABLE | - |
| renewal_info | STRING | NULLABLE | - |
| signed_date | INTEGER | NULLABLE | - |
| subscription_status | INTEGER | NULLABLE | - |
| subtype | STRING | NULLABLE | - |
| transaction_info | STRING | NULLABLE | - |
| version | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.decofy_app_store_server_notifications` (decofy_app_store_server_notifications)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_decofy_subscription_notification_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:40
**扫描工具**: scan_metadata_v2.py
