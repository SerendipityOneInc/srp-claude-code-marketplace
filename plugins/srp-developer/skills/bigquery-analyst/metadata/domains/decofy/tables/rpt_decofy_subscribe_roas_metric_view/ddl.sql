CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_roas_metric_view`
AS with ad_cost as (
        SELECT
            dt,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id,
            sum(ad_cost) as ad_cost
        FROM favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d
        WHERE dt is not null 
            and n_day = 7
        group by 
            dt,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id
    ),

    cumulative_LTV as(
        select
            dt,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id,
            sum(LTV_7d) as LTV_7d
        from favie_rpt.rpt_decofy_subscribe_ltv_metric_view
        where user_group = 'all'
        and product_id is not null
        group by dt,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id
    ),

    roas_data as (
        select
            coalesce(c.dt,l.dt) as dt,
            coalesce(c.ad_source,l.ad_source) as ad_source,
            coalesce(c.ad_group_id,l.ad_group_id) as ad_group_id,
            coalesce(c.ad_campaign_id,l.ad_campaign_id) as ad_campaign_id,
            coalesce(c.ad_id,l.ad_id) as ad_id,
            c.ad_cost as ad_cost,
            coalesce(l.LTV_7d,0) as LTV_7d
        from ad_cost c
        full outer join cumulative_ltv l
        on c.dt = l.dt
            and c.ad_source = l.ad_source
            and c.ad_group_id = l.ad_group_id
            and c.ad_campaign_id = l.ad_campaign_id
            and c.ad_id = l.ad_id
    )

    select 
        dt,
        ad_source,
        ad_group_id,
        ad_campaign_id,
        ad_id,
        ad_cost,
        LTV_7d
    from roas_data;