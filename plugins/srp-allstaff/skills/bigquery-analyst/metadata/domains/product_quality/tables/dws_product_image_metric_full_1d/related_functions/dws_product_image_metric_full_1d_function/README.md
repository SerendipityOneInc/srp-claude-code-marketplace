# dws_product_image_metric_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_product_image_metric_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
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
WITH product_image as (
        select 
            dt,
            f_sku_id,
            f_spu_id,
            site,
            json_value(f_image.category) as image_category,
            coalesce(json_value(f_image.size_type),"unknown") as image_size_type,
        from `favie_dw.dwd_favie_product_detail_full_1d` ,unnest(json_query_array(PARSE_JSON(f_image_list))) as f_image
        where date(dt) = dt_param
        and f_image.f_link is not null
    ),
    product_image_metric as (
        select 
            dt_param as dt,
            site,
            image_category,
            image_size_type,
            approx_count_distinct(f_sku_id) as image_sku_cnt,
            approx_count_distinct(f_spu_id) as  image_spu_cnt
        from product_image 
        group by dt_param,site,image_category,image_size_type
        union all 
        select 
            dt_param as dt,
            site,
            image_category,
            'all' as image_size_type,
            approx_count_distinct(f_sku_id) as image_sku_cnt,
            approx_count_distinct(f_spu_id) as  image_spu_cnt
        from product_image 
        group by dt_param,site,image_category
    ),

    product_metric as (
        select
            dt, 
            product_site as site,
            site_tier,
            site_type,
            site_rank,
            site_categories,
            site_parser_type,
            site_country_region,
            sum(sku_uniq_cnt) as sku_uniq_cnt,
            sum(spu_uniq_cnt) as spu_uniq_cnt
        from favie_dw.dws_favie_product_data_cube_inc_1d 
        where dt = dt_param
        group by 
            dt,
            product_site,
            site_tier,
            site_type,
            site_rank,
            site_categories,
            site_parser_type,
            site_country_region
    )

    select
        t1.dt,
        t1.site,
        t1.site_tier,
        t1.site_type,
        t1.site_rank,
        t1.site_categories,
        t1.site_parser_type,
        t1.site_country_region,
        t2.image_category,
        t2.image_size_type,
        t1.sku_uniq_cnt,
        t1.spu_uniq_cnt,
        t2.image_sku_cnt,
        t2.image_spu_cnt
    from product_metric t1 
    left outer join product_image_metric t2
    on t1.site = t2.site
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
