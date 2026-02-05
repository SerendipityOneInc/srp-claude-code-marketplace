with source_data as (
        SELECT
            exp_id,
            impid,
            site,
            country,
            vibe_id,
            product_id,
            event
        FROM `favie_dw.dwd_favie_trace_log_inc_1d`
        WHERE date(dt) = dt_param
            AND impid IS NOT NULL
    ),

    vibe_product as (
        select 
            product_vibe_id,
            json_value(product,"$.product_id") as product_id,
            json_value(product,"$.handle") as product_url,
            json_value(product,"$.image_url") as product_image_url
        from favie_dw.dim_genstyle_product_vibes_view,unnest(json_extract_array(to_json_string(products))) as product
    ),

    with_url_data as (
        select 
            sd.exp_id,
            sd.impid,
            sd.site,
            sd.country,
            sd.vibe_id,
            sd.product_id,
            sd.event,
            dv.vibe_image_url,
            dv.try_on_image_url,
            dv.business_product_id,
            vp.product_url,
            vp.product_image_url
        from source_data sd
        left join favie_dw.dim_genstyle_product_vibes_view dv
            on sd.vibe_id = dv.product_vibe_id
        left join vibe_product vp
            on sd.vibe_id = vp.product_vibe_id and sd.product_id = vp.product_id and sd.product_id is not null
    )
 
    SELECT
        dt_param AS dt,
        exp_id,
        impid,
        site,
        country,
        array_agg(struct(
            vibe_id,
            coalesce(business_product_id, product_id) as business_product_id,
            vibe_image_url,
            try_on_image_url
        )) as vibe_list,
        max(product_id) as product_id,
        max(product_url) as product_url,
        max(product_image_url) as product_image_url,
        COUNT(DISTINCT CASE WHEN event = 'view' THEN impid END) AS show_cnt,
        COUNT(CASE WHEN event = 'click' THEN impid END) AS click_cnt,
        COUNT(DISTINCT CASE WHEN event = 'click' THEN impid END) AS unique_click_cnt,
        COUNT(DISTINCT CASE WHEN event = 'click' THEN product_id END) AS unique_click_product_cnt
    FROM with_url_data
    GROUP BY exp_id, impid, site,country