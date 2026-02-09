# 数据层级选择指南

**快速决策**: 根据查询需求选择正确的数据层

---

## 🎯 四层数据架构

```
RPT (报表层) ← 优先使用
  ↑
DWS (服务层) ← 需要自定义维度时
  ↑
DWD (明细层) ← 需要明细数据时
  ↑
ODS (原始层) ← 仅用于数据排查
```

---

## 📊 快速决策树

```
我的查询需要...

┌─ 现成的业务指标? (DAU、人均、转化率等)
│  └─ YES → 用 RPT 层 ✅
│     示例: rpt_points_metric, rpt_user_active_metrics
│
├─ 按维度聚合? (平台、地域、人群)
│  ├─ 维度在RPT层已有?
│  │  └─ YES → 用 RPT 层 + 过滤维度 ✅
│  └─ NO → 用 DWS 层 或 DWD层+自定义聚合
│     示例: dws_points_metric (device级别)
│
├─ 单条记录明细? (某用户的消耗历史)
│  └─ YES → 用 DWD 层
│     示例: dwd_consume_point, dwd_earn_point
│
└─ 原始日志排查?
   └─ 联系数据团队,一般不自行查询ODS
```

---

## 📋 各层详细说明

### RPT 报表层 (优先使用 ⭐⭐⭐⭐⭐)

**特点**:
- ✅ 指标已预计算,查询最快
- ✅ 数据已清洗,质量最高
- ✅ 按标准维度聚合,开箱即用

**适用场景**:
1. **趋势分析**: 最近7天DAU趋势
2. **指标查询**: 今天的人均积分
3. **维度对比**: iOS vs Android的活跃率

**命名规范**:
- `rpt_{业务域}_{指标类型}_metric_inc_{周期}`
- 示例: `rpt_faive_gensmo_membership_points_metric_inc_1d`

**典型字段**:
- 维度: dt, platform, country, user_group
- 指标: active_user_cnt, earn_points_amt, consume_points_cnt
- 派生: net_points_change, participation_rate

**注意事项**:
- ⚠️ 必须过滤 `user_group='all'` (避免重复计数)
- ⚠️ 数据更新时间: T+1 09:00 (UTC)

---

### DWS 服务层 (需要自定义维度时 ⭐⭐⭐⭐)

**特点**:
- ✅ 按device_id聚合,粒度较细
- ✅ 包含更多维度字段
- ✅ 可自定义聚合逻辑

**适用场景**:
1. **自定义维度**: 按app_version分析
2. **灵活聚合**: 需要COUNT DISTINCT device
3. **中间结果**: RPT层没有的维度组合

**命名规范**:
- `dws_{业务域}_{指标类型}_metric_inc_{周期}`
- 示例: `dws_faive_gensmo_membership_points_metric_inc_1d`

**典型字段**:
- 维度: dt, device_id, platform, app_version, country, user_group
- 指标: 与RPT层类似,但粒度更细

**注意事项**:
- ⚠️ 需要自己SUM/AVG聚合到目标粒度
- ⚠️ 数据量比RPT层大10-100倍

---

### DWD 明细层 (需要明细数据时 ⭐⭐⭐)

**特点**:
- ✅ 一条记录一个事件
- ✅ 包含事件完整信息
- ✅ 可自定义任意聚合

**适用场景**:
1. **明细查询**: 某用户的积分消耗记录
2. **复杂计算**: 需要自己定义计算逻辑
3. **异常排查**: 查看单条记录详情

**命名规范**:
- `dwd_{业务域}_{事件类型}_inc_{周期}`
- 示例: `dwd_favie_gensmo_membership_consume_point_inc_1d`

**典型字段**:
- 主键: event_id, user_id, device_id
- 事件: consume_type, consume_points, consume_time
- 状态: consume_status (必须过滤)

**注意事项**:
- ⚠️ 必须过滤状态字段 (如 consume_status='consumed')
- ⚠️ 数据量大,必须加LIMIT或严格时间过滤
- ⚠️ 更新时间: T+1 07:00 (比RPT早2小时)

---

### ODS 原始层 (仅用于排查 ⭐)

**特点**:
- 原始业务日志,未清洗
- 可能包含脏数据
- 一般不直接查询

**适用场景**:
- 数据质量问题排查
- 上游系统问题诊断
- 需要数据团队协助

**建议**:
- 优先联系数据团队
- 不要自行直接查询ODS

---

## 🔍 实战案例

### 案例1: 查询最近7天DAU

**需求**: "查询最近7天的日活跃用户数"

**决策**:
- 需要现成指标? YES → RPT层
- 指标: active_user_1d_cnt ✅
- 选择: `rpt_points_metric` (或任何包含DAU的RPT表)

**SQL**:
```sql
SELECT dt, active_user_1d_cnt as dau
FROM `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND user_group = 'all'  -- 必须!
ORDER BY dt
```

---

### 案例2: 分析各消耗类型占比

**需求**: "统计各功能的积分消耗占比"

**决策**:
- 需要consume_type维度? YES
- RPT层有这个维度? NO (RPT已聚合)
- 需要明细? YES → DWD层
- 选择: `dwd_consume_point`

**SQL**:
```sql
SELECT
  consume_type,
  SUM(consume_points) as total_points,
  ROUND(SUM(consume_points) * 100.0 / SUM(SUM(consume_points)) OVER(), 2) as pct
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  AND consume_status = 'consumed'
GROUP BY consume_type
ORDER BY total_points DESC
```

---

### 案例3: 按app_version分析

**需求**: "对比不同app版本的用户活跃情况"

**决策**:
- RPT层有app_version维度? YES
- 可直接过滤? YES → RPT层
- 选择: `rpt_points_metric`

**SQL**:
```sql
SELECT
  app_version,
  SUM(active_user_1d_cnt) as dau,
  SUM(earn_points_user_cnt) as earn_users
FROM `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d`
WHERE dt = CURRENT_DATE() - 1
  AND user_group = 'all'
GROUP BY app_version
ORDER BY dau DESC
```

---

## 📐 选择原则总结

### 优先级顺序

1. **优先RPT**: 90%的查询应该用RPT层
2. **其次DWS**: 需要device粒度或自定义维度时
3. **最后DWD**: 必须用明细数据时才用
4. **避免ODS**: 除非排查问题,否则不用

### 性能考虑

| 层级 | 数据量 | 查询速度 | 成本 |
|------|--------|---------|------|
| RPT  | 小 (~100行/天) | 最快 ⚡⚡⚡ | 最低 💰 |
| DWS  | 中 (~500行/天) | 快 ⚡⚡ | 中 💰💰 |
| DWD  | 大 (~数千-数万行/天) | 慢 ⚡ | 高 💰💰💰 |
| ODS  | 超大 | 很慢 | 很高 💰💰💰💰 |

---

## ⚠️ 常见错误

### ❌ 错误1: 用DWD层查询聚合指标

```sql
-- 错误: 用明细表查DAU (性能差)
SELECT dt, COUNT(DISTINCT device_id) as dau
FROM dwd_consume_point
WHERE dt >= ...
GROUP BY dt
```

**正确**:
```sql
-- 正确: 直接用RPT层的现成指标
SELECT dt, active_user_1d_cnt as dau
FROM rpt_points_metric
WHERE dt >= ...
```

---

### ❌ 错误2: 混用不同层级

```sql
-- 错误: 一个查询混用RPT和DWD
SELECT r.*, d.consume_type
FROM rpt_points_metric r
JOIN dwd_consume_point d ON r.dt = d.dt  -- 粒度不匹配!
```

**正确**: 选择一个层级,在该层级内完成查询

---

### ❌ 错误3: 忘记过滤状态字段

```sql
-- 错误: DWD层未过滤状态
SELECT * FROM dwd_consume_point
WHERE dt = CURRENT_DATE() - 1  -- 包含未消耗的记录!
```

**正确**:
```sql
SELECT * FROM dwd_consume_point
WHERE dt = CURRENT_DATE() - 1
  AND consume_status = 'consumed'  -- 必须过滤
```

---

**最后更新**: 2026-01-30
**相关文档**: CRITICAL_RULES.md, DOMAIN_INDEX.md
