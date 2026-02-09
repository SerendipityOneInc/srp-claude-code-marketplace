CREATE VIEW `srpproduct-dc37e.favie_dw.dim_all_app_ad_full_inc_1d_view`
AS SELECT  source
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
       ,account_put_type
       ,account_open_agency
FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
GROUP BY  source
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
         ,account_put_type
         ,account_open_agency;