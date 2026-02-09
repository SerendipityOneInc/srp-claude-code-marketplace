CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_skan_appsflyer_webhook_inc_1d_view`
AS select 
skad_version
,skad_ad_network_id
,fidelity_type
,timestamp
,ad_network_adset_id
,ad_network_campaign_id
,event_type
,_sdc_table_version
,ad_network_adset_name
,skad_transaction_id
,ip
,ad_network_campaign_name
,_sdc_received_at
,_sdc_sequence
,skad_attribution_signature
,__sdc_primary_key
,skad_redownload
,app_id
,ad_network_timestamp
,_sdc_batched_at
,skad_app_id
,skad_conversion_value
,did_win
,skad_campaign_id
,skad_source_app_id
,source_app_id
,event_uuid
,install_type
,date(install_date) as dt
,skad_fidelity_type
,skad_mode
,skad_postback_sequence_index
,media_source
,measurement_window
,af_attribution_flag
,skad_coarse_conversion_value
,skad_ambiguous_event
,event_name
,skad_source_identifier
,min_time_post_install
,max_time_post_install
,max_event_counter
,min_event_counter
from `srpproduct-dc37e.skan_appsflyer_gensmo.data`

union distinct  

select 
skad_version
,skad_ad_network_id
,fidelity_type
,timestamp
,ad_network_adset_id
,ad_network_campaign_id
,event_type
,_sdc_table_version
,ad_network_adset_name
,skad_transaction_id
,ip
,ad_network_campaign_name
,_sdc_received_at
,_sdc_sequence
,skad_attribution_signature
,__sdc_primary_key
,skad_redownload
,app_id
,ad_network_timestamp
,_sdc_batched_at
,skad_app_id
,skad_conversion_value
,did_win
,skad_campaign_id
,skad_source_app_id
,source_app_id
,event_uuid
,install_type
,date(install_date) as dt 
,skad_fidelity_type
,skad_mode
,skad_postback_sequence_index
,media_source
,measurement_window
,af_attribution_flag
,skad_coarse_conversion_value
,skad_ambiguous_event
,event_name
,skad_source_identifier
,min_time_post_install
,max_time_post_install
,max_event_counter
,min_event_counter
from `srpproduct-dc37e.skan_appsflyer_gensmo2.data`;