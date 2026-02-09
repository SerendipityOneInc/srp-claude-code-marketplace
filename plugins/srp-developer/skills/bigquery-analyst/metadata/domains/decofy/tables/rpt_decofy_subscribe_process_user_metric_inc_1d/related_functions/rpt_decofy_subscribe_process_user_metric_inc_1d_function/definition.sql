WITH process_user_metric AS (
        SELECT
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,

            count(distinct subscribe_trigger_user_id) as subscribe_trigger_user_cnt,
            count(distinct subscribe_first_order_user_id) as subscribe_first_order_user_cnt
        FROM favie_dw.dws_decofy_subscribe_process_metric_inc_1d
        WHERE dt = dt_param
        GROUP BY
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
    ),
    active_user_data as (
        select 
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            sum(active_user_d1_cnt) as active_user_cnt
        from favie_rpt.rpt_decofy_user_active_metrics_inc_1d where dt = dt_param
        group by  dt,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
    )

    select 
        coalesce(t1.dt,t2.dt) as dt,
        coalesce(t1.country_name,t2.country_name) as country_name,
        coalesce(t1.platform,t2.platform) as platform,
        coalesce(t1.app_version,t2.app_version) as app_version,
        coalesce(t1.user_group,t2.user_group) as user_group,
        coalesce(t1.ad_source,t2.ad_source) as ad_source,
        coalesce(t1.ad_id,t2.ad_id) as ad_id,
        coalesce(t1.ad_group_id,t2.ad_group_id) as ad_group_id,
        coalesce(t1.ad_campaign_id,t2.ad_campaign_id) as ad_campaign_id,
        t2.active_user_cnt,
        t1.subscribe_trigger_user_cnt,
        t1.subscribe_first_order_user_cnt
    from process_user_metric t1 
    full outer join active_user_data t2
    on t1.dt = t2.dt
    and t1.country_name = t2.country_name
    and t1.platform = t2.platform
    and t1.app_version = t2.app_version
    and t1.user_group = t2.user_group
    and t1.ad_source = t2.ad_source
    and t1.ad_id = t2.ad_id
    and t1.ad_group_id = t2.ad_group_id
    and t1.ad_campaign_id = t2.ad_campaign_id