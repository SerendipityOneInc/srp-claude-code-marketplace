CREATE VIEW `srpproduct-dc37e.favie_dw.dws_gem_growth_ads_insights_region_full_view`
AS with region_data as (
-- (
--     SELECT 
--         'FB' AS platform, 
--         DATE(date_start) AS cost_date, 
--         region,
--         SUM(impressions) AS impressions, 
--         SUM(clicks) AS clicks, 
--         SUM(spend) AS spend,
--         SUM((SELECT SUM(action.value.value) 
--           FROM UNNEST(actions) as action
--           WHERE  action.value.action_type like "%install")
--          ) as installs 
--     FROM `srpproduct-dc37e.facebook_ads_gensmow2agensmo_yla_dt_01.ads_insights_region`
--     GROUP BY DATE(date_start),region
--     ORDER BY cost_date
-- )
-- UNION ALL
(
    SELECT 
        'FB' AS platform, 
        DATE(date_start) AS cost_date, 
        region,
        SUM(impressions) AS impressions, 
        SUM(clicks) AS clicks, 
        SUM(spend) AS spend,
        SUM((SELECT SUM(action.value.value) 
          FROM UNNEST(actions) as action
          WHERE  action.value.action_type like "%install")
         ) as installs  
    FROM `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_02.ads_insights_region`
    GROUP BY DATE(date_start),region
    ORDER BY cost_date
)
-- UNION ALL
-- (
--     SELECT 
--         'FB' AS platform, 
--         DATE(date_start) AS cost_date, 
--         region,
--         SUM(impressions) AS impressions, 
--         SUM(clicks) AS clicks, 
--         SUM(spend) AS spend,
--         SUM((SELECT SUM(action.value.value) 
--           FROM UNNEST(actions) as action
--           WHERE  action.value.action_type like "%install")
--          ) as installs 
--     FROM `srpproduct-dc37e.facebook_ads_gensmow2agensmo_yla_dt_03.ads_insights_region`
--     GROUP BY DATE(date_start),region
--     ORDER BY cost_date
-- )
-- UNION ALL
-- (
--     SELECT 
--         'FB' AS platform, 
--         DATE(date_start) AS cost_date, 
--         region,
--         SUM(impressions) AS impressions, 
--         SUM(clicks) AS clicks, 
--         SUM(spend) AS spend,
--         SUM((SELECT SUM(action.value.value) 
--           FROM UNNEST(actions) as action
--           WHERE  action.value.action_type like "%install")
--          ) as installs  
--     FROM `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_04.ads_insights_region`
--     GROUP BY DATE(date_start),region
--     ORDER BY cost_date
-- )
-- UNION ALL
-- (
--     SELECT 
--         'FB' AS platform, 
--         DATE(date_start) AS cost_date, 
--         region,
--         SUM(impressions) AS impressions, 
--         SUM(clicks) AS clicks, 
--         SUM(spend) AS spend,
--         SUM((SELECT SUM(action.value.value) 
--           FROM UNNEST(actions) as action
--           WHERE  action.value.action_type like "%install")
--          ) as installs  
--     FROM `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_05.ads_insights_region`
--     GROUP BY DATE(date_start),region
--     ORDER BY cost_date
-- )
-- UNION ALL
-- (
--     SELECT 
--         'FB' AS platform, 
--         DATE(date_start) AS cost_date, 
--         region,
--         SUM(impressions) AS impressions, 
--         SUM(clicks) AS clicks, 
--         SUM(spend) AS spend,
--         SUM((SELECT SUM(action.value.value) 
--           FROM UNNEST(actions) as action
--           WHERE  action.value.action_type like "%install")
--          ) as installs  
--     FROM `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_06.ads_insights_region`
--     GROUP BY DATE(date_start),region
--     ORDER BY cost_date
-- )
-- UNION ALL
-- (
--     SELECT 
--         'FB' AS platform, 
--         DATE(date_start) AS cost_date, 
--         region,
--         SUM(impressions) AS impressions, 
--         SUM(clicks) AS clicks, 
--         SUM(spend) AS spend,
--         SUM((SELECT SUM(action.value.value) 
--           FROM UNNEST(actions) as action
--           WHERE  action.value.action_type like "%install")
--          ) as installs  
--     FROM `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_07.ads_insights_region`
--     GROUP BY DATE(date_start),region
--     ORDER BY cost_date
-- )
)

select 
    t1.platform,
    t1.cost_date,
    COALESCE(t2.country, 'Others') as country,
    t1.region,
    impressions,
    clicks,
    spend,
    installs
from region_data t1 left outer join favie_dw.dim_country_region_view t2
on t1.region = t2.region;