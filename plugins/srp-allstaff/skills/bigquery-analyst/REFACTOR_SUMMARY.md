# BigQuery Analyst Skill 重构总结

**重构日期**: 2026-02-04
**重构原因**: 元数据知识库过大且维护困难
**新版本**: v1.1.0

---

## 🎯 重构目标

将庞大的元数据知识库（metadata/）精简为轻量级指南文档，转变工作模式：

**从**: 依赖完整元数据知识库（metadata/）
**到**: 指南引导 + BigQuery 实时探查

---

## 📝 主要变更

### 1. 新增 `BIGQUERY_GUIDE.md` (11KB)

**替代**: metadata/index/ 和部分 metadata/domains/

**包含内容**:
- ✅ 数据集位置（srpproduct-dc37e.favie_dw, favie_rpt）
- ✅ 表/Function 关系（表名 + `_function` 后缀）
- ✅ 表命名规范（数据层、产品、业务域、更新模式等）
- ✅ 业务域索引（19 个业务域的表数量和核心表）
- ✅ 如何查询未在文档中的表（使用 INFORMATION_SCHEMA）
- ✅ 使用策略（何时查文档 vs 何时查 BigQuery）

### 2. 更新 `SKILL.md`

**核心变更**:

#### a. 知识库加载策略调整

**之前**: 三层渐进式加载（核心规则 → 业务域 README → 表文档）
**现在**: 指南引导 + 主动探查

```
Layer 1: 核心规则与指南 (必须加载)
  - core/CRITICAL_RULES.md
  - core/LAYER_SELECTION.md
  - BIGQUERY_GUIDE.md ⭐ 新增

Layer 2: 主动探查 BigQuery
  - 使用 INFORMATION_SCHEMA 查询表、字段、函数
  - 从函数定义中获取血缘关系
  - 实时获取最新表结构
```

#### b. 工作流程更新

**Step 2: 表选择与字段确认** 现在使用：
1. 查阅 BIGQUERY_GUIDE.md 快速定位
2. 查询 BigQuery 确认表结构
3. 查看函数定义（获取血缘关系）
4. 复习核心规则

**关键 SQL 示例**:
```sql
-- 搜索表
SELECT table_name FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.TABLES`
WHERE table_name LIKE '%tryon%metric%';

-- 查看表结构
SELECT column_name, data_type, is_nullable
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'dws_favie_gensmo_tryon_metric_inc_1d';

-- 查找函数
SELECT routine_name, routine_definition
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
WHERE routine_name LIKE '%tryon_metric%function%';
```

#### c. 文件索引简化

**移除**: metadata/domains 的强依赖
**标注**: metadata/ 下的文档已过时，仅供参考

### 3. 表命名规范文档化

**格式**: `{layer}_{product}_{domain}_{description}_{update_pattern}_{time_range}{suffix}`

**产品说明**:
- `favie_` - 历史产品，很多报表仍使用此命名
- `gem_` / `gensmo_` - **当前主力产品**（AI 搜索、AI 电商、AI 试穿）
- `decofy_` - 已归档产品（基本不使用，除非用户明确提及）

---

## 🔄 工作模式对比

### 之前的模式

```
用户提问
  ↓
加载业务域 README (50KB)
  ↓
加载表文档 (5KB/表)
  ↓
生成 SQL
```

**问题**:
- ❌ 知识库过大（611 张表 × 5KB ≈ 3MB+）
- ❌ 维护困难（表更新时文档可能过时）
- ❌ Token 消耗高

### 现在的模式

```
用户提问
  ↓
查阅 BIGQUERY_GUIDE.md (11KB)
  ↓
能用指南解决？
  ├─ 是 → 直接生成 SQL
  └─ 否 → 查询 BigQuery INFORMATION_SCHEMA
      ↓
  获取最新表结构和函数定义
      ↓
  生成 SQL
```

**优势**:
- ✅ 知识库精简（11KB vs 3MB+）
- ✅ 始终使用最新信息（实时查询）
- ✅ 维护成本低（指南更新频率低）
- ✅ Token 消耗少

---

## 📊 效果对比

| 指标 | 之前 | 现在 | 提升 |
|------|------|------|------|
| 核心文档大小 | ~3MB | ~20KB | **99% 减少** |
| 启动加载 Token | ~100K | ~10K | **90% 减少** |
| 数据时效性 | 静态（可能过时） | 实时查询 | ✅ 始终最新 |
| 维护复杂度 | 高（611 张表） | 低（仅指南） | ✅ 大幅降低 |

---

## 🚀 AI 的新能力

### 1. 自主探查能力

AI 现在能够：
- 根据表命名规范**猜测**可能的表名
- 主动查询 BigQuery 验证表是否存在
- 自主获取字段定义和类型
- 从函数定义中推断血缘关系

### 2. 灵活决策

AI 会根据情况选择最优策略：
- ✅ 指南中有的表 → 直接使用
- ✅ 指南中没有的表 → 主动探查 BigQuery
- ✅ 需要血缘关系 → 查看函数定义或使用 Dataplex

### 3. 适应新表

AI 不再受限于预扫描的 611 张表：
- ✅ 新增的表能够自动发现
- ✅ 表结构变更能够实时获取
- ✅ 不需要重新扫描整个知识库

---

## 📂 文件结构变化

### 保留的文件

```
bigquery-analyst/
├── SKILL.md                    # ✏️ 已更新 - 新工作流程
├── README.md                   # 保持不变
├── BIGQUERY_GUIDE.md           # ⭐ 新增 - 核心指南文档
├── setup.sh                    # 保持不变
├── install_prehook.sh          # 保持不变
├── bigquery_prehook.sh         # 保持不变
│
├── core/                       # 保持不变
│   ├── CRITICAL_RULES.md
│   └── LAYER_SELECTION.md
│
└── metadata/                   # ⚠️ 标注为历史文档，仅供参考
    ├── index/
    └── domains/
```

### metadata/ 目录的新定位

**状态**: 保留但标注为"历史文档"
**用途**:
- 仅供参考（可能已过时）
- 查看示例 SQL
- 了解业务逻辑补充说明

**不再用于**:
- ❌ 不再作为主要数据源
- ❌ 不在启动时加载
- ❌ 不定期更新维护

---

## 🎓 使用策略

### 何时查阅指南？

✅ **快速定位**:
- 用户问题涉及哪个业务域？
- 可能的表名是什么？
- 数据层（DIM/DWD/DWS/RPT）的区别？

### 何时查询 BigQuery？

✅ **实时探查**:
- 指南中没有列出的表
- 需要确认字段名称和类型
- 需要查看函数定义
- 需要血缘关系

### 何时参考历史文档？

⚠️ **仅供参考**:
- 无法通过 BigQuery 查询获取信息时
- 需要业务逻辑的补充说明
- 查看示例 SQL 作为参考

---

## ✅ 验证清单

重构后需要验证的内容：

- [ ] BIGQUERY_GUIDE.md 包含所有必要信息
- [ ] SKILL.md 的工作流程清晰明确
- [ ] AI 能够根据命名规范猜测表名
- [ ] AI 能够主动查询 BigQuery INFORMATION_SCHEMA
- [ ] AI 能够从函数定义中获取血缘关系
- [ ] PreHook 仍然正常工作
- [ ] 核心规则（CRITICAL_RULES.md）仍然被遵守

---

## 📋 后续优化建议

### 短期（1-2 周）

1. **测试新工作流程**
   - 使用实际查询场景测试
   - 收集 AI 的探查效果反馈

2. **完善 BIGQUERY_GUIDE.md**
   - 根据使用情况补充常见表
   - 优化业务域描述

### 中期（1-2 月）

1. **考虑移除 metadata/ 目录**
   - 如果确认不再需要，可以完全删除
   - 减少项目体积

2. **完善血缘关系查询**
   - 确认是否能通过 GCP CLI 访问 Dataplex
   - 提供更便捷的血缘关系查询方式

### 长期（3-6 月）

1. **自动化指南更新**
   - 定期（每月/每季度）从 BigQuery 提取表统计信息
   - 自动更新 BIGQUERY_GUIDE.md 的表数量

2. **扩展到其他数据源**
   - 如果有新的数据集，应用相同的模式
   - 保持指南轻量级

---

## 🙋 常见问题

### Q1: 为什么不直接删除 metadata/ 目录？

**A**: 保留作为历史参考，因为：
- 某些表的业务逻辑说明仍有价值
- 示例 SQL 可以作为参考
- 方便回滚（如果新模式有问题）

### Q2: AI 如何知道哪些表是常用表？

**A**: 通过 BIGQUERY_GUIDE.md 中的业务域索引：
- 列出了各业务域的核心表
- 标注了表的数量和优先级
- AI 可以根据用户问题快速定位

### Q3: 如果 BigQuery 查询失败怎么办？

**A**: 降级到历史文档：
- 优先使用 INFORMATION_SCHEMA 查询
- 如果查询失败，参考 metadata/ 下的历史文档
- 同时提示用户可能需要权限或网络检查

### Q4: 血缘关系如何获取？

**A**: 三种方式（按优先级）：
1. 从函数定义中推断（routine_definition 包含上游表引用）
2. 使用 GCP Dataplex 控制台查看
3. 参考 metadata/ 下的 lineage.json（可能已过时）

---

**重构完成日期**: 2026-02-04
**下一步**: 测试新工作流程并收集反馈
