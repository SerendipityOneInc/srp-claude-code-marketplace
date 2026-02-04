# dws_favie_product_info_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_product_info_full_1d`
**层级**: DWS
**业务域**: product_quality

---

## 📊 表说明

Favie商品库数据表 - 存储亚马逊商品的基础信息和统计数据

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | REQUIRED | 日期分区 |
| site | STRING | NULLABLE | 商品站点 |
| f_sku_id | STRING | NULLABLE | 商品sku_id, ASIN |
| f_spu_id | STRING | NULLABLE | 商品SpuID |
| title | STRING | NULLABLE | 商品标题 |
| link | STRING | NULLABLE | 商品链接 |
| main_image_link | STRING | NULLABLE | 商品主图链接 |
| main_image_has_video | BOOLEAN | NULLABLE | 主图视频：是否含主图视频。用于查找产品主图中是否包含视频介绍 |
| brand_name | STRING | NULLABLE | 品牌名称 |
| price | INTEGER | NULLABLE | 价格 |
| launch_date | DATE | NULLABLE | 上架时间  |
| keywords | STRING | NULLABLE | 商品关键词 |
| sellers | STRING | NULLABLE | 所有sellers - name/id/address |
| variant_cnt | INTEGER | NULLABLE | 变体数 - 变体指的是同一款产品的不同型号，比如不同颜色、不同尺寸等 |
| seller_cnt | INTEGER | NULLABLE | 卖家数 - 产品Listing的BuyBox下所有跟卖数量 |
| product_badges | STRING | NULLABLE | 商品标识：best seller/Amazon's Choice/New Release/A+ |
| package_weight | STRING | NULLABLE | 包装重量:g |
| package_dimensions | STRING | NULLABLE | 包装尺寸:1-小号标准，2-中号标准，3-大号标准，4-超大号标准 |
| package_type | INTEGER | NULLABLE | 包装类型 |
| package_fba_fee | FLOAT | NULLABLE | FBA物流费用  |
| fulfillment_type | STRING | NULLABLE | 配送方式：AMZ(亚马逊自营)、FBA(亚马逊物流服务)和FBM(卖家自配送)三种方式 |
| category_level_1 | STRING | NULLABLE | 解析商品类目路径-一级类目 |
| category_level_2 | STRING | NULLABLE | 解析商品类目路径-二级类目 |
| category_level_3 | STRING | NULLABLE | 解析商品类目路径-三级类目 |
| category_level_4 | STRING | NULLABLE | 解析商品类目路径-四级类目 |
| category_level_5 | STRING | NULLABLE | 解析商品类目路径-五级类目 |
| category_level_6 | STRING | NULLABLE | 解析商品类目路径-六级类目 |
| category_level_7 | STRING | NULLABLE | 解析商品类目路径-七级类目 |
| category_level_8 | STRING | NULLABLE | 解析商品类目路径-八级类目 |
| category_level_9 | STRING | NULLABLE | 解析商品类目路径-九级类目 |
| category_level_10 | STRING | NULLABLE | 解析商品类目路径-十级类目 |
| monthly_sale_cnt | INTEGER | NULLABLE | 子体最近30天销量 - 该子体ASIN近一个月的销量，数据来源于亚马逊搜索页 |
| monthly_sale_amt | FLOAT | NULLABLE | 子体最近30天销售额 |
| monthly_parent_sale_cnt | INTEGER | NULLABLE | 父体最近30天销量 |
| monthly_parent_sale_amt | FLOAT | NULLABLE | 父体最近30天销售额 |
| monthly_sales_growth_rate | FLOAT | NULLABLE | 子体月销量增长率 - 默认为子体近30天销量增长率，可以用来寻找潜力爆款 |
| monthly_parent_sales_growth_rate | FLOAT | NULLABLE | 父体月销量增长率 - 默认为父体近30天销量增长率，可以用来寻找潜力爆款 |
| big_category_bsr | INTEGER | NULLABLE | 大类热销排名 - 大类BSR在500-5000是中小卖家一个比较理想的参考值(潜力爆款) |
| small_category_bsr | INTEGER | NULLABLE | 小类热销排名 - 小类BSR，指该子ASIN的Listing页面Best Sellers Rank部分的小类最新排名 |
| weekly_big_bsr_growth | INTEGER | NULLABLE | BSR增长数 - BSR增长数 = 7天前的BSR-当天BSR |
| weekly_big_bsr_growth_rate | FLOAT | NULLABLE | BSR增长率 - BSR增长率 = (7天前的BSR-当天BSR)/7天前的BSR *100% |
| weekly_small_bsr_growth | INTEGER | NULLABLE | 小类BSR增长数 - BSR增长数 = 7天前的BSR-当天BSR |
| weekly_small_bsr_growth_rate | FLOAT | NULLABLE | 小类BSR增长率 - BSR增长率 = (7天前的BSR-当天BSR)/7天前的BSR *100% |
| gross_margin_rate | FLOAT | NULLABLE | 毛利率 - 产品毛利率指的是从商品售价中扣除佣金和FBA费用后，剩余金额占商品售价的比例 |
| listing_quality_score | FLOAT | NULLABLE | LQS  |
| rating_amt | FLOAT | NULLABLE | 评分值 - 产品Listing的最新评分值（评分星级） |
| rating_cnt | INTEGER | NULLABLE | 评分数 - 产品Listing的最新评分数（ratings数量） |
| review_cnt | INTEGER | NULLABLE | 评论数 |
| monthly_new_rating_cnt | INTEGER | NULLABLE | 月评新增 - 产品近30天或一个自然月内的新增评分数 |
| monthly_rating_rate | FLOAT | NULLABLE | 留评率 - 留评率 = 近30天评分数增长值/近30天销量 |
| qa_cnt | INTEGER | NULLABLE | Q&A数量 - 产品Listing的最新Q&A数量 |


---

## 🔗 数据血缘

**上游依赖**:
- `favie_dw.dwd_favie_product_detail_full_1d`

**下游使用**:
- 待补充

---


---

## 💡 数据生成逻辑

该表由 **TABLE_VALUED_FUNCTION** 生成，函数名: `dws_favie_product_info_full_1d_function`

**数据来源**:
- `favie_dw.dwd_favie_product_detail_full_1d`

**查看完整生成逻辑**:
参考 `metadata/domains/product_quality/functions/dws_favie_product_info_full_1d_function/README.md`

## 🔍 查询示例

```sql
-- 示例 1: 查询最近 7 天数据
SELECT *
FROM `srpproduct-dc37e.favie_dw.dws_favie_product_info_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
LIMIT 100;
```

---

## ⚠️ 注意事项

- ✅ 必须包含 dt 分区过滤
- ✅ 数据更新频率: 每日
- ✅ 时区: UTC

---

**最后更新**: 1770084248612
