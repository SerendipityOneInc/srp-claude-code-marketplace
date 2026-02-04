# Changelog

All notable changes to the BigQuery Analyst Skill will be documented in this file.

## [1.1.0] - 2026-02-04

### 🎯 Major Refactor: 从"完整知识库"到"指南引导 + 主动探查"

### Added
- ✨ **BIGQUERY_GUIDE.md** - 新增轻量级指南文档（11KB）
  - 数据集位置和表/Function 关系说明
  - 完整的表命名规范文档
  - 业务域索引（19 个业务域）
  - 如何使用 BigQuery INFORMATION_SCHEMA 主动探查
  - 使用策略（何时查文档 vs 何时查 BigQuery）

- 📋 **REFACTOR_SUMMARY.md** - 重构总结文档
  - 详细说明重构原因和目标
  - 工作模式对比（之前 vs 现在）
  - 效果对比（Token 减少 90%）

### Changed
- 🔄 **SKILL.md** - 更新工作流程
  - 知识库加载策略调整为"指南引导 + 主动探查"
  - Step 2（表选择与字段确认）现在使用 BigQuery 实时查询
  - 文件索引简化，标注 metadata/ 为历史文档
  - 更新 description 为"指南引导 + 主动探查"

### Deprecated
- ⚠️ **metadata/** - 标注为历史文档，不再作为主要数据源
  - 保留作为参考（可能已过时）
  - 不在启动时加载
  - 不定期更新维护

### Benefits
- 📉 **核心文档大小减少 99%**（3MB → 20KB）
- 📉 **启动加载 Token 减少 90%**（100K → 10K）
- ✅ **数据时效性**：从静态文档到实时查询
- ✅ **维护复杂度大幅降低**：从 611 张表到仅维护指南

### AI 新能力
- 🤖 根据表命名规范自主猜测表名
- 🔍 主动查询 BigQuery 验证表和字段
- 🔗 从函数定义中推断血缘关系
- 🎯 灵活决策何时查文档 vs 何时查 BigQuery

---

## [1.0.0] - 2026-01-30

### Added
- ✨ 初始版本发布
- 📊 完整的元数据知识库（611 张表 + 537 个函数）
- 🛡️ PreHook 成本检查和安全防护
- 📚 19 个业务域的完整文档
- ✅ 10 条核心查询规则

### Features
- 成本保护 - PreHook 自动检查查询成本
- 规则引导 - 10 条核心规则避免常见错误
- 元数据完整 - 611 张表的完整文档
- 需求澄清 - AI 主动确认指标口径
- 结果可信 - AI 自检 + 数据溯源说明

---

## Version Comparison

| 版本 | 发布日期 | 核心特性 | 文档大小 | Token 消耗 |
|------|---------|---------|---------|-----------|
| v1.0.0 | 2026-01-30 | 完整元数据知识库 | ~3MB | ~100K |
| v1.1.0 | 2026-02-04 | 指南引导 + 主动探查 | ~20KB | ~10K |

---

## Migration Guide

### 从 v1.0.0 升级到 v1.1.0

**无需操作**：
- PreHook 配置保持不变
- core/ 目录下的核心规则保持不变
- README.md 和 setup.sh 保持不变

**新增文件**：
- `BIGQUERY_GUIDE.md` - 请阅读以了解新的工作模式

**工作方式变化**：
- AI 不再依赖 metadata/ 目录
- AI 会主动查询 BigQuery INFORMATION_SCHEMA
- 查询结果始终基于最新的表结构

**建议**：
- 阅读 `REFACTOR_SUMMARY.md` 了解详细变更
- 测试几个实际查询场景
- 如有问题，可参考 metadata/ 下的历史文档

---

**下一版本计划**: v1.2.0（待定）
- 完善血缘关系查询（Dataplex API 集成）
- 自动化指南更新脚本
- 更多业务域的核心表补充
