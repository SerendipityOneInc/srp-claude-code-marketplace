CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_appsflyer_webhook_inc_1d_view`
AS SELECT

idfv
,device_category
,customer_user_id
,bundle_id
,gp_broadcast_referrer
,event_source
,app_version
,city
,selected_currency
,app_name
,install_time_selected_timezone
,postal_code
,wifi
,install_time
,device_download_time_selected_timezone
,api_version
,is_retargeting
,country_code
,appsflyer_id
,dma
,_sdc_table_version
,event_revenue_currency
,case when media_source='None' then null  else media_source end as  media_source
,region
,event_value
,ip
,event_time
,_sdc_received_at
,_sdc_sequence
,__sdc_primary_key
,state
,device_type
,idfa
,device_download_time
,language
,app_id
,_sdc_batched_at
,event_name
,os_version
,platform
,selected_timezone
,user_agent
,is_primary_attribution
,sdk_version
,event_time_selected_timezone
,af_sub1
,is_lat
,gp_install_begin
,device_model
,gp_referrer
,case when lower(af_c_id) in ('none','null')  then null else af_c_id end as af_c_id
,attributed_touch_time_selected_timezone
,engagement_type
,operator
,attributed_touch_type
,af_attribution_lookback
,campaign_type
,case when lower(af_adset_id) in ('none','null')  then null else af_adset_id end as af_adset_id
,conversion_type
,attributed_touch_time
,gp_click_time
,match_type
,event_type
,http_referrer
,af_sub5
,af_prt
,case when lower(campaign) in ('none','null')  then null else campaign end as campaign
,af_sub4
,af_sub2
,original_url
,att
,case when lower(af_adset) in ('none','null')  then null else af_adset end as af_adset
,case when lower(af_ad) in ('none','null')  then null else af_ad end as af_ad
,network_account_id
,network_account_id__st
,af_channel
,af_reengagement_window
,app_type
,af_siteid
,af_ad_type
,carrier
,af_sub_siteid
,advertising_id
,af_sub3
,case when lower(af_ad_id) in ('none','null')  then null else af_ad_id end as af_ad_id
,store_reinstall
,af_keywords
,keyword_id
,amazon_aid
,'ON_LINE' as channel
FROM `srpproduct-dc37e.appsflyer_ios.data`

union all 

SELECT 
  idfv,
  device_category,
  customer_user_id,
  bundle_id,
  gp_broadcast_referrer,
  event_source,
  app_version,
  city,
  selected_currency,
  app_name,
  install_time_selected_timezone,
  postal_code,
  wifi,
  CAST(install_time AS STRING) AS install_time,
  device_download_time_selected_timezone,
  api_version,
  is_retargeting,
  country_code,
  appsflyer_id,
  dma,
  _sdc_table_version,
  event_revenue_currency,
  case when media_source='None' then null  else media_source end as  media_source,
  region,
  event_value,
  ip,
  CAST(event_time AS STRING) AS event_time,
  _sdc_received_at,
  _sdc_sequence,
  __sdc_primary_key,
  state,
  device_type,
  idfa,
  device_download_time,
  language,
  app_id,
  _sdc_batched_at,
  event_name,
  os_version,
  platform,
  selected_timezone,
  user_agent,
  is_primary_attribution,
  sdk_version,
  event_time_selected_timezone,
  af_sub1,
  is_lat,
  gp_install_begin,
  device_model,
  gp_referrer,
  case when lower(af_c_id) in ('none','null')  then null else af_c_id end as af_c_id,
  attributed_touch_time_selected_timezone,
  engagement_type,
  operator,
  attributed_touch_type,
  af_attribution_lookback,
  campaign_type,
  case when lower(af_adset_id) in ('none','null')  then null else af_adset_id end as af_adset_id,
  conversion_type,
  CAST(attributed_touch_time AS STRING) AS attributed_touch_time,
  gp_click_time,
  match_type,
  event_type,
  http_referrer,
  af_sub5,
  af_prt,
  case when lower(campaign) in ('none','null')  then null else campaign end as campaign,
  af_sub4,
  af_sub2,
  original_url,
  att,
  case when  lower(af_adset) in ('none','null')  then null else af_adset end as af_adset,
  case when lower(af_ad) in ('none','null')  then null else af_ad end as af_ad,
  network_account_id,
  network_account_id__st,
  af_channel,
  af_reengagement_window,
  app_type,
  af_siteid,
  af_ad_type,
  carrier,
  af_sub_siteid,
  advertising_id,
  af_sub3,
  case when lower(af_ad_id) in ('none','null')  then null else af_ad_id end as af_ad_id,
  store_reinstall,
  af_keywords,
  keyword_id,
  amazon_aid,
  'OFF_LINE' as channel
FROM `favie_dw.dim_gem_appsflyer_appsflyer_history_inc_1d_view`;