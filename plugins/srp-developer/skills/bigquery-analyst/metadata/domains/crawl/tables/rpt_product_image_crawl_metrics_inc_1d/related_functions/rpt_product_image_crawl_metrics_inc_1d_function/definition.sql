select 
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        image_category,
        count(distinct image_link) as download_image_cnt,
        count(distinct f_sku_id) as download_image_sku_cnt
    from favie_dw.dwd_product_image_crawl_inc_1d
    where dt = dt_param
    group by 
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        image_category