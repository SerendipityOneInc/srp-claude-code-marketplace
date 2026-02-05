CREATE VIEW `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_installs_view`
AS with installs_rank as (
        select 
            appsflyer_id,
            app_id,
            app_name,
            af_ad_id as ad_id,
            af_adset_id as ad_set_id,
            campaign as ad_campaign_id,
            media_source as ad_media_source,
            af_channel as ad_channel,
            platform,
            event_time,
            row_number() over (partition by appsflyer_id order by event_time) as rn
        from gensmo_appsflyer.installs
        union all 
        select 
            appsflyer_id,
            app_id,
            app_name,
            af_ad_id as ad_id,
            af_adset_id as ad_set_id,
            campaign as ad_campaign_id,
            media_source as ad_media_source,
            af_channel as ad_channel,
            platform,
            event_time,
            row_number() over (partition by appsflyer_id order by event_time) as rn
        from  srpproduct-dc37e.gensmo_appsflyer_andriod.in_app_events
        where event_name = 'first open'
    )

    select 
        appsflyer_id,
        app_id,
        app_name,
        ad_id,
        ad_set_id,
        ad_campaign_id,
        ad_media_source,
        ad_channel,
        platform,
        event_time
    from installs_rank
    where rn = 1;