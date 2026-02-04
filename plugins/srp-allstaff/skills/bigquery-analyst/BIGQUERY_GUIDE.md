# BigQuery 数据分析指南

**版本**: v1.0
**最后更新**: 2026-02-04
**维护**: 数据团队 gutingyi

---

## 📍 数据集位置

所有数据表存储在以下两个 BigQuery 数据集中：

- **项目 ID**: `srpproduct-dc37e`
- **数据集**:
  - `favie_dw` - 数仓层（维度层、明细层、汇总层）
  - `favie_rpt` - 报表层

**完整表引用格式**:
```sql
`srpproduct-dc37e.favie_dw.{table_name}`
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

## 🗂️ 业务域索引

**重要原则**：
- ✅ **优先使用此索引中列出的表** - 这些表经过验证且文档完整
- ✅ **仅当需要的表不在索引中时，才主动查询 BigQuery 数据集**
- ⚠️ 此索引定期更新，但可能不包含最新创建的表

**📌 完整表清单**: 所有 611 张表的完整列表请参考 `TABLES_COMPLETE.md` 文档

以下列出各业务域的**精选核心表**（最常用的表）：

---

### 1. 试穿生成 (tryon) - 23 张表

**关键词**: 试穿、生成、虚拟、头像、精修、换装

**核心指标**:
- 试穿请求次数、生成成功率
- 各试穿类型使用量、生成耗时分布

**核心表清单**:

**维度层 (DIM) - 4 张**:
- `dim_replica_task_view` - 复制任务视图
- `dim_try_on_change_background_task_view` - 换背景任务视图
- `dim_try_on_task_view` - 试穿任务视图
- `dim_try_on_user_task_view` - 用户试穿任务视图

**明细层 (DWD) - 1 张**:
- `dwd_gensmo_user_try_on_urls_and_vibe_detail_view` - 用户试穿 URL 和风格明细

**汇总层 (DWS) - 5 张**:
- `dws_favie_gensmo_tryon_by_event_metric_inc_1d` - 按事件汇总的试穿指标
- `dws_favie_gensmo_tryon_by_item_metric_inc_1d` - 按商品汇总的试穿指标
- `dws_favie_gensmo_tryon_metric_inc_1d` - 试穿综合指标（天级）
- `dws_favie_gensmo_video_tryon_metric_inc_1d` - 视频试穿指标（天级）
- `dws_gensmo_user_tryon_duration_inc_1d` - 用户试穿时长（天级）

**报表层 (RPT) - 13 张**:
- `rpt_favie_gensmo_tryon_metric_inc_1d` - 试穿指标报表（天级）⭐ 常用
- `rpt_favie_gensmo_tryon_bysource_metric_inc_1d` - 按来源的试穿指标
- `rpt_favie_gensmo_video_tryon_metric_inc_1d` - 视频试穿指标报表
- 其他报表表...（共 13 张）

---

### 2. 积分会员 (points_membership) - 10 张表

**关键词**: 积分、会员、获取、消耗、余额、签到、任务

**核心指标**:
- DAU (日活跃用户)
- 积分获取/消耗用户数、积分数
- 人均积分、净积分流

**核心表清单**:

**维度层 (DIM) - 1 张**:
- `dim_gem_membership_view` - Gem 会员维度视图

**明细层 (DWD) - 3 张**:
- `dwd_favie_gensmo_membership_consume_point_inc_1d` - 积分消耗明细（天级）⭐ 常用
- `dwd_favie_gensmo_membership_earn_point_inc_1d` - 积分获取明细（天级）⭐ 常用
- `dwd_favie_gensmo_membership_process_node_inc_1d` - 会员流程节点明细

**汇总层 (DWS) - 3 张**:
- `dws_faive_gensmo_membership_consume_points_metric_inc_1d` - 积分消耗指标汇总
- `dws_faive_gensmo_membership_earn_points_metric_inc_1d` - 积分获取指标汇总
- `dws_faive_gensmo_membership_points_metric_inc_1d` - 积分综合指标汇总

**报表层 (RPT) - 3 张**:
- `rpt_faive_gensmo_membership_consume_points_metric_inc_1d` - 积分消耗报表 ⭐ 常用
- `rpt_faive_gensmo_membership_earn_points_metric_inc_1d` - 积分获取报表 ⭐ 常用
- `rpt_faive_gensmo_membership_points_metric_inc_1d` - 积分综合报表

---

### 3. 用户行为 (user_behavior) - 56 张表

**关键词**: 活跃、留存、流失、会话、访问、停留

**核心指标**:
- DAU / WAU / MAU
- 留存率 (次留、7留、30留)
- 会话时长、访问频次

**主要表**（精选）:
- `dwd_favie_gensmo_events_inc_1d` - 用户事件明细（天级）⭐ 常用
- `dws_favie_gensmo_user_feature_inc_1d` - 用户特征汇总（天级）⭐ 常用
- `dws_favie_gensmo_user_1d7s_inc_1d` - 用户 1/7 日留存指标

---

### 4. 广告营销 (advertising) - 76 张表

**关键词**: 广告、投放、ROI、转化、归因、渠道

**核心指标**:
- 广告消耗、ROI、CPA
- 渠道转化率、归因分析

**主要表**（精选）:
- `dim_ad_all_app_creative_full_1d` - 全应用创意维度表
- `dim_ad_all_source_creative_unique_full_1d_view` - 全渠道创意唯一视图
- 更多表请查询 BigQuery 数据集或参考 metadata/domains/advertising/

---

### 5. 搜索推荐 (search) - 39 张表

**关键词**: 搜索、推荐、点击、曝光、CTR、排序

**核心指标**:
- 搜索次数、搜索用户数
- 点击率 (CTR)、转化率
- 推荐算法效果

**主要表**（精选）:
- `dwd_favie_gem_product_search_inc_1d` - 产品搜索明细
- `dwd_favie_gem_search_query_inc_1d` - 搜索查询明细
- `dws_favie_gem_search_query_metric_inc_1d` - 搜索查询指标汇总

---

### 6. Feed流 (feed) - 52 张表

**关键词**: Feed、推荐流、瀑布流、个性化

**核心指标**:
- Feed曝光量、点击率、停留时长

**主要表**（精选）:
- `dim_favie_gensmo_feed_item_view` - Feed 内容项视图
- `dim_gem_feed_tags_full_1d_view` - Feed 标签全量视图

---

### 7. 产品质量 (product_quality) - 124 张表

**关键词**: 质量、评分、反馈、Bug、崩溃、性能、产品信息

**核心指标**:
- App崩溃率、API成功率
- 页面加载时长、用户反馈分类
- 产品数据质量、品牌信息

**主要表**（精选）:
- `dwd_favie_product_detail_full_1d` - 产品详情全量表 ⭐ 常用
- `dim_favie_official_brand` - 官方品牌维度表
- 更多表请查询 BigQuery 数据集或参考 metadata/domains/product_quality/

---

### 8. Gem产品 (gem) - 66 张表

**关键词**: Gem、账号、任务、AB测试

**主要表**（精选）:
- `dim_gem_account_view` - Gem 账号视图
- `dim_gem_user_ab_config_view` - Gem 用户 AB 配置视图
- `dim_gem_task_response_view` - Gem 任务响应视图

---

### 9. 内容社区 (content) - 2 张表

**关键词**: 内容、发布、点赞、评论、分享

**表清单**:
- `dws_gensmo_tob_content_trace_metric_inc_1d` - ToB 内容跟踪指标
- `rpt_favie_gensmo_content_details_metric_view` - 内容详情指标视图

---

### 10. 爬虫采集 (crawl) - 8 张表

**关键词**: 爬虫、采集、产品信息、图片

**主要表**（精选）:
- `dwd_favie_product_detail_crawl_task_1d` - 产品详情爬取任务（天级）
- `dwd_product_image_crawl_inc_1d` - 产品图片爬取（天级）
- `rpt_favie_crawl_daily_host_metrics_inc_1d` - 爬虫主机指标报表
- `rpt_product_image_crawl_metrics_inc_1d` - 产品图片爬取指标报表

---

### 11. 聊天对话 (chat) - 6 张表

**关键词**: 聊天、会话、消息

**表清单**:
- `dim_chat_sessions_view` - 聊天会话视图
- `dim_chat_session_messages_view` - 聊天消息视图
- `dwd_favie_gensmo_chat_session_messages_inc_1d` - 聊天消息明细
- `dws_favie_gensmo_chat_session_messages_metric_inc_1d` - 聊天消息指标汇总
- `rpt_favie_gensmo_session_behavior_1d` - 会话行为报表

---

### 12. 数据增强 (data_enrichment) - 3 张表

**关键词**: 标签、分类规则、数据质量、数据增强

---

### 13. 增长归因 (growth) - 10 张表

**关键词**: 增长、归因、AppsFlyer、渠道

---

### 14. 媒体资源 (media) - 24 张表

**关键词**: 媒体、图片、视频、image

---

### 15. 用户画像 (user_profile) - 8 张表

**关键词**: 用户画像、账号、profile

---

### 16. 系统配置 (system) - 10 张表

**关键词**: 系统、配置、映射

---

### 17. Decofy (decofy) - 66 张表 ⚠️ 已归档

**说明**: Decofy 应用已归档，相关报表基本不使用，**仅在用户明确提及 "decofy" 时才查询相关表**

---

### 18. 其他域 (other) - 28 张表

**说明**: 包含未归类的系统表、辅助表等

---

## 📌 重要提醒

**如何使用此索引**:
1. ✅ **优先查找此索引** - 查看问题涉及的业务域，使用索引中列出的核心表
2. ✅ **索引中有的表直接使用** - 无需再去 BigQuery 查询
3. ✅ **索引中没有的表才主动查询** - 使用 `INFORMATION_SCHEMA` 搜索新表

**为什么要优先使用索引**:
- 索引中的表经过验证，数据质量有保障
- 减少不必要的 BigQuery 查询，提高效率
- 避免查询到测试表或临时表

---

## 🔍 如何查询未在文档中的表

此文档可能不包含所有最新的表。当需要查询新表时，请按照以下步骤操作：

### 步骤 1: 在数据集中搜索表

根据表命名规范，猜测可能的表名并查询：

```sql
-- 列出所有包含 'tryon' 的表
SELECT table_name
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.TABLES`
WHERE table_name LIKE '%tryon%';

-- 列出所有汇总层的试穿相关表
SELECT table_name
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.TABLES`
WHERE table_name LIKE 'dws_%tryon%';
```

### 步骤 2: 查看表结构

```sql
-- 查看表的字段定义
SELECT column_name, data_type, is_nullable, description
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'dws_favie_gensmo_tryon_metric_inc_1d'
ORDER BY ordinal_position;
```

### 步骤 3: 查找对应的函数

```sql
-- 列出所有函数
SELECT routine_name, routine_type
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
WHERE routine_type = 'TABLE_VALUED_FUNCTION'
  AND routine_name LIKE '%tryon%';
```

### 步骤 4: 查看函数定义（包含血缘关系）

```sql
-- 查看函数的定义和参数
SELECT routine_name, routine_definition, data_type
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
WHERE routine_name = 'dws_favie_gensmo_tryon_metric_inc_1d_function';
```

**提示**: 函数的 SQL 定义 (`routine_definition`) 中通常包含上游表的引用，可以从中推断血缘关系。

### 步骤 5: 查询血缘关系

**推荐方式 1: 查看函数定义（最简单）**

从表值函数的 SQL 定义中可以直接看到上游表的引用：

```sql
-- 查看函数定义（包含上游表引用）
SELECT routine_definition
FROM `srpproduct-dc37e.favie_dw.INFORMATION_SCHEMA.ROUTINES`
WHERE routine_name = '{table_name}_function';
```

函数定义中的 `FROM` 和 `JOIN` 子句会明确列出所有上游表。

**方式 2: 通过 GCP 控制台查看 Dataplex Lineage**

访问 Dataplex Lineage 控制台查看可视化的血缘关系图：

```
https://console.cloud.google.com/dataplex/dp-entries/projects/srpproduct-dc37e/locations/us-east1/entryGroups/@bigquery/entries/bigquery.googleapis.com%2Fprojects%2Fsrpproduct-dc37e%2Fdatasets%2Ffavie_dw%2Ftables%2F{table_name}?project=srpproduct-dc37e#lineage
```

将 `{table_name}` 替换为实际表名（例如：`dws_favie_gensmo_tryon_metric_inc_1d`）。

**方式 3: 通过 BigQuery 元数据查询（部分表支持）**

```sql
-- 查询表的依赖关系（部分表支持）
SELECT *
FROM `srpproduct-dc37e.region-us-east1.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
WHERE destination_table.table_id = '{table_name}'
ORDER BY creation_time DESC
LIMIT 10;
```

**注意**:
- 方式 1（查看函数定义）是最直接和可靠的方式
- Dataplex Lineage 提供可视化界面，但需要在 GCP 控制台中查看
- 血缘关系主要用于了解数据来源和依赖关系

---

## 💡 使用策略

### 何时参考此文档？

1. ✅ **快速定位业务域** - 根据关键词快速找到相关的业务域
2. ✅ **了解表命名规范** - 猜测未知表的可能名称
3. ✅ **了解数据层结构** - 理解 DIM/DWD/DWS/RPT 的区别

### 何时主动查询 BigQuery？

1. ✅ **需要最新的表列表** - 此文档可能已过时
2. ✅ **需要字段的详细定义** - 查看 `INFORMATION_SCHEMA.COLUMNS`
3. ✅ **需要血缘关系** - 查看函数定义或使用 Dataplex
4. ✅ **需要验证表是否存在** - 直接查询数据集

### 查询前的检查清单

在执行查询前，确保：

- [ ] **必须包含 `dt` 分区过滤** - `WHERE dt >= '2026-01-01'`
- [ ] **必须包含 `user_group` 过滤** - `WHERE user_group = 'all'`（如果字段存在）
- [ ] **优先使用函数而非表** - 使用 `{table_name}_function(dt_param)`
- [ ] **限制查询范围** - 使用 `LIMIT` 控制返回行数
- [ ] **避免使用 `SELECT *`** - 明确指定需要的字段

---

## 📊 总览统计

**截至 2026-01-30**:
- **总表数**: 611 张
- **总函数数**: 537 个
- **业务域数**: 19 个

**主要业务域表数量排名**:
1. other - 142 张
2. product_quality - 128 张
3. advertising - 78 张
4. gem - 62 张
5. feed - 52 张
6. search - 40 张
7. user_behavior - 28 张
8. subscription - 27 张
9. decofy - 25 张
10. tryon - 23 张

---

## 🔄 文档更新

**维护说明**:
- 此文档是**指南性文档**，不包含所有表的完整信息
- 当有新表创建或表结构变更时，此文档可能不会立即更新
- 请根据实际需要主动查询 BigQuery 数据集获取最新信息

**更新频率**: 按需更新（通常每月或每季度）

**反馈**: 如有问题或建议，请联系数据团队 gutingyi

---

**最后更新**: 2026-02-04
**版本**: v1.0
**维护者**: 数据团队 gutingyi
