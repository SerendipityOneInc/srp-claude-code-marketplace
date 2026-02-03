# dws_favie_gem_search_query_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_search_query_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: search
**表类型**: TABLE
**行数**: 790,525 行
**大小**: 0.10 GB
**创建时间**: 2025-10-21
**最后更新**: 2025-10-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| raw_query | STRING | NULLABLE | - |
| qp_query | STRING | NULLABLE | - |
| query_modality | STRING | NULLABLE | - |
| raw_query_word_amt | INTEGER | NULLABLE | - |
| qp_query_word_amt | INTEGER | NULLABLE | - |
| query_cnt | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gem_search_query_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:42
**扫描工具**: scan_metadata_v2.py
