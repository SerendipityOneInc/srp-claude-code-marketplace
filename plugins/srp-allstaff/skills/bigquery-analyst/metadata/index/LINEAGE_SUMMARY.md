# 数据血缘关系概览

**生成时间**: 2026-01-30 13:38:37

---

## 📊 总体统计

- **总表数**: 610 张
- **有上游依赖**: 110 张表（18.0%）
- **有下游依赖**: 174 张表（28.5%）

---

## 🔝 依赖关系 TOP 10

### 上游依赖最多的表（依赖其他表最多）

| 排名 | 表名 | 上游依赖数 |
|------|------|------------|
| 1 | `dwd_growth_ad_google_fivetran_by_ad_id_inc_1d_view` | 36 |
| 2 | `dwd_gem_growth_ad_google_fivetran_by_ad_id_inc_1d_view` | 12 |
| 3 | `dwd_growth_ad_asa_fivetran_by_ad_id_inc_1d_view` | 9 |
| 4 | `rpt_favie_gensmo_creator_details_metric_view` | 8 |
| 5 | `dws_gem_growth_ads_insights_region_full_view` | 7 |
| 6 | `dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view` | 6 |
| 7 | `dwd_growth_ad_google_all_creative_fivetran_inc_1d_view` | 6 |
| 8 | `dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view` | 5 |
| 9 | `dwd_growth_ad_meta_fivetran_tiktok_by_ad_id_inc_1d_view` | 5 |
| 10 | `dwd_growth_ad_tiktok_fivetran_ad_id_inc_1d_view` | 5 |

### 下游依赖最多的表（被其他表依赖最多）

| 排名 | 表名 | 下游依赖数 |
|------|------|------------|
| 1 | `dim_try_on_task_view` | 6 |
| 2 | `dim_moodboard_view` | 5 |
| 3 | `dwd_gem_feed_tags_interface_full_view` | 4 |
| 4 | `dws_favie_gensmo_user_feature_inc_1d` | 3 |
| 5 | `dim_feed_collage_full_view` | 3 |
| 6 | `rpt_gensmo_user_active_metrics_inc_1d` | 3 |
| 7 | `dim_gem_user_replica_view` | 3 |
| 8 | `dim_gensmo_user_account_view` | 2 |
| 9 | `dwd_favie_product_detail_full_1d` | 2 |
| 10 | `dwd_gem_feed_moodboard_tag_inc_1hour_view` | 2 |

---

## 📋 血缘分析

### 源表（无上游依赖的表）

源表是数据链路的起点，通常是从外部系统同步或手动导入的原始数据。

共 500 张源表

### 中间表（既有上游又有下游）

中间表是数据处理链路中的中间环节。

共 12 张中间表

### 终端表（无下游依赖的表）

终端表是数据链路的终点，通常是直接用于分析和报表的表。

共 436 张终端表

---

## 🔍 如何使用血缘信息

### 查看表的上游依赖

查看某张表依赖哪些表：

```
READ metadata/domains/{domain}/tables/{table_name}/lineage.json
```

### 查看表的下游依赖

查看哪些表依赖当前表：

```
READ metadata/domains/{domain}/tables/{table_name}/lineage.json
# 查看 downstream 字段
```

### 查看全局血缘图

查看所有表的依赖关系：

```
READ metadata/index/LINEAGE_MAP.json
```

---

**文档生成**: 2026-01-30 13:38:37
**构建工具**: build_reverse_lineage.py
