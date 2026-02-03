# BigQuery Analyst Skill

**安全、高效的 BigQuery 数据分析助手 - 基于完整元数据知识库**

## 📋 技能简介

BigQuery Analyst 是一个专业的数据分析技能，帮助团队成员安全、准确地查询和分析 BigQuery 数据。通过完整的元数据知识库和智能查询工作流，确保查询结果可信、成本可控。

### 核心特性

✅ **成本保护** - PreHook 自动检查查询成本，超过阈值自动拦截
✅ **规则引导** - 10 条核心规则避免 90% 的常见错误
✅ **元数据完整** - 611 张表 + 519 个函数的完整文档
✅ **需求澄清** - AI 主动确认指标口径，避免理解偏差
✅ **结果可信** - AI 自检 + 数据溯源说明，透明可追溯

---

## 🚀 快速开始

### 1. 安装 PreHook

PreHook 是成本检查和安全防护的核心组件，必须先安装：

```bash
# 在技能目录运行安装脚本
bash setup.sh
```

安装后，每次执行 BigQuery 查询前都会自动进行：
- 🛡️ 破坏性操作检查（DROP/DELETE/UPDATE）
- 💰 成本预估（Slot Time 超过 20 小时拒绝执行）
- 🚨 中文别名检测（自动拦截）
- ✅ 核心规则检查（dt 分区、user_group 过滤等）

### 2. 开始使用

直接向 Claude 提问：

```
最近 7 天哪个功能的积分消耗最多？
```

AI 会：
1. 📊 生成指标口径确认清单（供你确认）
2. 🔍 从 611 张表中选择正确的表
3. ✍️ 生成符合规则的 SQL
4. 💰 执行成本检查（dry-run）
5. ✅ 输出结果并附带数据溯源说明

---

## 📂 文件结构

```
bigquery-analyst/
├── SKILL.md                    # 主技能文档（AI 指令）
├── README.md                   # 本文件（使用说明）
├── setup.sh                    # PreHook 安装脚本
├── install_prehook.sh          # PreHook 安装器
├── bigquery_prehook.sh         # PreHook 主脚本
│
├── core/                       # 核心规则（运行时必需）
│   ├── CRITICAL_RULES.md       # 10 条核心查询规则
│   └── LAYER_SELECTION.md      # 数据层选择指南
│
├── metadata/                   # 元数据知识库（运行时必需）
│   ├── domains/                # 17 个业务域（611 张表）
│   │   ├── advertising/        # 广告投放域
│   │   ├── chat/               # 聊天对话域
│   │   ├── data_enrichment/    # 数据增强域
│   │   ├── feed/               # 内容推荐域
│   │   ├── gem/                # GEM 生成域
│   │   ├── growth/             # 增长归因域
│   │   ├── media/              # 媒体资源域
│   │   ├── points_membership/  # 积分会员域
│   │   ├── product_quality/    # 产品质量域
│   │   ├── search/             # 搜索域
│   │   ├── tryon/              # 试穿生成域
│   │   ├── user_behavior/      # 用户行为域
│   │   ├── user_profile/       # 用户画像域
│   │   └── ...
│   │
│   └── index/                  # 全局索引
│       ├── ALL_TABLES.txt      # 所有表清单
│       ├── ALL_FUNCTIONS.txt   # 所有函数清单
│       ├── DOMAIN_INDEX.md     # 业务域索引
│       ├── LINEAGE_MAP.json    # 血缘关系图
│       └── LINEAGE_SUMMARY.md  # 血缘关系总结
│
└── scripts/                    # 维护工具（用户不需要）
    └── update_metadata.sh      # 元数据更新脚本
```

---

## 🎯 使用场景

### 场景 1: 快速查询

```
用户最近 30 天的试穿次数趋势
```

AI 会自动：
- 识别关键词 "试穿" → 加载 tryon 域
- 选择 RPT 层报表（性能最优）
- 生成符合规则的 SQL
- 附带数据溯源说明

### 场景 2: 复杂分析

```
对比 iOS 和 Android 用户在不同功能上的积分消耗差异
```

AI 会：
- 生成指标口径确认清单
- 选择 DWD 明细表（需要平台维度）
- 检查成本（多维度分析可能扫描更多数据）
- 提供业务解读

### 场景 3: 故障排查

```
为什么昨天的广告 ROI 数据为 0？
```

AI 会：
- 检查数据更新时间
- 验证 user_group 是否正确过滤
- 检查是否有空值
- 给出可能的原因和建议

---

## ⚙️ 配置说明

### PreHook 配置

PreHook 安装后位于 `~/.claude/hooks/bigquery_prehook.sh`

**成本阈值**（可修改）：
```bash
# 在 bigquery_prehook.sh 中修改
COST_THRESHOLD_HOURS=20  # 默认 20 小时
```

**支持的检查**：
- ✅ 破坏性操作检测
- ✅ 成本预估（dry-run）
- ✅ 中文别名检测
- ✅ dt 分区过滤检查
- ✅ user_group 检查（仅 DWS/RPT 层）
- ✅ 数据层级建议

### 数据环境

- **项目**: `srpproduct-dc37e`
- **数据集**: `favie_rpt`, `favie_dws`, `favie_dw`, `favie_dwd`
- **表数量**: 611 张生产表
- **函数数量**: 519 个
- **业务域**: 17 个
- **数据范围**: 2025-01-01 至今

---

---

## 📊 元数据统计

### 业务域分布

| 业务域 | 表数量 | 主要内容 |
|-------|-------|---------|
| product_quality | 126 | 产品质量、SKU 信息 |
| decofy | 66 | Decofy 应用（已归档）|
| user_behavior | 65 | 用户行为、活跃留存 |
| tryon | 58 | 试穿生成 |
| feed | 47 | 内容推荐 |
| gem | 45 | GEM 头像生成 |
| advertising | 38 | 广告投放、ROI |
| growth | 32 | 增长归因 |
| ... | ... | ... |

**总计**: 611 张表，519 个函数，跨 17 个业务域

---

## ⚠️ 注意事项

### 使用限制

1. **必须包含 dt 分区过滤** - 所有查询必须过滤 dt 以控制成本
2. **DWS/RPT 层必须过滤 user_group='all'** - 避免重复计数
3. **禁止使用中文字段别名** - 会导致 dry-run 失败
4. **禁止 SELECT *** - 必须显式列出字段
5. **除法必须使用 NULLIF** - 避免除以 0 错误

### 归档域

**decofy 域**已归档，默认不加载。仅当用户明确提及 "decofy" 时才会访问该域文档。

---

## 🐛 故障排查

### PreHook 未生效

**症状**：查询直接执行，没有成本检查

**解决**：
```bash
# 检查 PreHook 是否安装
ls -la ~/.claude/hooks/bigquery_prehook.sh

# 重新安装
bash setup.sh
```

### 认证失败

**症状**：提示 "BigQuery 认证失败"

**解决**：
```bash
gcloud auth application-default login
gcloud auth login
gcloud config set project srpproduct-dc37e
```

### 元数据未找到

**症状**：AI 说"未找到相关表"

**原因**：表可能是新添加的，元数据未更新

**解决**：联系维护者更新元数据

---

## 📚 相关资源

- **BigQuery 文档**: https://cloud.google.com/bigquery/docs
- **数据血缘查询**: 参考 `metadata/index/LINEAGE_MAP.json`
- **核心规则说明**: 参考 `core/CRITICAL_RULES.md`

---

## 👥 贡献指南

### 反馈问题

发现以下问题请提 Issue：
- 元数据过时或错误
- PreHook 误报
- 规则不合理
- 性能问题

### 更新元数据

如需更新元数据，请联系维护者。元数据更新需要：
1. BigQuery 访问权限
2. 运行专用扫描脚本
3. 验证生成的文档并提交 PR

---

## 🔄 版本更新

### 如何检查是否有新版本？

```bash
# 查看当前安装的版本
claude plugin list | grep srp-allstaff
# 输出: Version: 1.0.8

# 更新 marketplace 并查看最新版本
claude plugin marketplace update srp-claude-code-marketplace
```

**版本发布通知**：关注 Slack #data-platform 频道

---

### 如何更新技能？

当技能有新版本时：

```bash
# 1. 更新 marketplace（拉取最新代码）
claude plugin marketplace update srp-claude-code-marketplace

# 2. 更新插件（应用到本地）
claude plugin update srp-allstaff@srp-claude-code-marketplace

# 3. 重新运行安装脚本（自动检测并更新需要的部分）
cd ~/.claude/skills/bigquery-analyst
bash setup.sh
```

**setup.sh 会自动**：
- ✅ 检测 PreHook 是否有变化，有则更新
- ✅ 检测元数据是否最新，自动使用新版本
- ✅ 跳过已配置的认证

**无需判断更新了什么，统一运行即可。**

---

## 📜 版本历史

### v1.1.0 (2026-02-03)

**更新内容**：
- ✨ 新增 data_enrichment 业务域（3 张表）
- 🐛 修复 PreHook 中文别名检测
- 🐛 修复 DWD 层 user_group 误报
- 📝 补充 5 个查询场景示例
- 📝 添加表选择决策树
- 🎨 优化表文档业务说明

---

### v1.0.0 (2026-01-30)

**初始版本**：
- 📚 包含 608 张表的完整元数据
- 🛡️ PreHook 成本检查机制
- 📖 10 条核心查询规则
- 🗺️ 16 个业务域完整文档

---

## 📞 联系方式

- **维护者**: gutingyi
- **Slack**: #data-platform
- **Email**: gutingyi@srp.one

---

**最后更新**: 2026-02-03
