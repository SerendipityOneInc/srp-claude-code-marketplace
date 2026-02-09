# dws_gem_operation_push_message_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_push_message_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: gem
**表类型**: TABLE
**行数**: 2,417,573 行
**大小**: 0.20 GB
**创建时间**: 2025-09-17
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 统计日期（按推送完成日期） |
| user_id | STRING | NULLABLE | 用户ID |
| push_name | STRING | NULLABLE | 推送事件名称 |
| sent_count | INTEGER | NULLABLE | 发送次数（实际发送成功的次数） |
| click_count | INTEGER | NULLABLE | 点击次数（实际点击次数） |
| platform | STRING | NULLABLE | 推送平台/端 |
| user_type | STRING | NULLABLE | 用户类型：新用户或老用户 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_operation_push_message_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:57
**扫描工具**: scan_metadata_v2.py
