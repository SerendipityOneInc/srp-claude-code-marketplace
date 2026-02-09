BEGIN
  DELETE FROM `favie_dw.dim_favie_appsflyer_user_ad_source_full_1d`
  WHERE dt = target_date;

  INSERT INTO `favie_dw.dim_favie_appsflyer_user_ad_source_full_1d`
  (
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
  FROM `favie_dw.dim_favie_appsflyer_user_ad_source_full_1d_function`(target_date);
END