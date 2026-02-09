BEGIN
    DELETE FROM `favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d`
    WHERE dt = dt_param;

    INSERT INTO `favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d`(
        product_site,
        product_shop_site,
        user_type,
        country_name,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        product_sku_id,
        product_cate_tag,
        product_title,
        product_link,
        product_image_link,
        product_price_raw,
        product_gem_return_cnt,
        product_gem_return_user_uniq_cnt,
        product_moodboard_cnt,
        product_moodboard_user_uniq_cnt,
        dt
    )
    select 
        product_site,
        product_shop_site,
        user_type,
        country_name,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        product_sku_id,
        product_cate_tag,
        product_title,
        product_link,
        product_image_link,
        product_price_raw,
        product_gem_return_cnt,
        product_gem_return_user_uniq_cnt,
        product_moodboard_cnt,
        product_moodboard_user_uniq_cnt,
        dt
    from favie_dw.dws_favie_gem_sku_search_cube_inc_1d
    where dt = dt_param
    order by product_gem_return_cnt desc
    limit 500;
END