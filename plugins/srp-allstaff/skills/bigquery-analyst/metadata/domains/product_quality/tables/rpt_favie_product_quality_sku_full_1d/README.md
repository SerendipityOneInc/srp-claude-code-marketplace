# rpt_favie_product_quality_sku_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_quality_sku_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 6,356,743 行
**大小**: 2.16 GB
**创建时间**: 2024-10-22
**最后更新**: 2025-11-18

---

## 📊 表说明

所属业务库: 商品详情库  
所属数仓层级: RPT层(分析层)
分区字段: dt（字段格式 yyyy-MM-dd）
主题域:数据质量
更新策略: 每日更新
模型主键: site,shop_site
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）: 永久
用途: >
  此表是针对于每日商品详情全量快照表,以站点维度进行对数据质量分析

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | 网站域名 |
| shop_site | STRING | NULLABLE | 店铺域名 |
| total_cnt | INTEGER | NULLABLE | 总商品数 |
| reviews_0_cnt | INTEGER | NULLABLE | 无评论的商品数 |
| reviews_0_to_10_cnt | INTEGER | NULLABLE | 评论数在0-10之间的商品数 |
| reviews_10_to_50_cnt | INTEGER | NULLABLE | 评论数在10-50之间的商品数 |
| reviews_ove_50_cnt | INTEGER | NULLABLE | 评论数大于50的商品数 |
| price_0_cnt | INTEGER | NULLABLE | 价格为0的商品数 |
| price_negative_cnt | INTEGER | NULLABLE | 价格为负数的商品数 |
| price_null_cnt | INTEGER | NULLABLE | 价格为空的商品数 |
| sku_id_not_consistency_cnt | INTEGER | NULLABLE | sku_id不一致的商品数 |
| categories_map_success_cnt | INTEGER | NULLABLE | 类目映射成功的商品数 |
| categories_map_not_success_cnt | INTEGER | NULLABLE | 类目映射失败的商品数 |
| image_crawl_success_cnt | INTEGER | NULLABLE | 图片抓取成功的商品数 |
| image_crawl_not_success_cnt | INTEGER | NULLABLE | 图片抓取失败的商品数 |
| update_1d_cnt | INTEGER | NULLABLE | t-1更新的商品数 |
| update_2d_cnt | INTEGER | NULLABLE | t-2更新的商品数 |
| update_3d_cnt | INTEGER | NULLABLE | t-3更新的商品数 |
| update_4d_cnt | INTEGER | NULLABLE | t-4更新的商品数 |
| update_5d_cnt | INTEGER | NULLABLE | t-5更新的商品数 |
| update_6d_cnt | INTEGER | NULLABLE | t-6更新的商品数 |
| update_7d_cnt | INTEGER | NULLABLE | t-7更新的商品数 |
| update_8d_to_15d_cnt | INTEGER | NULLABLE | t-8到t-15更新的商品数 |
| update_16d_to_30d_cnt | INTEGER | NULLABLE | t-16到t-30更新的商品数 |
| update_31d_to_60d_cnt | INTEGER | NULLABLE | t-31到t-60更新的商品数 |
| update_61d_to_90d_cnt | INTEGER | NULLABLE | t-61到t-90更新的商品数 |
| update_over_91d_cnt | INTEGER | NULLABLE | t-91天后更新的商品数 |
| active_7d_cnt | INTEGER | NULLABLE | t-7天内被更新过的商品数 |
| active_30d_cnt | INTEGER | NULLABLE | t-30天内被更新过的商品数 |
| uactive_30d_cnt | INTEGER | NULLABLE | t-30天内未被更新过的商品数 |
| price_diff_0_cnt | INTEGER | NULLABLE | 价格变动为0的商品数 |
| price_diff_0_to_1_cnt | INTEGER | NULLABLE | 价格变动在0-1之间的商品数 |
| price_diff_1_to_5_cnt | INTEGER | NULLABLE | 价格变动在1-5之间的商品数 |
| price_diff_5_to_10_cnt | INTEGER | NULLABLE | 价格变动在5-10之间的商品数 |
| price_diff_10_to_20_cnt | INTEGER | NULLABLE | 价格变动在10-20之间的商品数 |
| price_diff_20_to_50_cnt | INTEGER | NULLABLE | 价格变动在20-50之间的商品数 |
| price_diff_over_50_cnt | INTEGER | NULLABLE | 价格变动大于50的商品数 |
| price_diff_ratio_0_cnt | INTEGER | NULLABLE | 价格变动比例为0的商品数 |
| price_diff_ratio_0_to_5_cnt | INTEGER | NULLABLE | 价格变动比例在0-5之间的商品数 |
| price_diff_ratio_5_to_10_cnt | INTEGER | NULLABLE | 价格变动比例在5-10之间的商品数 |
| price_diff_ratio_10_to_20_cnt | INTEGER | NULLABLE | 价格变动比例在10-20之间的商品数 |
| price_diff_ratio_over_20_cnt | INTEGER | NULLABLE | 价格变动比例大于20的商品数 |
| historical_prices_cnt | INTEGER | NULLABLE | 历史价格数 |
| dt | DATE | NULLABLE | 日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_quality_sku_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:20
**扫描工具**: scan_metadata_v2.py
