---
name: bigquery-analyst
description: 安全、高效的 BigQuery 数据分析助手 - 指南引导 + 主动探查
---

# BigQuery Analyst Skill

## 🎯 核心使命

帮助用户安全、准确地分析 BigQuery 数据,确保:
1. **需求对齐**: 先确认指标口径,再写SQL
2. **成本可控**: 自动检查 Slot Time,超过阈值拒绝执行
3. **结果可信**: AI自检合理性,输出业务解释

## 📊 数据环境

- **项目**: srpproduct-dc37e
- **数据集**: favie_rpt (报表层), favie_dw (数仓层)
- **表数量**: 608张生产表 + 519个函数
- **业务域**: 16个主要业务域
- **数据范围**: 2025-01-01 至今

## ⚠️ 归档业务域

**decofy 域（已归档）**:
- **状态**: 该应用已归档，基本不再使用
- **规则**: **除非用户明确提及 "decofy"，否则默认不扫描该域下的表和文档**
- **原因**: 避免不必要的上下文加载，提高查询效率
- **位置**: `metadata/domains/decofy/` (66张表)

💡 **如何触发**: 当用户问题包含 "decofy" 关键词时，才加载该域的数据

## ⚠️ 启动安全检查（必须执行）

**在处理任何查询请求前，必须先执行以下检查**:

```instructions
CRITICAL: 检查 PreHook 是否已安装

1. 使用 Bash 工具检查文件是否存在:
   ls ~/.claude/hooks/bigquery_prehook.sh

2. 如果文件不存在或不可执行:
   ❌ 立即停止，拒绝继续
   ❌ 输出错误信息（见下方模板）
   ❌ 不要生成任何 SQL 查询

3. 如果文件存在且可执行:
   ✅ 继续正常流程
```

**错误信息模板（PreHook 未安装时）**:

```markdown
❌ 无法执行查询：PreHook 未安装

## 为什么需要 PreHook？

PreHook 提供关键的安全防护：
- ✅ 拦截破坏性操作（DROP/DELETE/UPDATE/INSERT）
- ✅ 预估查询成本，超过阈值拒绝执行
- ✅ 验证核心规则（dt 过滤、user_group 过滤）

**没有 PreHook，可能导致**：
- ❌ 误删生产数据
- ❌ 产生高额费用（单次查询可能超过 $100）
- ❌ 违反数据安全规范

## 如何安装 PreHook？

请运行以下命令（仅需一次）：

\`\`\`bash
cd .claude/skills/bigquery-analyst
./install_prehook.sh
\`\`\`

安装完成后，请重新运行查询请求。

**安装文档**: 查看 `PREHOOK_LOCATION.md` 或 `QUICK_START.md`
```

**注意**: 此检查**不可跳过**，这是强制性的安全要求。

---

## 📚 知识库策略 (指南引导 + 主动探查)

### 核心思路

**不再依赖完整元数据知识库**，而是使用**轻量级指南 + BigQuery 实时查询**的模式：

1. ✅ **优先查阅指南** - 快速定位业务域和表命名规范
2. ✅ **主动探查数据集** - 使用 BigQuery `INFORMATION_SCHEMA` 查询最新表结构
3. ✅ **查看函数定义** - 从函数 SQL 定义中获取血缘关系
4. ✅ **灵活决策** - 能用指南解决就不查询，需要时果断探查

---

### Layer 1: 核心规则与指南 (必须加载 ~20KB)

**在处理任何查询前,必须先读取**:

```instructions
1. READ core/CRITICAL_RULES.md - 10条必遵守的查询规则
2. READ core/LAYER_SELECTION.md - 快速决策用哪个数据层
3. READ BIGQUERY_GUIDE.md - 数据集位置、表命名规范、业务域索引
4. READ TABLES_COMPLETE.md - 所有 611 张表的完整列表（按业务域分类）
```

**为什么必须**:
- 避免 90% 的常见错误（缺少 dt 过滤、user_group 重复计数等）
- 了解表命名规范，能够快速猜测可能的表名
- **查看完整表清单，优先使用文档中列出的 611 张表**
- 掌握如何主动查询 BigQuery 获取最新信息（仅当表不在文档中时）

---

### Layer 2: 主动探查 (按需查询 BigQuery)

**新工作模式**: 不依赖预扫描的元数据文档，而是**主动查询 BigQuery 数据集**

#### 何时使用指南？

**✅ 指南可以解决的场景**：
1. 快速定位业务域（如：试穿 → tryon 域）
2. **查看完整表清单 (TABLES_COMPLETE.md)** - 包含所有 611 张表
3. 了解数据层的区别（DIM/DWD/DWS/RPT）
4. 猜测可能的表名（根据命名规范）

**示例**: 用户问"查询试穿功能的成功率"
- ✅ 从 BIGQUERY_GUIDE.md 看到 tryon 域
- ✅ 查看 TABLES_COMPLETE.md 中 tryon 域的所有 24 张表
- ✅ 选择合适的表：`rpt_favie_gensmo_tryon_metric_inc_1d`
- ✅ **无需查询 BigQuery**，直接使用

#### 何时主动探查 BigQuery？

**✅ 需要查询 BigQuery 的场景**（仅当以下情况发生时）：
1. **TABLES_COMPLETE.md 中没有列出的表**（新创建的表）
2. 需要确认字段名称和类型
3. 需要查看函数定义和血缘关系
4. 需要验证表是否存在

**重要**: 由于 TABLES_COMPLETE.md 已包含所有 611 张表，绝大部分查询都能直接找到表，**无需查询 BigQuery**

**示例查询**：

```sql
-- 1. 搜索表（根据命名规范猜测）
SELECT table_name
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.TABLES`
WHERE table_name LIKE '%tryon%metric%'
  AND table_type = 'TABLE';

-- 2. 查看表结构
SELECT column_name, data_type, is_nullable, description
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'dws_favie_gensmo_tryon_metric_inc_1d'
ORDER BY ordinal_position;

-- 3. 查找对应的函数
SELECT routine_name, routine_type, routine_definition
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
WHERE routine_type = 'TABLE_VALUED_FUNCTION'
  AND routine_name LIKE '%tryon_metric%';

-- 4. 查看函数定义（包含上游表引用 = 血缘关系）
SELECT routine_definition
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
WHERE routine_name = 'dws_favie_gensmo_tryon_metric_inc_1d_function';
```

---

### 决策流程图

```
用户提问
    ↓
查阅 BIGQUERY_GUIDE.md
    ↓
能否从指南直接定位表？
    ↓ 是
直接使用 → 查询 BigQuery 获取字段结构 → 生成 SQL
    ↓ 否
主动探查 BigQuery
    ↓
搜索可能的表名（根据命名规范）
    ↓
查看表结构和函数定义
    ↓
生成 SQL
```

---

### 重要提醒

⚠️ **metadata/ 目录下的详细表文档已过时，不推荐使用**
- 这些文档在 2026-01-30 扫描生成，可能已经过时
- 优先使用 `BIGQUERY_GUIDE.md` 和 BigQuery `INFORMATION_SCHEMA` 查询
- 仅当无法通过查询获取信息时，才考虑查看 metadata/ 下的文档作为参考

---

## 🔄 标准查询工作流

### Step 1: 需求理解与口径确认

**用户提问示例**:
```
"查询最近7天积分消耗量最高的功能"
```

**AI 分析流程**:

```instructions
1. 识别业务域: "积分消耗" → points_membership域
2. 加载域概览: READ metadata/domains/points_membership/README.md
3. 提取关键指标:
   - "消耗量" = consume_points_points_amt (积分数) 还是 consume_points_user_cnt (用户数)?
   - "功能" = consume_type字段
   - "最近7天" = dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)

4. 生成确认清单:
```

**输出给用户**:
```markdown
📊 **指标口径确认**:

1. **"消耗量"** 的定义:
   - A) 消耗积分总数 (consume_points_points_amt)
   - B) 消耗用户数 (consume_points_user_cnt)
   - C) 消耗次数 (consume_points_task_cnt)

   您的选择: _____

2. **时间范围**:
   - 数据截止到昨天 (2026-01-29)
   - 时区: UTC
   - 确认? 是/否

3. **人群筛选**:
   - A) 全部用户 (user_group='all')
   - B) 特定平台 (如Android)

   您的选择: _____

请确认后我生成SQL。
```

---

### Step 2: 表选择与字段确认

**用户确认**: "A, 全部用户"

**AI 执行**:

```instructions
1. 查阅 BIGQUERY_GUIDE.md
   → 业务域: points_membership
   → 根据命名规范猜测可能的表:
     - dwd_favie_gensmo_membership_consume_point_inc_1d (明细层)
     - rpt_*_membership_*_metric_inc_1d (报表层)
   → 决策: 需要 consume_type 维度 → 选择明细层表

2. 查询 BigQuery 确认表结构
   ```sql
   -- 确认表是否存在
   SELECT table_name
   FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.TABLES`
   WHERE table_name LIKE '%membership%consume%';

   -- 获取字段定义
   SELECT column_name, data_type, is_nullable
   FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.COLUMNS`
   WHERE table_name = 'dwd_favie_gensmo_membership_consume_point_inc_1d'
   ORDER BY ordinal_position;
   ```

   → 确认字段:
     - dt: DATE类型,分区字段 ✅
     - consume_type: STRING, 消耗类型 ✅
     - consume_points: INTEGER, 消耗积分数 ✅
     - consume_status: STRING, 状态过滤 ✅

3. 查看对应的函数（可选）
   ```sql
   -- 查找函数
   SELECT routine_name, routine_definition
   FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
   WHERE routine_name LIKE '%membership_consume%function%';
   ```

   → 从函数定义中了解:
     - 必须过滤 consume_status='consumed'
     - 可能的上游表（血缘关系）

4. 复习 core/CRITICAL_RULES.md
   → 规则1: 必须dt过滤 ✅
   → 规则3: dt是DATE类型 ✅
   → 规则6: 除法用NULLIF ✅
```

---

### Step 3: SQL 生成

⚠️ **关键规则：禁止使用中文字段别名**

```plaintext
❌ 错误示例:
SELECT SUM(consume_points) AS 总积分  -- 会导致 PreHook 成本检查失败

✅ 正确示例:
SELECT SUM(consume_points) AS total_points  -- 必须使用英文别名
```

**应用规则生成SQL**:

```sql
-- ✅ 遵循所有核心规则的标准SQL
SELECT
  consume_type,
  SUM(consume_points) as total_points,  -- ✅ 使用英文别名
  COUNT(DISTINCT user_id) as unique_users,
  ROUND(SUM(consume_points) * 100.0 / NULLIF(SUM(SUM(consume_points)) OVER(), 0), 2) as percentage
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d`
WHERE
  -- 规则1: 必须dt过滤
  dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
  -- 规则: 只统计已消耗
  AND consume_status = 'consumed'
GROUP BY consume_type
ORDER BY total_points DESC
LIMIT 10
```

**成本预估** (通过PreHook):
```bash
# Dry-run检查
bq query --dry_run --use_legacy_sql=false "..."
# 输出: Will process 500 MB
# 估算: 500MB ≈ 0.014 slot-hours ✅ 远低于20小时阈值
```

---

### Step 4: 结果校验与解释

**执行查询后,AI自检**:

```instructions
1. 数据范围检查:
   - 返回行数是否合理? (TOP10不应返回100行)
   - 日期范围正确? (7天内,不应有去年数据)

2. 数值合理性:
   - total_points是否为正数? ✅
   - percentage总和是否≈100%? ✅
   - unique_users是否合理? (1千-1万,不应是100万)

3. 空值检查:
   - consume_type是否有NULL?
   - 若有,说明数据质量问题,需提示

4. 异常检测:
   - 某个功能占比>80%? 需特别说明
   - 某天数据突降/突增? 需标注异常

5. 数据溯源说明 (新增):
   - 准备向用户解释:表选择原因、字段计算逻辑
   - 格式: 不需要完整SQL,用简洁的业务语言描述
```

**输出给用户**:

```markdown
## 📊 查询结果

### 数据概览
- 时间范围: 2026-01-23 至 2026-01-29 (7天)
- 总消耗积分: 25,732分
- 去重用户数: 1,723人

### 功能消耗排行 TOP 5

1. **情侣装试穿 (try_on_couple)** - 49.1%
   - 消耗积分: 12,640分
   - 用户数: 892人
   - 💡 解读: 绝对核心功能,占比接近一半

2. **视频试穿 (try_on_video)** - 22.7%
   - 消耗积分: 5,853分
   - 用户数: 421人

3. **头像精修 (avatar_refine)** - 11.1%
   - 消耗积分: 2,851分
   - 用户数: 298人

...

### ⚠️ 重要发现
- 🔍 情侣装试穿功能远超其他功能,建议优化质量和体验
- 📉 1月28-29日消耗量下降56%,需立即排查原因

### 📋 数据来源与计算逻辑
**数据表**: `favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d` (DWD层明细表)
- **选择原因**: 需要按功能类型(consume_type)分析，RPT层无此维度，需使用明细表
- **数据范围**: dt >= 2026-01-23 (最近7天)，仅统计 consume_status='consumed'

**核心指标计算**:
- **消耗积分** = SUM(consume_points) 按功能类型聚合
- **用户数** = COUNT(DISTINCT user_id) 去重统计
- **占比** = 各功能消耗积分 / 全部功能消耗积分总和

### 数据说明
- ✅ 所有数据已过滤consume_status='consumed'
- ✅ 时区: UTC
- ⚠️ DWD层明细表,数据更新延迟约8小时
```

---

## ⚠️ 安全防护 (PreHook)

**PreHook自动拦截**:
```bash
# 1. 破坏性操作
❌ DROP/DELETE/TRUNCATE/UPDATE/INSERT → 拒绝执行

# 2. 成本检查
❌ Slot Time > 20 hours → 拒绝执行

# 3. 层级建议
⚠️ 访问ODS/DWD层 → 警告(允许但建议用RPT)
```

配置文件: `../../hooks/bigquery_prehook.sh`

---

## 📂 核心文件索引

### 必读文件 (启动时加载)

**核心指南** (总计 ~20KB):
- `core/CRITICAL_RULES.md` - 10条核心查询规则
- `core/LAYER_SELECTION.md` - 数据层级选择指南
- `BIGQUERY_GUIDE.md` - **数据集位置、表命名规范、业务域索引** ⭐ 新增

### 探查工具 (运行时使用)

**BigQuery INFORMATION_SCHEMA** (实时查询):
- 表搜索: `INFORMATION_SCHEMA.TABLES`
- 字段查询: `INFORMATION_SCHEMA.COLUMNS`
- 函数查询: `INFORMATION_SCHEMA.ROUTINES`

### 历史文档 (仅供参考)

**⚠️ 以下文档已过时，不推荐使用，优先查询 BigQuery**:
- `metadata/index/` - 2026-01-30 扫描的全局索引（可能已过时）
- `metadata/domains/*/` - 各业务域的详细表文档（可能已过时）

**何时参考历史文档**:
- 仅当无法通过 BigQuery 查询获取信息时
- 作为业务逻辑的补充说明
- 查看示例 SQL 作为参考

---

## 💡 最佳实践

### ✅ DO (推荐做法)

1. **渐进式查询**: 先探索性查询LIMIT 100 → 确认无误后去掉LIMIT
2. **优先RPT层**: 现成指标,性能最优
3. **明确时间范围**: 总是指定dt过滤,避免全表扫描
4. **确认人群**: 聚合查询必须过滤user_group,避免重复计数

### ❌ DON'T (避免做法)

1. **不要SELECT ***: 明确列出需要的字段
2. **不要跨层JOIN**: 同一查询不要混用ODS/DWD/RPT层
3. **不要猜测字段**: 不确定时,先READ表文档确认
4. **不要忽略规则**: 10条核心规则必须严格遵守

---

## 🔍 调试提示

**查询失败时检查清单**:
- [ ] 是否包含dt分区过滤? → 规则1
- [ ] 聚合查询是否过滤user_group='all'? → 规则2
- [ ] dt是否用DATE类型? → 规则3
- [ ] 字段名是否正确(有无重复词)? → 规则4
- [ ] 表名是否完整(project.dataset.table)? → 基础检查

**性能问题时**:
- 检查是否扫描了过多分区 (建议≤30天)
- 检查是否有不必要的JOIN
- 考虑是否可用更高层级的聚合表

---

## 📞 获取帮助

**遇到问题**:
1. 检查 `core/CRITICAL_RULES.md` 是否遗漏
2. 查看 `metadata/domains/{domain}/README.md` 的已知问题
3. 参考 `examples/` 目录的相似示例

**反馈渠道**:
- 数据团队: data-team@company.com
- Issue系统: [内部GitLab]

---

**最后更新**: 2026-02-04
**维护者**: Data Platform Team
**工作模式**: 轻量级指南 + BigQuery 实时探查
