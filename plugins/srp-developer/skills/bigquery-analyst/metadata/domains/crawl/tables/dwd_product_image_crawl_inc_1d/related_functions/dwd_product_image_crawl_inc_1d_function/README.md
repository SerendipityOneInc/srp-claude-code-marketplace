# dwd_product_image_crawl_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_product_image_crawl_inc_1d_function`
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
with base_data as (
        select 
            dt_param as dt,
            site,
            coalesce(shop_site,site) as shop_site,
            coalesce(json_value(f_image,'$.uploader_type'), 'cloudflare') as uploader_type,
            json_value(f_image,'$.status') as status,
            f_sku_id,
            link,
            json_value(f_image,'$.link') as image_link,
            json_value(f_image,'$.category') as image_category
        from `favie_dw.dwd_favie_product_detail_flat_inc_1h`,unnest(json_extract_array(f_image_list)) as f_image
        where date(dt) = dt_param
            and json_value(f_meta, '$.source_type') = '5'
            and json_value(f_meta, '$.data_type') = '5'
            -- and json_value(f_image,'$.f_link') is null
    ),
    rank_data as (
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
            row_number() over(partition by f_sku_id,image_link order by if(image_category = 'main',1,0) desc ) as rn
        from base_data
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
    from rank_data
    where rn = 1
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
