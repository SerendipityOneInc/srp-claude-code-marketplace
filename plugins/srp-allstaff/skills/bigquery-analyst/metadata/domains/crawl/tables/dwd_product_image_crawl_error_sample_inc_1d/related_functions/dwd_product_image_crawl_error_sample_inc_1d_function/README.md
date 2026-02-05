# dwd_product_image_crawl_error_sample_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_product_image_crawl_error_sample_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-11
**最后更新**: 2025-10-11

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
with sku_sample as (
        select 
            dt,
            site,
            shop_site,
            uploader_type,
            status,
            f_sku_id,
            link,
            image_link,
            image_category,
            row_number() over(
                partition by shop_site, f_sku_id 
                order by case when image_category = 'main' then 0 else 1 end, rand()
            ) as sku_rn
        from favie_dw.dwd_product_image_crawl_inc_1d
        where dt = dt_param
        and status != '200'
    ),
    site_sku_sample as (
        select *,
            row_number() over(partition by shop_site order by rand()) as site_sku_rn
        from (
            select distinct shop_site, f_sku_id
            from sku_sample
        ) t
    ),
    final_sample as (
        select s.*
        from sku_sample s
        inner join site_sku_sample sss 
            on s.shop_site = sss.shop_site and s.f_sku_id = sss.f_sku_id
        where sss.site_sku_rn <= 3  -- 每个网站取3个SKU
          and s.sku_rn <= 3        -- 每个SKU取1条数据
    )
    select 
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        f_sku_id,
        link,
        image_link,
        image_category
    from final_sample
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
