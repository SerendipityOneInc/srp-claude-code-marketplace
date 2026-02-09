# 内容流

**业务域**: feed
**最后更新**: 2026-01-30
**表数量**: 52 张

---

## 📊 业务概述

内容推荐、Feed流、内容分发、曝光点击

**关键词**: feed, 内容, 推荐

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_faive_feed_tags_operation_metric_view` | RPT | --- |
| `rpt_faive_feed_tags_total_operation_metric_view` | RPT | --- |
| `rpt_favie_feed_operation_30d` | RPT | --- |
| `dws_favie_gensmo_feed_bysource_metric_inc_1d` | DWS | --- |
| `dws_gem_operation_feed_metrics_inc_1d` | DWS | --- |
| `dws_gem_operation_feed_user_metrics_inc_1d` | DWS | --- |


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
