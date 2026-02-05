# ⚠️ 核心查询规则 - 必读！

**在查询任何表之前，请先阅读这些关键规则，避免常见错误！**

> **📝 动态文档说明**:
> 这些规则是在扫描全部数据集表格的过程中不断发现和添加的。
> 随着对数据仓库理解的深入，规则会持续更新和完善。
> 最后更新: 2026-01-29

---

## 🚨 必须遵守的规则 (违反会导致查询失败或错误结果)

### 规则1: 分区过滤 - 必须包含dt过滤

**为什么**: 避免全表扫描，降低成本，提高性能

**错误示例** ❌:
```sql
SELECT * FROM rpt_points_metric
WHERE user_id = 'usr_123'  -- 没有dt过滤，全表扫描！
```

**正确示例** ✅:
```sql
SELECT * FROM rpt_points_metric
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)  -- 必须有！
  AND user_id = 'usr_123'
```

**适用范围**: 所有按dt分区的表 (几乎所有DWD/DWS/RPT层表)

---

### 规则2: user_group 维度去重 - 防止用户重复计算（必须遵守！）

**🚨 核心问题**: 一个用户可以同时属于多个 user_group 人群包，如果不筛选会导致严重的重复计算！

**为什么会重复**:
- 同一个用户会在多个 user_group 中重复出现
- 例如：user_123 同时存在于 `user_group='all'`、`user_group='ios'`、`user_group='vip'` 等多行记录中
- 如果不筛选 user_group，该用户会被重复统计多次

**真实案例**:
```sql
-- ❌ 错误查询（未筛选user_group）
SELECT SUM(active_user_1d_cnt) as dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt = '2026-02-04'
-- 结果: 17,418 (重复计算了约8-9倍！)

-- ✅ 正确查询（筛选user_group='all'）
SELECT SUM(active_user_1d_cnt) as dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt = '2026-02-04'
  AND user_group = 'all'
-- 结果: 2,055 (真实的DAU)
```

**🎯 强制规则**:

**任何包含 user_group 字段的表，在统计用户数或用户相关指标时：**

1. **不指定人群时**: **必须**筛选 `user_group = 'all'`
2. **指定特定人群时**: 直接筛选该人群 `user_group = 'vip'`
3. **按人群对比时**: 明确排除 'all' → `user_group != 'all'`

**适用场景示例**:

**场景1: 统计全站指标（不指定人群）** ✅
```sql
-- 查询全站DAU
SELECT
  dt,
  SUM(active_user_1d_cnt) as total_dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND user_group = 'all'  -- 🚨 必须加！防止重复计算
GROUP BY dt
ORDER BY dt DESC
```

**场景2: 统计特定人群** ✅
```sql
-- 只看VIP用户的DAU
SELECT
  dt,
  SUM(active_user_1d_cnt) as vip_dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND user_group = 'vip'  -- 指定具体人群
GROUP BY dt
ORDER BY dt DESC
```

**场景3: 按人群维度对比** ✅
```sql
-- 对比各人群的DAU占比
SELECT
  user_group,
  SUM(active_user_1d_cnt) as dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt = CURRENT_DATE() - 1
  AND user_group != 'all'  -- 排除all，只看各细分人群
GROUP BY user_group
ORDER BY dau DESC
```

**场景4: 按其他维度拆分时也要加** ✅
```sql
-- 按平台拆分DAU（也要筛选user_group！）
SELECT
  dt,
  platform,
  SUM(active_user_1d_cnt) as dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND user_group = 'all'  -- 🚨 即使按platform分组，也必须筛选user_group
GROUP BY dt, platform
ORDER BY dt DESC, platform
```

**❌ 常见错误**:
```sql
-- 错误1: 完全不筛选user_group
SELECT SUM(active_user_1d_cnt) as dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt = CURRENT_DATE() - 1
-- 会把 all + ios + android + vip + ... 所有人群的数据加在一起！

-- 错误2: 只按其他维度分组，忘记筛选user_group
SELECT
  platform,
  SUM(active_user_1d_cnt) as dau
FROM rpt_gensmo_user_active_metrics_inc_1d
WHERE dt = CURRENT_DATE() - 1
GROUP BY platform
-- 每个platform下的数据也会重复计算（因为有多个user_group）
```

**📋 如何判断表是否有 user_group 字段？**

1. 查看表的 schema/字段列表
2. 或先执行测试查询：
```sql
SELECT DISTINCT user_group
FROM `table_name`
WHERE dt = CURRENT_DATE() - 1
LIMIT 10
```
3. 如果返回多个值（all, ios, android, vip等），说明有 user_group 维度

**适用范围**:
- 所有包含 `user_group` 字段的 DWS/RPT 层表
- 常见表：rpt_*_metric、dws_*_metric、rpt_*_active_metrics 等

**关键理解**:
- user_group 是**非互斥维度**（一个用户同时属于多个人群）
- platform、country_name 等是**互斥维度**（一个用户某时刻只属于一个值）
- **任何非互斥维度都需要明确过滤策略，防止重复计算**

---

### 规则3: dt是DATE类型，不是STRING

**为什么**: BigQuery中dt字段是DATE类型，不能直接用字符串比较

**错误示例** ❌:
```sql
WHERE dt = '20260128'           -- 类型不匹配！
WHERE dt = '2026-01-28'         -- 还是不行！
WHERE dt BETWEEN '20260121' AND '20260128'  -- 也不行！
```

**正确示例** ✅:
```sql
-- 方式1: PARSE_DATE (从YYYYMMDD格式转换)
WHERE dt = PARSE_DATE('%Y%m%d', '20260128')

-- 方式2: DATE函数 (从标准格式转换)
WHERE dt = DATE('2026-01-28')

-- 方式3: 日期计算 (推荐)
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
WHERE dt = CURRENT_DATE() - 1  -- 昨天

-- 方式4: BETWEEN (使用DATE函数)
WHERE dt BETWEEN DATE('2026-01-21') AND DATE('2026-01-28')
```

**适用范围**: 所有数据仓库表的dt字段

---

### 规则4: 字段命名带重复词

**为什么**: 实际字段名可能与文档不一致（历史原因）

**常见差异**:
| 文档中 | 实际表中 |
|--------|----------|
| earn_points_amt | earn_points_**points_amt** |
| consume_points_amt | consume_points_**points_amt** |

**建议**:
- 查询前先用 `DESCRIBE` 或 `INFORMATION_SCHEMA.COLUMNS` 确认字段名
- 如果查询报"Unrecognized name"，检查是否有重复词

**正确做法** ✅:
```sql
-- 先确认字段名
SELECT column_name
FROM `srpproduct-dc37e.favie_rpt`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'rpt_faive_gensmo_membership_points_metric_inc_1d'

-- 然后使用实际字段名
SELECT earn_points_points_amt  -- 注意是points_points_amt
FROM rpt_points_metric
```

---

## ⚡ 强烈建议遵守的规则 (不遵守会影响性能或可读性)

### 规则5: 避免SELECT *

**为什么**:
- 扫描不需要的列浪费资源
- 代码可读性差
- 未来表结构变更可能导致意外结果

**不推荐** ⚠️:
```sql
SELECT * FROM rpt_points_metric
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
```

**推荐** ✅:
```sql
SELECT
  dt,
  active_user_1d_cnt,
  earn_points_user_cnt,
  consume_points_user_cnt
FROM rpt_points_metric
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND user_group = 'all'
```

---

### 规则6: 除法运算用NULLIF防止除零错误

**为什么**: 分母可能为0导致查询报错

**错误示例** ❌:
```sql
SELECT
  earn_users * 100.0 / dau as participation_rate  -- dau=0时报错！
FROM rpt_points_metric
```

**正确示例** ✅:
```sql
SELECT
  ROUND(earn_users * 100.0 / NULLIF(dau, 0), 2) as participation_rate
FROM rpt_points_metric
```

---

### 规则7: 百分比计算用100.0而非100

**为什么**: 确保浮点运算，避免整数除法

**错误示例** ❌:
```sql
SELECT 50 / 100 as rate  -- 结果是0 (整数除法)
```

**正确示例** ✅:
```sql
SELECT 50 * 100.0 / 100 as rate  -- 结果是50.0
SELECT ROUND(50 * 100.0 / 100, 2) as rate  -- 50.00 (保留2位小数)
```

---

### 规则8: 探索性查询加LIMIT

**为什么**: 避免返回过多数据

**推荐** ✅:
```sql
-- 探索性查询
SELECT * FROM dwd_consume_point
WHERE dt = CURRENT_DATE() - 1
LIMIT 100  -- 先看100条数据

-- 生产查询可以不加LIMIT
SELECT COUNT(*) FROM dwd_consume_point
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
```

---

### 规则9: 先过滤再JOIN

**为什么**: 减少JOIN的数据量，提高性能

**不推荐** ⚠️:
```sql
SELECT a.*, b.*
FROM big_table_a a
JOIN big_table_b b ON a.user_id = b.user_id
WHERE a.dt = CURRENT_DATE() - 1  -- 过滤太晚了
```

**推荐** ✅:
```sql
SELECT a.*, b.*
FROM (
  SELECT * FROM big_table_a
  WHERE dt = CURRENT_DATE() - 1  -- 先过滤
) a
JOIN (
  SELECT * FROM big_table_b
  WHERE dt = CURRENT_DATE() - 1  -- 先过滤
) b ON a.user_id = b.user_id
```

---

## 🌏 时区和时间处理

### 规则10: 统一使用UTC时区

**所有时间戳**: UTC (协调世界时)
**dt分区字段**: 基于UTC的日期切分

**示例**:
```sql
-- 正确: 基于UTC时区获取昨天的数据
WHERE dt = CURRENT_DATE() - 1

-- 如果需要从timestamp转换
WHERE dt = DATE(event_timestamp)  -- event_timestamp已是UTC

-- 如果原始时间是其他时区（如UTC+8），需要先转换
WHERE dt = DATE(TIMESTAMP_SUB(local_timestamp, INTERVAL 8 HOUR))
```

**注意**:
- 不同表可能有不同的时区约定
- 查询前先确认该表的时区说明
- 这是在扫描表时需要注意记录的核心规则之一

---

## 📊 特定场景注意事项

### 场景1: 查询DWD明细表

**必须过滤状态字段**:
```sql
-- 消耗明细
WHERE consume_status = 'consumed'  -- 只统计已消耗的

-- 获取明细
WHERE earn_status = 'earned'  -- 只统计已发放的
```

### 场景2: 计算用户积分余额

**注意**: DWD层没有余额字段，需要自己计算
```sql
WITH earn AS (
  SELECT user_id, SUM(earn_points) as total_earn
  FROM dwd_earn_point
  WHERE dt >= DATE('2025-01-01')  -- 从积分系统上线日开始
    AND earn_status = 'earned'
  GROUP BY user_id
),
consume AS (
  SELECT user_id, SUM(consume_points) as total_consume
  FROM dwd_consume_point
  WHERE dt >= DATE('2025-01-01')
    AND consume_status = 'consumed'
  GROUP BY user_id
)
SELECT
  COALESCE(e.user_id, c.user_id) as user_id,
  COALESCE(e.total_earn, 0) - COALESCE(c.total_consume, 0) as balance
FROM earn e
FULL OUTER JOIN consume c ON e.user_id = c.user_id
```

### 场景3: 分析趋势时排序

**按日期排序**:
```sql
-- 升序（从早到晚）
ORDER BY dt ASC

-- 降序（从晚到早，最新的在前）
ORDER BY dt DESC
```

---

## 🔍 查询失败时的检查清单

如果你的查询失败或返回意外结果，按顺序检查：

- [ ] ✅ **规则1**: 是否包含dt分区过滤?
- [ ] ✅ **规则2**: 聚合查询是否过滤user_group='all'?
- [ ] ✅ **规则3**: dt字段是否用DATE类型正确比较?
- [ ] ✅ **规则4**: 字段名是否正确（有无重复词）?
- [ ] ✅ 表名是否完整? (`project.dataset.table`)
- [ ] ✅ 项目名是否正确? (srpproduct-dc37e)
- [ ] ✅ 是否有权限访问该表?
- [ ] ✅ 数据日期范围是否在表的有效期内?

---

## 📚 相关文档

- [命名规范详细说明](CONVENTIONS.md)
- [查询性能优化](guides/BEST_PRACTICES.md)
- [常见错误排查](guides/TROUBLESHOOTING.md)
- [表选择决策树](domains/points_membership/TABLES.md)

---

## 🎯 快速检查模板

复制这个模板开始你的查询:

```sql
-- ✅ 完整的查询模板
SELECT
  -- 明确列出需要的字段
  dt,
  field1,
  field2
FROM `srpproduct-dc37e.dataset.table_name`
WHERE
  -- 规则1: 必须有dt过滤
  dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  -- 规则2: 聚合表必须过滤user_group
  AND user_group = 'all'
  -- 其他过滤条件
  AND status = 'active'
-- 探索性查询加LIMIT
LIMIT 100
```

---

**最后更新**: 2026-01-29
**维护者**: Data Platform Team

**遇到问题?** 查看 [TROUBLESHOOTING.md](guides/TROUBLESHOOTING.md) 或联系数据团队
