CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_total_appsflyer_webhook_inc_1d_view`
AS with base_data as (
SELECT  dt
	   ,'Gensmo' as app_name
	   ,case when lower(media_source) like '%facebook%' or lower(media_source)  like '%360security_int%'  or lower(media_source)  like '%meta%'  then 'Meta Ads'
	        when lower(media_source) like '%google%' then 'Google Ads'
			when lower(media_source) like '%tiktok%' then 'Tiktok Ads'
			when lower(media_source) like '%apple%' then 'Apple Search Ads' else case when media_source is null or media_source='default' then 'organic' else media_source end end  as source
	   ,channel
	   ,upper(platform)  as platform 
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

FROM
(
	select dt
	       ,event_name
	       ,media_source
	       , campaign_id
	       , campaign_name
	       , ad_group_id
	       , ad_group_name
	       , ad_id
	      ,ad_name
	       ,country_code
	       ,appsflyer_id
	       , platform
	       ,channel
		   , user_id
		   , event_time
	from (
	select  dt
	       ,event_name
	       ,media_source
	       , campaign_id
	       , campaign_name
	       , ad_group_id
	       , ad_group_name
	       , ad_id
	       , ad_name
	       ,country_code
	       ,appsflyer_id
	       , platform
	       ,channel
		   , user_id
		   , event_time
		   ,row_number() OVER ( PARTITION BY dt,appsflyer_id,EXTRACT(HOUR FROM SAFE.PARSE_DATETIME('%Y-%m-%d %H:%M:%E*S', (event_time))) ORDER BY event_time asc  ) AS rk
	from (
	SELECT  date(event_time)    AS dt
	       ,event_name
	       ,media_source
	       ,af_c_id             AS campaign_id
	       ,campaign            AS campaign_name
	       ,af_adset_id         AS ad_group_id
	       ,af_adset            AS ad_group_name
	       ,af_ad_id as ad_id
	       ,af_ad               AS ad_name
	       ,country_code
	       ,appsflyer_id
	       ,platform            AS platform
	       ,channel
		   ,JSON_EXTRACT_SCALAR(event_value, '$.uid') AS user_id
		   ,event_time as event_time
	FROM `favie_dw.dwd_gem_appsflyer_webhook_inc_1d_view`
	where event_name in  ('install' ,'re-engagement') 
	)
	) t1
	where rk=1

	union all 

	SELECT  
		date(event_time)                         AS dt
		,event_name
		,media_source
		,af_c_id                                  AS campaign_id
		,campaign                                 AS campaign_name
		,af_adset_id                              AS ad_group_id
		,af_adset                                 AS ad_group_name
		,af_ad_id                                 AS ad_id
		,af_ad                                    AS ad_name
		,country_code
		,appsflyer_id
		,platform                                 AS platform
		,channel
		,JSON_EXTRACT_SCALAR(event_value,'$.uid') AS user_id
		,event_time                               AS event_time
	FROM `favie_dw.dwd_gem_appsflyer_webhook_inc_1d_view`
	WHERE event_name IN ('re-attribution') 

	UNION ALL

	
	SELECT  
		date(event_time)                         AS dt
		,event_name
		,upper(event_name)                        AS source
		,upper(event_name)                        AS campaign_id
		,upper(event_name)                        AS campaign_name
		,upper(event_name)                        AS ad_group_id
		,upper(event_name)                        AS ad_group_name
		,upper(event_name)                        AS ad_id
		,upper(event_name)                        AS ad_name
		,'US'                                     AS country_code
		,appsflyer_id
		,platform                                 AS platform
		,'ON_LINE'                                AS channel
		,JSON_EXTRACT_SCALAR(event_value,'$.uid') AS user_id
		,event_time                               AS event_time
	FROM `favie_dw.dwd_gem_appsflyer_webhook_inc_1d_view`
	WHERE event_name IN ('af_push_open') 
	group by date(event_time)                         
		,event_name
		,appsflyer_id
		,platform
    ,JSON_EXTRACT_SCALAR(event_value,'$.uid')
    ,event_time




	UNION ALL


	SELECT  date(dt)                             AS dt
	       ,event_name
	       ,media_source
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
	       ,country_code
	       ,appsflyer_id
	       ,platform
	       ,channel
		   ,user_id
		   ,event_time
	FROM
	(
		
		SELECT  dt
		       ,event_name
		       ,media_source
		       ,coalesce(ad_network_campaign_id,'SKAN')   AS campaign_name
		       ,coalesce(ad_network_campaign_name,'SKAN') AS campaign_id
		       ,coalesce(ad_network_adset_id,'SKAN')      AS ad_group_name
		       ,coalesce(ad_network_adset_name,'SKAN')    AS ad_group_id
		       ,'SKAN'                                    AS ad_name
		       ,'SKAN'                                    AS ad_id
		       ,'US'                                      AS country_code
		       ,'IOS'                                     AS platform
		       ,'SKAN'                                    AS channel
		       ,af_attribution_flag
			   ,concat('fake_appsflyer_id_',GENERATE_UUID()) AS appsflyer_id
			   ,concat('fake_user_id',GENERATE_UUID()) as user_id
			   ,cast(dt as string) as event_time
		FROM `favie_dw.dwd_gem_skan_appsflyer_webhook_inc_1d_view`
		where coalesce(af_attribution_flag,false)  !=true and event_name in  ('install' ,'re-engagement','re-attribution','af_push_open') 
		
	)



)
),
 

af_open_by_url_data as (


select 
dt
,channel
,appsflyer_id
,event_value
,'reddit' as source
from (
SELECT  CASE WHEN event_value LIKE '%com.googleusercontent.apps%' THEN 'non_active_content'
             WHEN event_value LIKE '%onelink%' THEN 'onelink'
             WHEN event_value LIKE '%ct=%' THEN 'appstore'  ELSE 'unknown' END  as channel 
      ,appsflyer_id
	  ,event_value
	  ,date(event_time) as dt
	  ,row_number() OVER (PARTITION BY appsflyer_id ORDER BY event_time DESC) AS rn
FROM `favie_dw.dwd_gem_appsflyer_webhook_inc_1d_view`
WHERE event_name = 'af_open_by_url'
and appsflyer_id is not null
and media_source='organic'
)
where rn=1 
and channel='appstore' and event_value like '%reddit%'


)

select 
a.dt
,app_name
,coalesce(b.source,a.source) as source
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
from base_data a
left join af_open_by_url_data b
on a.appsflyer_id=b.appsflyer_id and a.dt=b.dt and a.event_name in ('install') and a.source='organic';