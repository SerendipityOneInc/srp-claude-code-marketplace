# dws_favie_product_detail_sku_metric_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_product_detail_sku_metric_full_1d`
**层级**: DWS (汇总层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-11-19
**最后更新**: 2024-12-26

---

## 📊 表说明

所属业务库: 商品详情库  
所属数仓层级: DWS层
分区字段: dt（dt字段格式:yyyy-MM-dd）
更新策略: 每日增量更新
模型主键: f_sku_id
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）: 7天
用途: >
  此表是商品详情库(通过数据校验的数据)的每天全量明细数据,在商品每日全量明细表(favie_dw.dwd_favie_product_detail_full_1d)新增了分析字段
保持字段含义一致的表集合:
 - favie_dw.dwd_favie_product_detail_failure_flat_inc_1h
 - favie_dw.dwd_favie_product_detail_full_1d
 - favie_dw.dwd_favie_product_detail_inc_1d
 - favie_dw.dwd_favie_product_detail_flat_inc_1h  
 以上表的字段含义、字段名称、字段数量保持一致,在查询字段含义时,如果所目标表没有的字段说明,可以查询表集合(以favie_dw.dwd_favie_product_detail_full_1d字段含义为参考)的字段含义

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| spu_id | STRING | NULLABLE | - |
| request_sku_id | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| link | STRING | NULLABLE | - |
| sub_title | STRING | NULLABLE | - |
| sub_title_link | STRING | NULLABLE | - |
| shop_id | STRING | NULLABLE | - |
| shop_name | STRING | NULLABLE | - |
| shop_site | STRING | NULLABLE | - |
| link_in_shop | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| description_external_link | STRING | NULLABLE | - |
| rich_product_description | STRING | NULLABLE | - |
| price | STRING | NULLABLE | - |
| f_historical_prices | STRING | NULLABLE | - |
| rrp | STRING | NULLABLE | - |
| images | STRING | NULLABLE | - |
| f_images | STRING | NULLABLE | - |
| categories | STRING | NULLABLE | - |
| f_categories | STRING | NULLABLE | - |
| videos | STRING | NULLABLE | - |
| f_videos | STRING | NULLABLE | - |
| brand | STRING | NULLABLE | - |
| f_brand | STRING | NULLABLE | - |
| keywords | STRING | NULLABLE | - |
| feature_bullets | STRING | NULLABLE | - |
| attributes | STRING | NULLABLE | - |
| specifications | STRING | NULLABLE | - |
| extended_info | STRING | NULLABLE | - |
| best_seller_rank | STRING | NULLABLE | - |
| seller | STRING | NULLABLE | - |
| inventory | STRING | NULLABLE | - |
| deal | STRING | NULLABLE | - |
| returns_policy | STRING | NULLABLE | - |
| review_summary | STRING | NULLABLE | - |
| promotion | STRING | NULLABLE | - |
| variants | STRING | NULLABLE | - |
| f_meta | STRING | NULLABLE | - |
| price_value | INTEGER | NULLABLE | - |
| price_currency | STRING | NULLABLE | - |
| historical_prices_cnt | INTEGER | REQUIRED | - |
| categories_map_success | STRING | REQUIRED | - |
| spider_updates_at | INTEGER | REQUIRED | - |
| categories_map_type | INTEGER | NULLABLE | - |
| image_crawl_success | STRING | REQUIRED | - |
| price_diff | INTEGER | NULLABLE | - |
| reviews_cnt | INTEGER | NULLABLE | - |
| f_updates_at | STRING | NULLABLE | - |
| f_creates_at | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_product_detail_sku_metric_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:29
**扫描工具**: scan_metadata_v2.py
