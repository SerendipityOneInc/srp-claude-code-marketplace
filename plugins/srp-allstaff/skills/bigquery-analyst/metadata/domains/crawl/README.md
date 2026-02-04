# 爬虫任务

**业务域**: crawl
**最后更新**: 2026-01-30
**表数量**: 8 张

---

## 📊 业务概述

网页爬虫、数据抓取、任务监控

**关键词**: 爬虫, crawl, 抓取

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_favie_crawl_daily_host_metrics_inc_1d` | RPT | --- |
| `rpt_product_image_crawl_metrics_inc_1d` | RPT | --- |
| `dwd_favie_product_detail_crawl_task_15min` | DWD | --- |
| `dwd_favie_product_detail_crawl_task_1d` | DWD | --- |
| `dwd_favie_product_detail_image_crawl_task_1d` | DWD | --- |


更多表请参见 [TABLES.md](./TABLES.md)

---

## 💡 常见查询场景

### 场景 1: (待补充)

**需求**: 待补充业务需求

**推荐表**: 待补充

**示例 SQL**:
```sql
-- 待补充查询示例
SELECT
  dt,
  COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dwd.table_name`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC
```

---

## 🔗 相关资源

- [表清单](./TABLES.md) - 完整表列表
- [通用函数](./common_functions/) - 可复用的查询函数

---

**文档生成**: 2026-01-30 15:33:23
**维护者**: Data Platform Team
