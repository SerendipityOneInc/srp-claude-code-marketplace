# BigQuery 数据基础设施说明

**说明**: 在查询 BigQuery 数据前,必须先了解数据的存储位置、命名规范和组织结构

---

## 📍 数据集位置

所有数据表存储在以下两个 BigQuery 数据集中：

- **项目 ID**: `srpproduct-dc37e`
- **数据集**:
  - `favie_dw` - 数仓层（包含 DIM、DWD、DWS 层的所有表）
  - `favie_rpt` - 报表层（包含 RPT 层的所有表）

### 📊 数据层与数据集的对应关系

| 数据层 | 数据集 | 表名前缀 | 示例 |
|--------|--------|----------|------|
| **DIM** (维度层) | `favie_dw` | `dim_` | `dim_favie_product_info_full_1d` |
| **DWD** (明细层) | `favie_dw` | `dwd_` | `dwd_favie_gensmo_membership_consume_point_inc_1d` |
| **DWS** (汇总层) | `favie_dw` | `dws_` | `dws_faive_gensmo_membership_consume_points_metric_inc_1d` |
| **RPT** (报表层) | `favie_rpt` | `rpt_` | `rpt_faive_gensmo_membership_consume_points_metric_inc_1d` |

**⚠️ 重要**:
- RPT 层的表在 `favie_rpt` 数据集中
- 其他所有层（DIM、DWD、DWS）的表在 `favie_dw` 数据集中

**完整表引用格式**:
```sql
-- DIM/DWD/DWS 层
`srpproduct-dc37e.favie_dw.{table_name}`

-- RPT 层
`srpproduct-dc37e.favie_rpt.{table_name}`
```

---

## 📋 表与函数的关系

### 表值函数 (Table-Valued Function)

大部分表都有对应的**表值函数 (TVF)**。

**命名规则**: `{table_name}_function`

**示例**:
- 表: `dws_favie_gensmo_tryon_metric_inc_1d`
- 函数: `dws_favie_gensmo_tryon_metric_inc_1d_function(dt_param DATE)`

**函数的作用**:
- ✅ 包含**字段的计算逻辑**（如派生字段、指标计算）
- ✅ 引用**上游表**（可从函数定义中了解血缘关系）
- ✅ 封装复杂的业务逻辑

**如何查看函数定义**:
```sql
-- 查看函数的定义（包含字段计算逻辑和上游表引用）
SELECT routine_definition
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
WHERE routine_name = 'dws_favie_gensmo_tryon_metric_inc_1d_function';
```

### 存储过程 (Procedure)

部分表还有对应的**存储过程**，用于数据处理和更新。

**命名规则**: `{table_name}_procedure`

**示例**:
- 表: `dws_favie_gensmo_tryon_metric_inc_1d`
- 存储过程: `dws_favie_gensmo_tryon_metric_inc_1d_procedure`

---

## 🏗️ 表命名规范

### 命名格式

```
{layer}_{product}_{domain}_{description}_{update_pattern}_{time_range}{suffix}
```

### 1. 数据层 (Layer)

| 前缀 | 全称 | 说明 | 示例 |
|------|------|------|------|
| `dim_` | Dimension | 维度层 - 维度数据、配置数据 | `dim_country_region` |
| `dwd_` | Data Warehouse Detail | 明细层 - 明细数据、事实数据 | `dwd_favie_gensmo_membership_consume_point_inc_1d` |
| `dws_` | Data Warehouse Summary | 汇总层 - 汇总指标、聚合数据 | `dws_favie_gensmo_tryon_metric_inc_1d` |
| `rpt_` | Report | 报表层 - 面向业务的报表 | `rpt_favie_gensmo_tryon_metric_inc_1d` |
| `ads_` | Application Data Service | 应用层 - 应用服务数据 | `ads_favie_product_sample_daily` |

### 2. 产品/项目 (Product)

| 前缀 | 产品 | 状态 | 说明 |
|------|------|------|------|
| `favie_` | Favie | 历史 | 历史产品，很多报表仍使用此命名 |
| `gem_` / `gensmo_` | GenSMO | **当前** | **主力产品**，包含 AI 搜索、AI 电商、AI 试穿等功能 |
| `decofy_` | Decofy | 归档 | 已归档产品，相关报表基本不使用（除非用户专门提及） |

### 3. 业务域 (Domain)

常见业务域前缀：

| 前缀 | 业务域 | 说明 |
|------|--------|------|
| `tryon_` | 试穿生成 | 虚拟试穿、头像生成、换装等 |
| `membership_` / `points_` | 积分会员 | 积分获取、消耗、会员等级 |
| `ad_` / `advertising_` | 广告营销 | 广告投放、ROI、转化归因 |
| `crawl_` | 爬虫采集 | 产品信息、图片爬取 |
| `search_` | 搜索推荐 | 搜索行为、推荐曝光点击 |
| `feed_` | Feed流 | 内容推荐、瀑布流 |
| `chat_` | 聊天对话 | 聊天会话、消息 |

### 4. 更新模式 (Update Pattern)

| 后缀 | 说明 | 示例 |
|------|------|------|
| `inc_` | 增量更新 (Incremental) | `dws_favie_gensmo_tryon_metric_inc_1d` |
| `full_` | 全量更新 (Full) | `dim_ad_all_app_creative_full_1d` |

### 5. 时间范围 (Time Range)

| 后缀 | 说明 |
|------|------|
| `1d` | 天级别 (Daily) |
| `1h` | 小时级别 (Hourly) |

### 6. 特殊后缀 (Suffix)

| 后缀 | 说明 |
|------|------|
| `_view` | 视图 (View) |
| `_function` | 表值函数 (Table-Valued Function) |
| `_procedure` | 存储过程 (Stored Procedure) |

### 命名示例解析

| 表名 | 解析 |
|------|------|
| `dws_favie_gensmo_tryon_metric_inc_1d` | 汇总层 + Favie + GenSMO + 试穿 + 指标 + 增量 + 天级 |
| `rpt_favie_gensmo_tryon_metric_inc_1d` | 报表层 + Favie + GenSMO + 试穿 + 指标 + 增量 + 天级 |
| `dim_country_region` | 维度层 + 国家区域 |
| `dwd_favie_gensmo_membership_consume_point_inc_1d` | 明细层 + Favie + GenSMO + 会员 + 消耗积分 + 增量 + 天级 |

---

**为什么需要了解这些**:
- ✅ 快速定位正确的数据集
- ✅ 理解表的数据层级和业务含义
- ✅ 正确构建完整的表引用路径
- ✅ 根据命名规范推测可能的表名

---

**最后更新**: 2026-02-05
