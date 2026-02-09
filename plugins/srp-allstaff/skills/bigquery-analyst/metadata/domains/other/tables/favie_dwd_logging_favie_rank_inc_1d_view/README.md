# favie_dwd_logging_favie_rank_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.favie_dwd_logging_favie_rank_inc_1d_view`
**层级**: 未分类
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-20
**最后更新**: 2025-02-20

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| trace_id | STRING | NULLABLE | - |
| ha3_query | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| score | FLOAT | NULLABLE | - |
| log_timestamp | TIMESTAMP | NULLABLE | - |
| receive_timestamp | TIMESTAMP | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.favie_dwd_logging_favie_rank_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:31
**扫描工具**: scan_metadata_v2.py
