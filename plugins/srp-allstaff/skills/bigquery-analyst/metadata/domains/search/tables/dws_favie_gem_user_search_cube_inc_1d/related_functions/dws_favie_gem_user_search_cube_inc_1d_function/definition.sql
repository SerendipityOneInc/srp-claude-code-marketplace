with dwd_favie_gem_user_search as (
      select 
        product_site,
        product_shop_site,

        -- device_id,
        user_type,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,

        -- appsflyer_id,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
    
        -- sum(product_recall_cnt) as product_recall_cnt,
        -- sum(product_recall_user_uniq_cnt) as product_recall_user_uniq_cnt,
        -- sum(product_valid_recall_cnt) as product_valid_recall_cnt,
        -- sum(product_valid_recall_user_uniq_cnt) as product_valid_recall_user_uniq_cnt,
        sum(product_gem_return_cnt) as product_gem_return_cnt,
        sum(product_gem_return_user_uniq_cnt) as product_gem_return_user_uniq_cnt,
        sum(product_moodboard_cnt) as product_moodboard_cnt,
        sum(product_moodboard_user_uniq_cnt) as product_moodboard_user_uniq_cnt,
        -- sum(product_first_moodboard_cnt) as product_first_moodboard_cnt,
        -- sum(product_first_moodboard_user_uniq_cnt) as product_first_moodboard_user_uniq_cnt,
        dt
      from favie_dw.dws_favie_gem_sku_search_cube_inc_1d
      where dt = dt_param
      group by dt,
        product_site,
        product_shop_site,
        user_type,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id

  )

  select 
    t1.product_site,
    t1.product_shop_site,

    IF(t2.site_domain IS NULL,t1.product_site,t2.site_domain) as site_domain,
    IF(t2.site_top_domain IS NULL, REGEXP_EXTRACT(t1.product_site, r'([^.]+\.[^.]+)$'), t2.site_top_domain) AS site_top_domain,
    IF(t2.site_tier IS NULL, "Other", t2.site_tier) AS site_tier,
    IF(t2.site_type IS NULL, "Other", t2.site_type) AS site_type,
    IF(t2.site_categories IS NULL, "Other", t2.site_categories) AS site_categories,
    IF(t2.site_parser_type IS NULL, "Other", t2.site_parser_type) AS site_parser_type,
    IF(t2.site_country_region IS NULL, "Other", t2.site_country_region) AS site_country_region,  

    t1.user_type,
    t1.country_name,
    t1.user_login_type,
    t1.user_tenure_type,
    t1.platform,
    t1.app_version,

    t1.ad_source,
    t1.ad_campaign_id,
    t1.ad_group_id,
    t1.ad_id,

    -- t1.product_recall_cnt,
    -- t1.product_recall_user_uniq_cnt,
    -- t1.product_valid_recall_cnt,
    -- t1.product_valid_recall_user_uniq_cnt,
    t1.product_gem_return_cnt,
    t1.product_gem_return_user_uniq_cnt,
    t1.product_moodboard_cnt,
    t1.product_moodboard_user_uniq_cnt,
    -- t1.product_first_moodboard_cnt,
    -- t1.product_first_moodboard_user_uniq_cnt,  

    t1.dt
  from dwd_favie_gem_user_search t1 
  LEFT OUTER JOIN `favie_dw.dim_site_mut_view` t2
  ON t1.product_site = t2.site_domain_without_www