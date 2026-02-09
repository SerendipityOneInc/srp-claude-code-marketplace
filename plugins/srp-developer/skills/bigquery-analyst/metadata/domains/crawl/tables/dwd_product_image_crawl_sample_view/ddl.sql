CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_product_image_crawl_sample_view`
AS with sku_sample as (
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
        where dt is not null and  dt = (select max(dt) from favie_dw.dwd_product_image_crawl_inc_1d where dt is not null)
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
    from final_sample;