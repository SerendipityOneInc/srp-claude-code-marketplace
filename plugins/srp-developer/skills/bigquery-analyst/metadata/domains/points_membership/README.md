# 积分会员

**业务域**: points_membership
**最后更新**: 2026-01-30
**表数量**: 10 张

---

## 📊 业务概述

积分赚取、消耗、会员等级、权益管理

**关键词**: 积分, 会员, points

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_faive_gensmo_membership_consume_points_metric_inc_1d` | RPT | --- |
| `rpt_faive_gensmo_membership_earn_points_metric_inc_1d` | RPT | --- |
| `rpt_faive_gensmo_membership_points_metric_inc_1d` | RPT | --- |
| `dws_faive_gensmo_membership_consume_points_metric_inc_1d` | DWS | --- |
| `dws_faive_gensmo_membership_earn_points_metric_inc_1d` | DWS | --- |
| `dws_faive_gensmo_membership_points_metric_inc_1d` | DWS | --- |


更多表请参见 [TABLES.md](./TABLES.md)

---

## 💡 常见查询场景

### 场景 1: 按功能类型分析积分消耗

**需求**: 了解最近一段时间各功能的积分消耗情况和用户使用偏好

**推荐表**: `dwd_favie_gensmo_membership_consume_point_inc_1d` (DWD 层明细表)

**选择原因**: 需要按 consume_type 维度分析，需使用明细表

**示例 SQL**:
```sql
SELECT
  consume_type,
  SUM(consume_points) AS total_points,
  COUNT(DISTINCT user_id) AS unique_users,
  COUNT(*) AS consume_count
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d`
WHERE
  dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND consume_status = 'consumed'
GROUP BY consume_type
ORDER BY total_points DESC
```

---

### 场景 2: 积分消耗趋势分析

**需求**: 查看每日积分消耗趋势，监控业务健康度

**推荐表**: `dws_faive_gensmo_membership_consume_points_metric_inc_1d` (DWS 层聚合表)

**选择原因**: 按日期统计趋势，DWS 层已聚合，性能更好

**示例 SQL**:
```sql
SELECT
  dt,
  SUM(total_consume_points) AS daily_points,
  SUM(unique_consume_users) AS daily_users
FROM `srpproduct-dc37e.favie_dws.dws_faive_gensmo_membership_consume_points_metric_inc_1d`
WHERE
  dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
  AND user_group = 'all'
GROUP BY dt
ORDER BY dt DESC
```

---

### 场景 3: 用户积分余额查询

**需求**: 查看特定用户的当前积分余额

**推荐表**: `rpt_faive_gensmo_membership_points_metric_inc_1d` (RPT 层报表)

**选择原因**: 查询单个用户，RPT 层性能最优

**示例 SQL**:
```sql
SELECT
  user_id,
  current_points,
  total_earned_points,
  total_consumed_points
FROM `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d`
WHERE
  dt = CURRENT_DATE() - 1
  AND user_id = 'TARGET_USER_ID'
```

---

### 场景 4: 积分赚取渠道分析

**需求**: 分析用户通过哪些渠道赚取积分

**推荐表**: `dwd_favie_gensmo_membership_earn_point_inc_1d` (DWD 层明细表)

**选择原因**: 需要按 earn_type 维度分析，使用明细表

**示例 SQL**:
```sql
SELECT
  earn_type,
  SUM(earn_points) AS total_earned,
  COUNT(DISTINCT user_id) AS unique_users
FROM `srpproduct-dc37e.favie_dwd.dwd_favie_gensmo_membership_earn_point_inc_1d`
WHERE
  dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND earn_status = 'earned'
GROUP BY earn_type
ORDER BY total_earned DESC
```

---

### 场景 5: 用户积分消耗行为分析

**需求**: 分析高频消耗用户的特征和行为模式

**推荐表**: `dwd_favie_gensmo_membership_consume_point_inc_1d` (DWD 层明细表)

**选择原因**: 需要用户级别的明细分析

**示例 SQL**:
```sql
SELECT
  user_id,
  COUNT(*) AS consume_frequency,
  SUM(consume_points) AS total_consumed,
  COUNT(DISTINCT consume_type) AS function_variety
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d`
WHERE
  dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
  AND consume_status = 'consumed'
GROUP BY user_id
HAVING consume_frequency >= 5
ORDER BY total_consumed DESC
LIMIT 100
```

---

## 🔗 相关资源

- [表清单](./TABLES.md) - 完整表列表
- [通用函数](./common_functions/) - 可复用的查询函数

---

**文档生成**: 2026-01-30 15:33:23
**维护者**: Data Platform Team
