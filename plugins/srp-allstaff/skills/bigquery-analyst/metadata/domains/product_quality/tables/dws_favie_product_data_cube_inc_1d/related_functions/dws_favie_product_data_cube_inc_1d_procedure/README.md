# dws_favie_product_data_cube_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_product_data_cube_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-04
**最后更新**: 2026-01-04

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
       
      DELETE FROM `favie_dw.dws_favie_product_data_cube_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dws_favie_product_data_cube_inc_1d` (
        product_site,
        product_shop_site,
        site_domain,
        site_top_domain,
        site_tier,
        site_type,
        site_rank,
        site_categories,
        site_parser_type,
        site_country_region,
        sku_uniq_cnt,
        spu_uniq_cnt,
        inc_sku_uniq_cnt,
        inc_spu_uniq_cnt,
        update_sku_uniq_cnt,
        update_spu_uniq_cnt,
        d3_update_and_inc_sku_uniq_cnt,
        d3_update_and_inc_spu_uniq_cnt,
        d7_update_and_inc_sku_uniq_cnt,
        d7_update_and_inc_spu_uniq_cnt,
        d28_update_and_inc_sku_uniq_cnt,
        d28_update_and_inc_spu_uniq_cnt,
        invalid_price_sku_uniq_cnt,
        unexpected_price_sku_uniq_cnt,
        out_of_stock_sku_uniq_cnt,
        dt
      )
      SELECT
        product_site,
        product_shop_site,
        site_domain,
        site_top_domain,
        site_tier,
        site_type,
        site_rank,
        site_categories,
        site_parser_type,
        site_country_region,
        sku_uniq_cnt,
        spu_uniq_cnt,
        inc_sku_uniq_cnt,
        inc_spu_uniq_cnt,
        update_sku_uniq_cnt,
        update_spu_uniq_cnt,
        d3_update_and_inc_sku_uniq_cnt,
        d3_update_and_inc_spu_uniq_cnt, 
        d7_update_and_inc_sku_uniq_cnt,
        d7_update_and_inc_spu_uniq_cnt,
        d28_update_and_inc_sku_uniq_cnt,
        d28_update_and_inc_spu_uniq_cnt,
        invalid_price_sku_uniq_cnt,
        unexpected_price_sku_uniq_cnt,
        out_of_stock_sku_uniq_cnt,
        dt
      FROM `favie_dw.dws_favie_product_data_cube_inc_1d_function`(dt_param,date_sub(dt_param,interval 2 day),date_sub(dt_param,interval 6 day),date_sub(dt_param,interval 27 day));

      call favie_dw.record_partition('favie_dw.dws_favie_product_data_cube_inc_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
