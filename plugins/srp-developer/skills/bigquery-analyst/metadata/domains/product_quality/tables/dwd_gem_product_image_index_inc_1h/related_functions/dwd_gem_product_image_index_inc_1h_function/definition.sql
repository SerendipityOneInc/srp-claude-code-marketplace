with source_data as (
        SELECT 
            f_sku_id,
            f_spu_id,
            site,
            SAFE.PARSE_JSON(price) as price,
            SAFE.PARSE_JSON(rrp) as rrp,
            f_updates_at,
            f_creates_at,
            f_image_list,
            (select 
                f_image
             from unnest(json_query_array(f_image_list)) as f_image
             where json_value(f_image,"$.f_link") is not null and json_value(f_image, '$.category') = 'main'
             limit 1
            ) as f_main_image,
            SAFE.PARSE_JSON(extended_info) as extended_info,
            inventory,
            safe.parse_json(inventory) as inventory_json,
            f_status,
            row_number() over(partition by f_sku_id order by f_updates_at desc) as rn
        FROM favie_dw.dwd_favie_product_detail_flat_inc_1h
        WHERE date(dt) = dt_param 
            and hour = hour_param
            AND f_status = '0'
    ),

    full_image_data as (
        SELECT
            f_sku_id,
            emb_images
        FROM `favie_dw.dwd_gem_product_image_index_full_xd`
        WHERE dt is not null and dt = (select max(date(dt)) from `favie_dw.dwd_gem_product_image_index_full_xd` where dt is not null)
    ),

    product_with_image as (
        select
            T1.f_sku_id,
            T1.f_spu_id,
            T1.site,
            T1.f_status,
            CAST(JSON_VALUE(T1.price,"$.value") AS INT64) AS local_price, 
            CASE 
                WHEN JSON_VALUE(T1.price,"$.currency") = 'USD' THEN 0 
                ELSE -1 
            END AS local_currency,  

            CAST(JSON_VALUE(T1.rrp,"$.value") AS INT64) AS base_price, 
            CASE 
                WHEN JSON_VALUE(T1.rrp,"$.currency") = 'USD' THEN 0 
                ELSE -1 
            END AS base_currency,

            CASE 
                WHEN CAST(json_value(T1.rrp,"$.value") AS FLOAT64) > 0 
                THEN CAST(json_value(T1.price,"$.value") AS FLOAT64) / CAST(json_value(T1.rrp,"$.value") AS FLOAT64) 
                ELSE 1 
            END AS discount,

            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_used")) = 'true' THEN 1 
                ELSE 0 
            END AS is_used, -- 从 `extended_info` 直接解析

            if(
                T1.inventory_json is not null
                and json_value(T1.inventory_json, '$.status') is not null
                and lower(json_value(T1.inventory_json, '$.status')) = 'out_of_stock', true,false) as out_of_stock,

            if (
                T1.f_main_image is not null
                and least(cast(json_value(T1.f_main_image,"$.width") as int64), cast(json_value(T1.f_main_image,"$.height") as int64)) >= 400
                ,true,false
            ) AS has_invalid_main_image,

            T1.inventory,
            (
                select 
                    ARRAY_AGG(image.image_url)
                from unnest(T3.emb_images) AS image
                where image.CMD = 'add'
            ) AS image_urls,
            T3.emb_images,

            T1.f_creates_at as created_time,
            CURRENT_TIMESTAMP() AS record_time, 

            timestamp_seconds(safe_cast(T1.f_creates_at as int64)) AS product_create_time,
            timestamp_seconds(safe_cast(T1.f_updates_at as int64)) AS product_update_time            
          
        from source_data T1
        -- left outer join T1.rn = 1 and dim_site_data T2 ON T1.site = T2.site
        INNER join full_image_data T3 ON T1.f_sku_id = T3.f_sku_id
    )


    select 
        dt_param as dt,
        CASE 
            WHEN 
                -- 下线的三种情况
                out_of_stock = true
                OR f_status != '0'
                OR has_invalid_main_image = false
                OR local_price <= 0
                OR base_price <= 0
            THEN 'delete' 
            ELSE 'update_field'
        END AS CMD,  
        record_time,
        hour_param as record_hour,

        f_sku_id,
        f_spu_id,
        site,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        is_used,
        inventory,
        f_status,
        image_urls,
        emb_images,
        created_time,

        product_create_time,
        product_update_time
    from product_with_image