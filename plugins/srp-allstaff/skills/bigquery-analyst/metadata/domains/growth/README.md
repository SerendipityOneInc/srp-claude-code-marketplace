# 增长归因

**业务域**: growth
**最后更新**: 2026-01-30
**表数量**: 10 张

---

## 📊 业务概述

App增长、渠道归因、安装追踪、市场渗透

**关键词**: 增长, 归因, AppsFlyer

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_gensmo_action_penetration_view` | RPT | --- |
| `rpt_gensmo_action_user_penetration_metric_inc_1d` | RPT | --- |
| `rpt_gensmo_refer_click_user_penetration_metric_inc_1d` | RPT | --- |
| `dwd_all_app_appsflyer_webhook_only_install_1d_view` | DWD | --- |
| `dwd_all_app_appsflyer_webhook_v2_inc_1d_view` | DWD | --- |
| `dwd_all_app_total_appsflyer_webhook_inc_1d_view` | DWD | --- |


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
