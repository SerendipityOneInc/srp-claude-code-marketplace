with trace_metric AS (
        SELECT
            vibe_id,
            product_id,
            site,
            country,
            COUNT(DISTINCT CASE WHEN event = 'view' THEN event_uuid END) AS show_cnt,
            COUNT(DISTINCT CASE WHEN event = 'click' THEN event_uuid END) AS click_cnt
        FROM `favie_dw.dwd_favie_trace_log_inc_1d`
        WHERE dt = FORMAT_DATE('%Y-%m-%d', dt_param)
            AND vibe_id IS NOT NULL
        GROUP BY vibe_id, product_id, site,country
    ),
    vibe_product as (
        select 
            product_vibe_id,
            json_value(product,"$.product_id") as product_id,
            json_value(product,"$.handle") as product_url,
            json_value(product,"$.image_url") as product_image_url
        from favie_dw.dim_genstyle_product_vibes_view,unnest(json_extract_array(to_json_string(products))) as product
    )

    select 
        dt_param AS dt,
        tm.site,
        tm.country,
        tm.vibe_id,
        tm.product_id,
        dv.vibe_image_url,
        dv.try_on_image_url,
        vp.product_url,
        vp.product_image_url,
        tm.show_cnt,
        tm.click_cnt
    from trace_metric tm
    left join favie_dw.dim_genstyle_product_vibes_view dv
        on tm.vibe_id = dv.product_vibe_id
    left join vibe_product vp
        on tm.vibe_id = vp.product_vibe_id and tm.product_id = vp.product_id and tm.product_id is not null