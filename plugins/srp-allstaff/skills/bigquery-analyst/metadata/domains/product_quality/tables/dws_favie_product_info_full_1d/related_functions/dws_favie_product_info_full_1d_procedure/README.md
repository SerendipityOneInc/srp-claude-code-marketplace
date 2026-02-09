# dws_favie_product_info_full_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_product_info_full_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-30
**最后更新**: 2026-01-30

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
  -- 删除指定日期的数据
  DELETE FROM `favie_dw.dws_favie_product_info_full_1d`
  WHERE dt = dt_param;

  -- 插入商品信息统计结果
  INSERT INTO `favie_dw.dws_favie_product_info_full_1d` (
    dt,
    f_sku_id,
    keywords,
    f_spu_id,
    link,
    brand_name,
    site,
    price,
    launch_date,
    package_weight,
    package_dimensions,
    sellers,
    category_level_1,
    category_level_2,
    category_level_3,
    category_level_4,
    category_level_5,
    category_level_6,
    category_level_7,
    category_level_8,
    category_level_9,
    category_level_10,
    has_main_video,
    product_badges,
    fba_fee,
    monthly_sale_cnt,
    monthly_sale_amt,
    monthly_parent_sale_cnt,
    monthly_parent_sale_amt,
    monthly_sales_growth_rate,
    monthly_parent_sales_growth_rate,
    big_category_bsr,
    small_category_bsr,
    big_bsr_growth,
    big_bsr_growth_rate,
    small_bsr_growth,
    small_bsr_growth_rate,
    variant_cnt,
    seller_cnt,
    rating_amt,
    rating_cnt,
    review_cnt,
    monthly_new_rating_cnt,
    monthly_rating_rate,
    qa_cnt,
    gross_margin_rate,
    listing_quality_score,
    fulfillment_type
  )
  SELECT
    dt,
    f_sku_id,
    keywords,
    f_spu_id,
    link,
    brand_name,
    site,
    price,
    launch_date,
    package_weight,
    package_dimensions,
    sellers,
    category_level_1,
    category_level_2,
    category_level_3,
    category_level_4,
    category_level_5,
    category_level_6,
    category_level_7,
    category_level_8,
    category_level_9,
    category_level_10,
    has_main_video,
    product_badges,
    fba_fee,
    monthly_sale_cnt,
    monthly_sale_amt,
    monthly_parent_sale_cnt,
    monthly_parent_sale_amt,
    monthly_sales_growth_rate,
    monthly_parent_sales_growth_rate,
    big_category_bsr,
    small_category_bsr,
    big_bsr_growth,
    big_bsr_growth_rate,
    small_bsr_growth,
    small_bsr_growth_rate,
    variant_cnt,
    seller_cnt,
    rating_amt,
    rating_cnt,
    review_cnt,
    monthly_new_rating_cnt,
    monthly_rating_rate,
    qa_cnt,
    gross_margin_rate,
    listing_quality_score,
    fulfillment_type
  FROM favie_dw.dws_favie_product_info_full_1d_function(dt_param);

  -- 记录分区信息
  CALL favie_dw.record_partition('favie_dw.dws_favie_product_info_full_1d', dt_param, "");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
