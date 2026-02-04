WITH product_image as (
        select 
            dt,
            f_sku_id,
            f_spu_id,
            site,
            json_value(f_image, '$.f_link') as image_url,
            safe_cast(json_value(f_image, '$.width') as int64) as width,
            safe_cast(json_value(f_image, '$.height') as int64) as height,
            json_value(f_image, '$.category') as image_category,
            f_image,
            DATE(FORMAT_DATE('%Y-%m-%d', TIMESTAMP_SECONDS(CAST(f_creates_at AS INT64)))) as product_f_creates_at
        from `favie_dw.dwd_favie_product_detail_full_1d` ,unnest(json_extract_array(f_image_list)) as f_image
        where date(dt) = dt_param
    ),
    product_image_with_type as (
        select
            dt, 
            f_sku_id,
            f_spu_id,
            site,
            image_category,
            image_url,
            case 
            when width * height <= 320 * 240 then "is_tiny_image"
            when width * height > 320 * 240 and width * height <= 640 * 480 then "is_small_image"
            when width * height > 640 * 480 and width * height <= 1024 * 768 then "is_medium_image"
            when width * height > 1024 * 768 and width * height <= 1920 * 1080 then "is_large_image"
            when width * height > 1920 * 1080 and width * height <= 3840 * 2160 then "is_image_pixel_size_2k"
            when width * height > 3840 * 2160 and width * height <= 7680 * 4320 then "is_image_pixel_size_4k"
            when width * height > 7680 * 4320 then "is_image_pixel_size_8k"
            end as image_type,
            product_f_creates_at
        from product_image
    )
    select 
        product_f_creates_at
        ,site
        ,count(distinct f_sku_id) as total_sku_cnt
        ,count(distinct f_spu_id) as  total_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_tiny_image" and image_category = 'other',f_sku_id,null)) as tiny_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_small_image" and image_category = 'other',f_sku_id,null)) as small_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_medium_image" and image_category = 'other',f_sku_id,null)) as medium_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_large_image" and image_category = 'other',f_sku_id,null)) as large_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_2k" and image_category = 'other',f_sku_id,null)) as size_2k_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_4k" and image_category = 'other',f_sku_id,null)) as size_4k_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_8k" and image_category = 'other',f_sku_id,null)) as size_8k_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_tiny_image" and image_category = 'main',f_sku_id,null)) as tiny_main_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_small_image" and image_category = 'main',f_sku_id,null)) as small_main_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_medium_image" and image_category = 'main',f_sku_id,null)) as medium_main_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_large_image" and image_category = 'main',f_sku_id,null)) as large_main_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_2k" and image_category = 'main',f_sku_id,null)) as size_2k_main_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_4k" and image_category = 'main',f_sku_id,null)) as size_4k_main_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_8k" and image_category = 'main',f_sku_id,null)) as size_8k_main_image_sku_cnt
        ,count(distinct if(image_url is not null and image_type = "is_tiny_image" and image_category = 'other',f_spu_id,null)) as tiny_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_small_image" and image_category = 'other',f_spu_id,null)) as small_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_medium_image" and image_category = 'other',f_spu_id,null)) as medium_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_large_image" and image_category = 'other',f_spu_id,null)) as large_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_2k" and image_category = 'other',f_spu_id,null)) as size_2k_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_4k" and image_category = 'other',f_spu_id,null)) as size_4k_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_8k" and image_category = 'other',f_spu_id,null)) as size_8k_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_tiny_image" and image_category = 'main',f_spu_id,null)) as tiny_main_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_small_image" and image_category = 'main',f_spu_id,null)) as small_main_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_medium_image" and image_category = 'main',f_spu_id,null)) as medium_main_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_large_image" and image_category = 'main',f_spu_id,null)) as large_main_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_2k" and image_category = 'main',f_spu_id,null)) as size_2k_main_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_4k" and image_category = 'main',f_spu_id,null)) as size_4k_main_image_spu_cnt
        ,count(distinct if(image_url is not null and image_type = "is_image_pixel_size_8k" and image_category = 'main',f_spu_id,null)) as size_8k_main_image_spu_cnt
    from product_image_with_type 
    group by product_f_creates_at,site