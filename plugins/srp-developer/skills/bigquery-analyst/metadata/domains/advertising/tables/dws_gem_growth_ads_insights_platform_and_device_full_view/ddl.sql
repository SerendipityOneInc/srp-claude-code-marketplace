CREATE VIEW `srpproduct-dc37e.favie_dw.dws_gem_growth_ads_insights_platform_and_device_full_view`
AS SELECT 
        'FB' AS platform, 
        DATE(date_start) AS cost_date, 
        publisher_platform,
        impression_device,
        SUM(impressions) AS impressions, 
        SUM(clicks) AS clicks, 
        SUM(spend) AS spend,
        SUM((SELECT SUM(action.value.value) 
          FROM UNNEST(actions) as action
          WHERE  action.value.action_type like "%install")
         ) as installs  
    FROM `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_02.ads_insights_platform_and_device`
    GROUP BY DATE(date_start),publisher_platform,impression_device
    ORDER BY cost_date;