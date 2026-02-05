# rpt_favie_gem_search_sku_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.rpt_favie_gem_search_sku_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: TABLE
**行数**: 41,073 行
**大小**: 0.01 GB
**创建时间**: 2025-10-21
**最后更新**: 2025-10-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区字段 |
| product_site | STRING | NULLABLE | 商品所在站点标识，例如 site 名称 |
| product_shop_site | STRING | NULLABLE | 商品所属店铺在站点内的标识（若有） |
| site_domain | STRING | NULLABLE | 站点完整域名或域标识 |
| site_top_domain | STRING | NULLABLE | 站点顶级域/平台（例如：某大型平台的主域） |
| site_tier | STRING | NULLABLE | 站点层级/分层标识（例如：一级/二级/三级站点分类） |
| site_type | STRING | NULLABLE | 站点类型（例如：电商/内容/品牌站等） |
| site_categories | STRING | NULLABLE | 站点所属品类或分类路径，逗号或分隔符分隔 |
| site_parser_type | STRING | NULLABLE | 用于解析该站点的解析器类型或版本 |
| site_country_region | STRING | NULLABLE | 站点所属国家或地区 |
| gem_sku_raw_query_uniq_cnt | INTEGER | NULLABLE | raw query 去重次数 |
| gem_sku_qp_query_uniq_cnt | INTEGER | NULLABLE | qp query 去重次数 |
| gem_moodboard_sku_cnt | INTEGER | NULLABLE | 在 moodboard 中出现的 SKU 总次数（非去重） |
| gem_moodboard_sku_uniq_cnt | INTEGER | NULLABLE | 在 moodboard 中出现的去重 SKU 数量 |
| gem_moodboard_1d_update_sku_cnt | INTEGER | NULLABLE | 过去 1 天内有更新的 SKU 次数（包含重复） |
| gem_moodboard_1d_update_sku_uniq_cnt | INTEGER | NULLABLE | 过去 1 天内有更新的去重 SKU 数量 |
| gem_moodboard_7d_update_sku_cnt | INTEGER | NULLABLE | 过去 7 天内有更新的 SKU 次数（包含重复） |
| gem_moodboard_7d_update_sku_uniq_cnt | INTEGER | NULLABLE | 过去 7 天内有更新的去重 SKU 数量 |
| gem_moodboard_28d_update_sku_cnt | INTEGER | NULLABLE | 过去 28 天内有更新的 SKU 次数（包含重复） |
| gem_moodboard_28d_update_sku_uniq_cnt | INTEGER | NULLABLE | 过去 28 天内有更新的去重 SKU 数量 |
| gem_moodboard_p5_sku_seconds_amt | INTEGER | NULLABLE | SKU 更新时长（moodboard 生成时间剪去 sku 更新时间）第 5 百分位（秒总量/统计量，视上游定义） |
| gem_moodboard_p25_sku_seconds_amt | INTEGER | NULLABLE | SKU 更新时长第 25 百分位（秒总量/统计量） |
| gem_moodboard_p50_sku_seconds_amt | INTEGER | NULLABLE | SKU 更新时长第 50 百分位/中位数（秒总量/统计量） |
| gem_moodboard_p75_sku_seconds_amt | INTEGER | NULLABLE | SKU 更新时长第 75 百分位（秒总量/统计量） |
| gem_moodboard_p95_sku_seconds_amt | INTEGER | NULLABLE | SKU 更新时长第 95 百分位（秒总量/统计量） |
| site_rank | STRING | NULLABLE | 站点排名或权重指标 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.rpt_favie_gem_search_sku_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:10
**扫描工具**: scan_metadata_v2.py
