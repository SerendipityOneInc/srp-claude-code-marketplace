CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_all_app_growth_management_dashboard_inc_1d_view`
AS SELECT  dt
       ,source
       ,platform
       ,app_name
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name
       ,ad_id
       ,ad_name
       ,country_code
       ,channel
       ,impression
       ,click
       ,conversion
       ,cost
       ,install_cnt
       ,new_user_cnt
FROM `favie_rpt.rpt_gem_growth_management_dashboard_v4_inc_1d`
UNION ALL
SELECT  dt
       ,source
       ,platform
       ,app_name
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name
       ,ad_id
       ,ad_name
       ,country_code
       ,channel
       ,impression
       ,click
       ,conversion
       ,cost
       ,install_cnt
       ,user_cnt AS new_user_cnt
FROM `favie_rpt.rpt_decofy_growth_management_dashboard_v3_inc_1d`;