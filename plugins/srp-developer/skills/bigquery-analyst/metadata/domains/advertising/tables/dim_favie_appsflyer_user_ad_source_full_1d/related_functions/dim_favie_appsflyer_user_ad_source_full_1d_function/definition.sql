WITH all_ad_source AS (
    SELECT
      dt_param as dt,
      dt as created_date,
      appsflyer_id,
      case 
        when lower(trim(source)) in ('default','unknown','') then 'Organic'
        when source is null then 'Organic'
        when lower(source) = 'organic' then 'Organic'
        else source
      end as source,
      channel,
      platform,
      campaign_id,
      campaign_name,
      ad_group_id,
      ad_group_name,
      ad_id,
      ad_name,
      country_code,
      event_name,
      app_name
    FROM `favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view`
    WHERE dt <= dt_param
  )

  SELECT
    dt,
    created_date,
    appsflyer_id,
    source,
    channel,
    platform,
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    ad_id,
    ad_name,
    country_code,
    event_name,
    app_name
  FROM all_ad_source