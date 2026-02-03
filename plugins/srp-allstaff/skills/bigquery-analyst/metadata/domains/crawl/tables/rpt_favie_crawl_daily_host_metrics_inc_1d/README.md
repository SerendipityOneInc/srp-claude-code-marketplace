# rpt_favie_crawl_daily_host_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 43,122 行
**大小**: 0.00 GB
**创建时间**: 2025-11-26
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| host | STRING | NULLABLE | - |
| success_cnt | INTEGER | NULLABLE | - |
| failed_cnt | INTEGER | NULLABLE | - |
| duplicate_cnt | INTEGER | NULLABLE | - |
| not_found_cnt | INTEGER | NULLABLE | - |
| delisted_cnt | INTEGER | NULLABLE | - |
| parse_failed_cnt | INTEGER | NULLABLE | - |
| total_cnt | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:09
**扫描工具**: scan_metadata_v2.py
