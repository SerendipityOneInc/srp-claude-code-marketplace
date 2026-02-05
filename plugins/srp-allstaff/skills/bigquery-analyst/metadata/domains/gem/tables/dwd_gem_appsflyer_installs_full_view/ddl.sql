CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_appsflyer_installs_full_view`
AS SELECT
    appsflyer_id,
    bundle_id,
    app_name,
    app_version,
    case 
        when af_channel like '%Instagram%' then 'FB' 
        when af_channel like '%Facebook%' then 'FB'
        when af_channel like '%TikTok%' then 'TT'
        else 'Others' 
    end as platform,
    case 
        when af_channel like '%Instagram%' then 'instagram'
        when af_channel like '%Facebook%' then 'facebook'
        when af_channel like '%TikTok%' then 'tiktok'
        else 'others'
    end as publisher_platform,

    platform as device,
    os_version as device_version,

    af_channel,
    af_siteid,
    af_sub_siteid,
    af_ad_id as ad_id,
    af_ad as ad_name,
    af_c_id as campaign_id,
    campaign as campaign_name,
    af_adset_id as adset_id,
    af_adset as adset_name,
    is_primary_attribution,

    country_code,
    region as sub_continent_code,
    state as region_code,
    city as city_name,

    ip,
    install_time,
    af_attribution_lookback,
    is_retargeting,
    media_source,
    Date(event_time) AS dt

  FROM `srpproduct-dc37e.gensmo_appsflyer.installs`;