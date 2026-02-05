# 用户行为

**业务域**: user_behavior
**最后更新**: 2026-01-30
**表数量**: 56 张

---

## 📊 业务概述

用户活跃、留存、时长、回访等行为分析

**关键词**: 活跃, 留存, DAU, MAU

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_favie_event_operation_30d` | RPT | --- |
| `rpt_favie_gensmo_events_field_fill_rate_view` | RPT | --- |
| `rpt_favie_gensmo_events_version_distribute_view` | RPT | --- |
| `dws_favie_gensmo_refer_event_metric_inc_1d` | DWS | --- |
| `dws_favie_gensmo_user_1d7s_inc_1d` | DWS | --- |
| `dws_favie_gensmo_user_feature_30d_view` | DWS | --- |


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
