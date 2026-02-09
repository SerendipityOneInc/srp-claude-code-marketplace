# 其他

**业务域**: other
**最后更新**: 2026-01-30
**表数量**: 28 张

---

## 📊 业务概述

难以归类或跨域的综合性表

**关键词**: 

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_favie_collage_count_view` | RPT | --- |
| `rpt_favie_gensmo_ab_home_metrics_inc_1d_view` | RPT | --- |
| `rpt_favie_gensmo_channel_metric_inc_1d` | RPT | --- |
| `dws_gensmo_tob_group_trace_metric_inc_1d` | DWS | --- |
| `dwd_favie_ha3_rank_inc_1d_view` | DWD | --- |
| `dwd_favie_trace_log_inc_1d` | DWD | --- |
| `dwd_kafka_write_checkpoint_inc_1d` | DWD | --- |


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
