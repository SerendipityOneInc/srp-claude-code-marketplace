# rpt_favie_webpage_metric_full_1w

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_webpage_metric_full_1w`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 1,763,309 行
**大小**: 0.08 GB
**创建时间**: 2025-12-17
**最后更新**: 2026-01-26

---

## 📊 表说明

网页指标全量周表

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| domain | STRING | NULLABLE | - |
| total_webpage_num | INTEGER | NULLABLE | - |
| weekly_new_webpage_num | INTEGER | NULLABLE | - |
| weekly_update_webpage_num | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_webpage_metric_full_1w`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:41
**扫描工具**: scan_metadata_v2.py
