# Decofy应用

**业务域**: decofy
**最后更新**: 2026-01-30
**表数量**: 66 张


⚠️ **归档域**: 该业务已归档，基本不再使用。除非用户明确提及，否则默认不加载此域。

---

## 📊 业务概述

Decofy应用的订阅、用户、广告等全业务数据（已归档）

**关键词**: decofy

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_decofy_action_user_penetration_rate_view` | RPT | --- |
| `rpt_decofy_ad_nd_cost_metric_inc_1d` | RPT | --- |
| `rpt_decofy_create_metric_view` | RPT | --- |
| `dws_decofy_membership_full_1d` | DWS | --- |
| `dws_decofy_refer_general_metrics_inc_1d` | DWS | --- |
| `dws_decofy_refer_metrics_inc_1d` | DWS | --- |


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
