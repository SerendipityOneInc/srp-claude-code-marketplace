with ad_data as (

    SELECT  
		dt
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
       ,ad_category
       ,account_put_type
       ,account_open_agency
      
       ,MAX(country_code) AS country_code
       ,SUM(impression)   AS impression
       ,SUM(click)        AS click
       ,SUM(conversion)   AS conversion
       ,SUM(cost)         AS cost
FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
WHERE dt = dt_param
AND app_name = 'Savyo'
GROUP BY  dt
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
       ,ad_category
       ,account_put_type
       ,account_open_agency
)


select
dt
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
,ad_category
,country_code
,'ON_LINE' as channel
,'BOTH' as attribution_method
,account_put_type
,account_open_agency
,impression
,click
,conversion
,cost
,0 as install_cnt
,0 as new_user_cnt
,0 as d0_active_cnt
,0 as d1_retention_cnt
,0 as lt7_cnt
from ad_data