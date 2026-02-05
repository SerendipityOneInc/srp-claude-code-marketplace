CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_favie_gem_product_search_inc_1d_view`
AS with favie_gem_product_search as (
        select 
            trace_id,
            raw_query,
            qr_query,
            qp_query,
            query_modality,
            product_sku_id,
            product_site,
            coalesce(product_shop_site,product_site) as product_shop_site,
            cast(se_recall_timestamp as DATE) as recall_date,
            moodboard_id,
            UNIX_SECONDS(moodboard_timestamp) as moodboard_at,
            cast(TIMESTAMP_SECONDS(safe_cast(product_updates_at as int64)) as DATE) as product_updates_date,
            safe_cast(product_updates_at as int64) as product_updates_at,
            safe_cast(product_creates_at as int64) as product_creates_at,
            UNIX_SECONDS(gem_search_timestamp) as gem_return_at,
            (UNIX_SECONDS(moodboard_timestamp) - safe_cast(product_updates_at as int64)) as moodboard_time_gap_seconds,
            dt
        from favie_dw.dwd_favie_gem_product_search_inc_1d 
        where  search_engine = "ha3" 
            and raw_query is not null    
            and product_site is not null
            and moodboard_id is not null 
            and product_updates_at is not null 
            and moodboard_timestamp is not null
    )
    select 
        t1.trace_id,
        t1.raw_query,
        t1.qr_query,
        t1.qp_query,
        t1.query_modality,
        t1.product_sku_id,
        t1.product_site,
        t1.product_shop_site,
        t1.recall_date,
        t1.moodboard_id,
        t1.moodboard_at,
        t1.product_updates_date,
        t1.product_updates_at,
        t1.product_creates_at,
        t1.gem_return_at,
        t1.moodboard_time_gap_seconds,
        t1.dt,
        IF(t2.site_domain IS NULL,t1.product_site,t2.site_domain) as site_domain,
        IF(t2.site_top_domain IS NULL, REGEXP_EXTRACT(t1.product_site, r'([^.]+\.[^.]+)$'), t2.site_top_domain) AS site_top_domain,
        IF(t2.site_tier IS NULL, "Other", t2.site_tier) AS site_tier,
        IF(t2.site_type IS NULL, "Other", t2.site_type) AS site_type,
        IF(t2.site_rank IS NULL, "Other", t2.site_rank) AS site_rank,
        IF(t2.site_categories IS NULL, "Other", t2.site_categories) AS site_categories,
        IF(t2.site_parser_type IS NULL, "Other", t2.site_parser_type) AS site_parser_type,
        IF(t2.site_country_region IS NULL, "Other", t2.site_country_region) AS site_country_region
    from favie_gem_product_search t1 
        LEFT OUTER JOIN `favie_dw.dim_site_mut` t2
        ON t1.product_site = t2.site_domain_without_www;