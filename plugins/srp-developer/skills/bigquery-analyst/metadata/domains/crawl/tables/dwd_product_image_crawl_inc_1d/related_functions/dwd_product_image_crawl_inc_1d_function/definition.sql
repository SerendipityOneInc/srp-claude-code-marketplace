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