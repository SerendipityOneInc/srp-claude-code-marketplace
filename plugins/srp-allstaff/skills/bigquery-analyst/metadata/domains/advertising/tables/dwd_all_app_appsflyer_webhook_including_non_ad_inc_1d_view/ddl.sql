CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_all_app_appsflyer_webhook_including_non_ad_inc_1d_view`
AS with  af_with_unique_id as(
select 
			dt
	       ,app_name
	       ,source
	       ,channel
	       ,platform
	       ,event_name
	       ,coalesce(campaign_name,upper(source)) as campaign_name
	       ,coalesce(campaign_id,upper(source)) as campaign_id
	       ,coalesce(ad_group_name,upper(source)) as ad_group_name
	       ,coalesce(ad_group_id,upper(source)) as ad_group_id
	       ,coalesce(ad_id,upper(source)) as ad_id
	       ,coalesce(ad_name,upper(source)) as ad_name
	       ,country_code
	       ,appsflyer_id
		   ,user_id
		   ,event_time
from (
	SELECT  dt
	       ,app_name
	       ,source
	       ,channel
	       ,platform
	       ,event_name
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
	       ,country_code
	       ,appsflyer_id
		   ,user_id
		   ,event_time
	       ,ROW_NUMBER() OVER ( PARTITION BY event_name,appsflyer_id ORDER BY  CASE WHEN channel = 'ON_LINE' THEN 1 WHEN channel = 'OFF_LINE' THEN 2 else 3 end ,CASE WHEN source NOT IN ('organic','None') THEN 1 WHEN source = 'organic' THEN 2 else 3 end ) AS rn
	FROM
	(
		SELECT  dt
		       ,app_name
		       ,source
		       ,channel
		       ,platform
		       ,event_name
		       ,campaign_name
		       ,campaign_id
		       ,ad_group_name
		       ,ad_group_id
		       ,ad_id
		       ,ad_name
		       ,country_code
		       ,appsflyer_id
			   ,user_id
			   ,event_time
		FROM `favie_dw.dwd_gem_total_appsflyer_webhook_including_non_ad_inc_1d_view`
        where appsflyer_id is not null 
		UNION ALL
		SELECT  dt
		       ,app_name
		       ,source
		       ,channel
		       ,platform
		       ,event_name
		       ,campaign_name
		       ,campaign_id
		       ,ad_group_name
		       ,ad_group_id
		       ,ad_id
		       ,ad_name
		       ,country_code
		       ,appsflyer_id
			   ,user_id
			   ,event_time
		FROM `favie_dw.dwd_decofy_total_appsflyer_webhook_including_non_ad_inc_1d_view`
         where appsflyer_id is not null 
	)
)
where rn=1
),


unique_campaign_ad_group_ad_data as (
--campagin 可能会出现多条,根据安装时间拿到最新的那一条,把之前的campagin name , ad_group_name , ad_name替换掉

SELECT  
			a.dt
	       ,a.app_name
	       ,a.source
	       ,a.channel
	       ,a.platform
	       ,a.event_name
	       ,b.campaign_name
	       ,a.campaign_id
	       ,b.ad_group_name
	       ,a.ad_group_id
	       ,a.ad_id
	       ,b.ad_name
	       ,a.country_code
	       ,a.appsflyer_id
		   ,a.user_id
		   ,a.event_time
FROM af_with_unique_id a
LEFT JOIN
(
	SELECT  campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_name
	       ,ad_id
	FROM
	(
		SELECT  campaign_name
		       ,campaign_id
		       ,ad_group_name
		       ,ad_group_id
		       ,ad_name
		       ,ad_id
		       ,ROW_NUMBER() OVER (PARTITION BY campaign_id,ad_group_id,ad_id ORDER BY  event_time DESC) AS rn
		FROM af_with_unique_id
	)a
	WHERE rn = 1 
) b
on a.campaign_id = b.campaign_id
and a.ad_group_id = b.ad_group_id
and a.ad_id = b.ad_id

)



SELECT  a.dt
       ,a.app_name
       ,a.source
       ,a.channel
       ,a.platform
       ,a.event_name
       ,a.campaign_name
       ,a.campaign_id 
       ,a.ad_group_name
       ,a.ad_group_id
       ,a.ad_id
       ,a.ad_name
       ,a.country_code
       ,a.appsflyer_id
       ,a.user_id
	   ,a.event_time
       ,coalesce(b.account_name,upper(a.source)) as account_name
       ,coalesce(b.account_id,upper(a.source)) as account_id
	   ,c.ad_category
FROM af_with_unique_id a
LEFT JOIN
(
	SELECT  campaign_id
	       ,MAX(account_name) AS account_name
	       ,MAX(account_id)   AS account_id
	FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
	GROUP BY  campaign_id
) b
ON a.campaign_id = b.campaign_id
left join 
(
	SELECT  
		campaign_id
       ,ad_group_id
       ,ad_id
       ,max(ad_category) as ad_category
FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
GROUP BY  campaign_id
         ,ad_group_id
         ,ad_id
         
)c
on a.campaign_id = c.campaign_id
and a.ad_group_id = c.ad_group_id
and a.ad_id = c.ad_id;