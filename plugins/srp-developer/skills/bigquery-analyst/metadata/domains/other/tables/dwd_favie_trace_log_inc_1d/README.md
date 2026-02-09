# dwd_favie_trace_log_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_trace_log_inc_1d`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2026-01-23
**最后更新**: 2026-01-23

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| event_uuid | STRING | REQUIRED | - |
| ip | STRING | NULLABLE | - |
| timestamp | TIMESTAMP | NULLABLE | - |
| site | STRING | NULLABLE | - |
| vibe_id | STRING | NULLABLE | - |
| product_id | STRING | NULLABLE | - |
| event | STRING | NULLABLE | - |
| sign | STRING | NULLABLE | - |
| headers | STRING | NULLABLE | - |
| country | STRING | NULLABLE | - |
| impid | STRING | NULLABLE | - |
| exp_id | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_trace_log_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:54
**扫描工具**: scan_metadata_v2.py
