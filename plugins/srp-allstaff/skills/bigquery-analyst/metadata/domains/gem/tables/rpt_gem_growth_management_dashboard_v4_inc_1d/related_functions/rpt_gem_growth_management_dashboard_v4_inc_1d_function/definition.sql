WITH full_first_device_info AS
(
	SELECT  geo_country_name
	       ,appsflyer_id
	       ,first_device_id
	       ,created_at
	       ,app_platform
	FROM
	(
		SELECT  geo_address.geo_country_name                      AS geo_country_name
		       ,appsflyer_id
		       ,first_device_id
		       ,Date(created_at)                                  AS created_at
		       ,ROW_NUMBER() OVER (PARTITION BY first_device_id ) AS rk
		       ,app_info.platform                                 AS app_platform
		FROM `favie_dw.dim_favie_gensmo_user_account_changelog_1d`
		WHERE is_internal_user is false 
        --and app_info.platform IN ('app', 'android')
		AND first_device_id is not null
		AND user_id is not null 
	) a
	WHERE rk = 1 
) 
,

filtered_device_info as (
SELECT  a.device_id as first_device_id
       ,b.appsflyer_id
       ,date(created_at) AS created_at
       ,a.dt
       ,is_internal_user
FROM
(
	SELECT  device_id
	       ,dt
	FROM `srpproduct-dc37e`.`favie_dw`.`dwd_favie_gensmo_events_inc_1d`
	WHERE 1 = 1
	AND event_name != "user_engagement"
	AND ( event_method NOT IN ('app_launch', 'app_foreground') or event_method is null )
	AND dt >= dt_param
	AND dt <= DATE_ADD(dt_param, INTERVAL 6 DAY)
	GROUP BY  device_id
	         ,dt
) a
LEFT JOIN favie_dw.dws_favie_gensmo_user_feature_inc_1d b
ON a.device_id = b.device_id AND a.dt = b.dt
)



, dt_parm_device_info AS
(
	SELECT  first_device_id
	       ,appsflyer_id
	       ,dt
	       ,created_at
	FROM
	(
		SELECT  first_device_id
		       ,appsflyer_id
		       ,Date(created_at)                                     AS created_at
		       ,ROW_NUMBER() OVER (PARTITION BY first_device_id,dt ) AS rk
		       ,dt
		FROM filtered_device_info a
		WHERE 1 = 1
		AND (dt = dt_param or dt = DATE_ADD(dt_param, INTERVAL 1 DAY) )
		AND Date(created_at) = dt_param
		AND is_internal_user is false
	) a
	WHERE rk = 1 
)

, device_with_start_info AS
(
	--当天的这个活跃用户的最开始的信息
	SELECT  a.first_device_id
	       ,a.created_at
	       ,a.dt                                                            AS dt
	--先使用最开始产生的appsflyer id、地理位置和 平台
	       ,coalesce(b.appsflyer_id,a.appsflyer_id)                         AS appsflyer_id
	       ,b.geo_country_name                                              AS geo_country_name
	       ,b.app_platform
	       ,CASE WHEN date_diff(dt,a.created_at,day) = 0 THEN 1  ELSE 0 END AS is_d0_active
	       ,CASE WHEN date_diff(dt,a.created_at,day) = 1 THEN 1  ELSE 0 END AS is_d1_active
	FROM dt_parm_device_info a
	LEFT JOIN full_first_device_info b
	ON a.first_device_id = b.first_device_id
)


, lt7_info AS
(
	SELECT  first_device_id
	       ,COUNT(distinct dt) AS lt7
	FROM filtered_device_info a
	WHERE 1 = 1
	AND (dt >= dt_param AND dt <= DATE_ADD(dt_param, INTERVAL 6 DAY) )
	--如果日期超过lt7才计算
	AND CURRENT_DATE() >= DATE_ADD(dt_param, INTERVAL 6 DAY)
	AND first_device_id is not null
	GROUP BY  first_device_id
) 

, retention_per_device AS
(
	SELECT  a.first_device_id
	       ,a.created_at
	       ,a.dt
	       ,a.appsflyer_id
	       ,a.geo_country_name
	       ,a.app_platform
	       ,a.is_d0_active
	--第二天没关联上就是null,关联上可为0 可为1
	       ,b.is_d1_active
	FROM device_with_start_info a
	LEFT JOIN device_with_start_info b
	ON a.first_device_id = b.first_device_id AND DATE_ADD(a.dt, INTERVAL 1 DAY) = b.dt
	WHERE a.dt = dt_param
)


,final_device_info as (
       
   SELECT  first_device_id
       ,created_at
       ,dt
       ,appsflyer_id
       ,CASE 
  WHEN geo_country_name = 'United States' THEN 'US'
  WHEN geo_country_name = 'United Kingdom' THEN 'UK'
  WHEN geo_country_name = 'China' THEN 'CN'
  WHEN geo_country_name = 'Japan' THEN 'JP'
  WHEN geo_country_name = 'Germany' THEN 'DE'
  WHEN geo_country_name = 'France' THEN 'FR'
  WHEN geo_country_name = 'Canada' THEN 'CA'
  WHEN geo_country_name = 'Australia' THEN 'AU'
  WHEN geo_country_name = 'India' THEN 'IN'
  WHEN geo_country_name = 'Brazil' THEN 'BR'
  WHEN geo_country_name = 'Russia' THEN 'RU'
  WHEN geo_country_name = 'South Korea' THEN 'KR'
  WHEN geo_country_name = 'Italy' THEN 'IT'
  WHEN geo_country_name = 'Spain' THEN 'ES'
  WHEN geo_country_name = 'Mexico' THEN 'MX'
  WHEN geo_country_name = 'Netherlands' THEN 'NL'
  WHEN geo_country_name = 'Sweden' THEN 'SE'
  WHEN geo_country_name = 'Norway' THEN 'NO'
  WHEN geo_country_name = 'Denmark' THEN 'DK'
  WHEN geo_country_name = 'Finland' THEN 'FI'
  WHEN geo_country_name = 'Switzerland' THEN 'CH'
  WHEN geo_country_name = 'Austria' THEN 'AT'
  WHEN geo_country_name = 'Belgium' THEN 'BE'
  WHEN geo_country_name = 'Ireland' THEN 'IE'
  WHEN geo_country_name = 'Poland' THEN 'PL'
  WHEN geo_country_name = 'Turkey' THEN 'TR'
  WHEN geo_country_name = 'Saudi Arabia' THEN 'SA'
  WHEN geo_country_name = 'United Arab Emirates' THEN 'AE'
  WHEN geo_country_name = 'Israel' THEN 'IL'
  WHEN geo_country_name = 'Singapore' THEN 'SG'
  WHEN geo_country_name = 'Malaysia' THEN 'MY'
  WHEN geo_country_name = 'Thailand' THEN 'TH'
  WHEN geo_country_name = 'Indonesia' THEN 'ID'
  WHEN geo_country_name = 'Philippines' THEN 'PH'
  WHEN geo_country_name = 'Vietnam' THEN 'VN'
  WHEN geo_country_name = 'Taiwan' THEN 'TW'
  WHEN geo_country_name = 'Hong Kong' THEN 'HK'
  WHEN geo_country_name = 'South Africa' THEN 'ZA'
  WHEN geo_country_name = 'Nigeria' THEN 'NG'
  WHEN geo_country_name = 'Egypt' THEN 'EG'
  WHEN geo_country_name = 'Argentina' THEN 'AR'
  WHEN geo_country_name = 'Chile' THEN 'CL'
  WHEN geo_country_name = 'Colombia' THEN 'CO'
  WHEN geo_country_name = 'Peru' THEN 'PE'
  WHEN geo_country_name = 'Venezuela' THEN 'VE'
  WHEN geo_country_name = 'New Zealand' THEN 'NZ'
  WHEN geo_country_name = 'Czech Republic' THEN 'CZ'
  WHEN geo_country_name = 'Hungary' THEN 'HU'
  WHEN geo_country_name = 'Romania' THEN 'RO'
  WHEN geo_country_name = 'Bulgaria' THEN 'BG'
  WHEN geo_country_name = 'Croatia' THEN 'HR'
  WHEN geo_country_name = 'Greece' THEN 'GR'
  WHEN geo_country_name = 'Portugal' THEN 'PT'
  WHEN geo_country_name = 'Ukraine' THEN 'UA'
  WHEN geo_country_name = 'Belarus' THEN 'BY'
  WHEN geo_country_name = 'Kazakhstan' THEN 'KZ'
  WHEN geo_country_name IS NULL THEN 'Unknown'
  ELSE 'Others'
END AS country_code
--这里的app_platform是第一次的登陆用的平台,即便是后面切换平台也不会换
       ,case when lower(app_platform)='app' then 'IOS' else app_platform end as app_platform 
       ,is_d0_active
       ,is_d1_active
       ,lt7
FROM
(
	--dt_param 里的分区 创建用户等于当天的 留存 和 次留 以及 lt7 
	SELECT  t0.first_device_id
	       ,t0.created_at
	       ,t0.dt
	       ,t0.appsflyer_id
	       ,t0.geo_country_name
	       ,t0.app_platform
	       ,t0.is_d0_active
	       ,t0.is_d1_active
	       ,t1.lt7
	       ,ROW_NUMBER() OVER (PARTITION BY t0.appsflyer_id ORDER BY  dt ASC) AS rk
	FROM retention_per_device AS t0
	LEFT JOIN lt7_info t1
	ON t0.first_device_id = t1.first_device_id
) a
WHERE rk = 1


)





,af_data as (
SELECT  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,event_name
       ,account_name
       ,account_id
       ,campaign_name
       ,campaign_id
       ,ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
       ,country_code
       ,appsflyer_id
	   ,event_time
	   ,ad_category
FROM `favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view`
WHERE dt = dt_param
AND app_name = 'Gensmo'
AND channel != 'SKAN'

),

af_skan_data AS (


--只拿skan的数据 ,并且聚合到ad 粒度,拿到总的skan的数据 和 每一个ad的安装数

SELECT  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,event_name
       ,account_name
       ,account_id
       ,campaign_name
       ,campaign_id
       ,ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
       ,skan_af_install_cnt
	   ,ad_category
       ,SUM(skan_af_install_cnt) OVER () AS total_skan_af_install
FROM
(
	SELECT  dt
	       ,app_name
	       ,source
	       ,channel
	       ,platform
	       ,event_name
	       ,account_name
	       ,account_id
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
	       ,ad_category
	       ,COUNT(distinct appsflyer_id) AS skan_af_install_cnt
	FROM `favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view`
	WHERE dt = dt_param
	AND app_name = 'Gensmo'
	AND channel = 'SKAN'
	GROUP BY  dt
	         ,app_name
	         ,source
	         ,channel
	         ,platform
	         ,event_name
	         ,account_name
	         ,account_id
	         ,campaign_name
	         ,campaign_id
	         ,ad_group_name
	         ,ad_group_id
	         ,ad_id
	         ,ad_name
	         ,ad_category
)  
)

,af_retention as (



SELECT  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,event_name
       ,account_name
       ,account_id 
       ,campaign_name
       ,campaign_id
       ,ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
	     ,ad_category
       ,MAX(country_code)               AS country_code
       ,COUNT(distinct af_appsflyer_id) AS install_cnt
       ,COUNT(distinct first_device_id) AS new_user_cnt
       ,SUM(is_d0_active)               AS d0_active_cnt
       ,SUM(is_d1_active)               AS d1_retention_cnt
       ,SUM(lt7)                        AS lt7_cnt
	   ,max(event_time)               AS event_time
FROM
(
	--当天创建的用户
	SELECT  coalesce(a.dt,b.dt)                     AS dt
	       ,coalesce(a.app_name,'Gensmo') as app_name
	       ,coalesce(a.source,'NOT_FROM_AF') as source
	       ,a.channel
	       ,upper(coalesce(a.platform,b.app_platform))     AS platform
	       ,a.event_name
              ,a.account_name
              ,a.account_id
	       ,a.campaign_name
	       ,a.campaign_id
	       ,a.ad_group_name
	       ,a.ad_group_id
	       ,a.ad_id
	       ,a.ad_name
	       ,coalesce(a.country_code,b.country_code) AS country_code
	       ,a.appsflyer_id                          AS af_appsflyer_id
		   ,a.event_time
		   ,a.ad_category
	       ,b.is_d0_active
	       ,b.is_d1_active
	       ,b.lt7
	       ,b.first_device_id
	FROM af_data AS a
	FULL JOIN final_device_info b
	ON a.appsflyer_id = b.appsflyer_id
)
GROUP BY  dt
         ,app_name
         ,source
         ,channel
         ,platform
         ,event_name
         ,account_name
         ,account_id 
         ,campaign_name
         ,campaign_id
         ,ad_group_name
         ,ad_group_id
         ,ad_id
         ,ad_name
         ,ad_category



),
 



 organic_with_metrics_data AS (
--这里会拿到两条相同的数据,
--目的是为了算skan和 organic , 把其中一条organic 拆分为广告数据,
SELECT  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,event_name
       ,account_name
       ,account_id
       ,campaign_name
       ,campaign_id
       ,ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
	   ,ad_category
       ,country_code
       ,install_cnt
       ,new_user_cnt
       ,d0_active_cnt
       ,d1_retention_cnt
       ,lt7_cnt
       ,'normal' AS tag
       ,'SKAN'   AS attribution_method

FROM af_retention a
WHERE source = 'organic'
AND platform = 'IOS'
AND app_name = 'Gensmo' 
UNION ALL
SELECT  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,event_name
       ,account_name
       ,account_id
       ,campaign_name
       ,campaign_id
       ,ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
	   ,ad_category
       ,country_code
       ,install_cnt
       ,new_user_cnt
       ,d0_active_cnt
       ,d1_retention_cnt
       ,lt7_cnt
       ,'extra' AS tag
       ,'SKAN'  AS attribution_method
FROM af_retention a
WHERE source = 'organic'
AND platform = 'IOS'
AND app_name = 'Gensmo' ) ,

 ssot_data AS 
(
	--这里算出来的数据 是把skan-ad +剩下的organic 的数据 
	SELECT  dt
	       ,app_name
	       ,source
	       ,channel
	       ,platform
	       ,event_name
	       ,account_name
	       ,account_id
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
	       ,ad_category
	       ,country_code
	       ,coalesce(skan_af_install_cnt,organic_install_cnt)             AS ssot_install_cnt
	       ,coalesce(wight,organic_wight)                                 AS ssot_wight
	       ,coalesce(ssot_new_user_cnt,organic_ssot_new_user_cnt)         AS ssot_new_user_cnt
	       ,coalesce(ssot_d0_active_cnt,organic_ssot_d0_active_cnt)       AS ssot_d0_active_cnt
	       ,coalesce(ssot_d1_retention_cnt,organic_ssot_d1_retention_cnt) AS ssot_d1_retention_cnt
	       ,coalesce(ssot_lt7_cnt,organic_ssot_lt7_cnt)                   AS ssot_lt7_cnt
	       ,install_cnt
	       ,new_user_cnt
	       ,d0_active_cnt
	       ,d1_retention_cnt
	       ,lt7_cnt
	       ,attribution_method
	FROM
	(
		SELECT  dt
		       ,app_name
		       ,source
		       ,channel
		       ,platform
		       ,event_name
		       ,account_name
		       ,account_id
		       ,campaign_name
		       ,campaign_id
		       ,ad_group_name
		       ,ad_group_id
		       ,ad_id
		       ,ad_name
			   ,ad_category
		       ,country_code
		       ,install_cnt
		       ,skan_af_install_cnt
		       ,new_user_cnt
		       ,d0_active_cnt
		       ,d1_retention_cnt
		       ,lt7_cnt
		       ,wight
		       ,ssot_new_user_cnt
		       ,ssot_d0_active_cnt
		       ,ssot_d1_retention_cnt
		       ,ssot_lt7_cnt
		       ,total_skan_af_install_cnt
		       ,install_cnt - total_skan_af_install_cnt                                            AS organic_install_cnt
		       ,safe_divide(install_cnt - total_skan_af_install_cnt,install_cnt)                   AS organic_wight
		       ,safe_divide(install_cnt- total_skan_af_install_cnt,install_cnt) * new_user_cnt     AS organic_ssot_new_user_cnt
		       ,safe_divide(install_cnt- total_skan_af_install_cnt,install_cnt) * d0_active_cnt    AS organic_ssot_d0_active_cnt
		       ,safe_divide(install_cnt- total_skan_af_install_cnt,install_cnt) * d1_retention_cnt AS organic_ssot_d1_retention_cnt
		       ,safe_divide(install_cnt- total_skan_af_install_cnt,install_cnt) * lt7_cnt          AS organic_ssot_lt7_cnt
		       ,attribution_method
		FROM
		(
			SELECT  dt
			       ,app_name
			       ,source
			       ,channel
			       ,platform
			       ,event_name
			       ,account_name
			       ,account_id
			       ,campaign_name
			       ,campaign_id
			       ,ad_group_name
			       ,ad_group_id
			       ,ad_id
			       ,ad_name
				   ,ad_category
			       ,country_code
			       ,install_cnt
			       ,skan_af_install_cnt
			       ,new_user_cnt
			       ,d0_active_cnt
			       ,d1_retention_cnt
			       ,lt7_cnt
			       ,wight
			       ,ssot_new_user_cnt
			       ,ssot_d0_active_cnt
			       ,ssot_d1_retention_cnt
			       ,ssot_lt7_cnt
			       ,SUM(skan_af_install_cnt) OVER (PARTITION BY app_name) AS total_skan_af_install_cnt
			       ,attribution_method
			FROM
			(
				SELECT  coalesce(b.dt,a.dt)                                               AS dt
				       ,coalesce(b.app_name,a.app_name)                                   AS app_name
				       ,coalesce(b.source,a.source)                                       AS source
				       ,coalesce(b.channel,a.channel)                                     AS channel
				       ,coalesce(b.platform,a.platform)                                   AS platform
				       ,coalesce(b.event_name,a.event_name)                               AS event_name
				       ,coalesce(b.account_name,a.account_name)                           AS account_name
				       ,coalesce(b.account_id,a.account_id)                               AS account_id
				       ,coalesce(b.campaign_name,a.campaign_name)                         AS campaign_name
				       ,coalesce(b.campaign_id,a.campaign_id)                             AS campaign_id
				       ,coalesce(b.ad_group_name,a.ad_group_name)                         AS ad_group_name
				       ,coalesce(b.ad_group_id,a.ad_group_id)                             AS ad_group_id
				       ,coalesce(b.ad_id,a.ad_id)                                         AS ad_id
				       ,coalesce(b.ad_name,a.ad_name)                                     AS ad_name
					   ,coalesce(b.ad_category,a.ad_category)                             AS ad_category
				       ,a.country_code                                                    AS country_code
				       ,install_cnt
				       ,b.skan_af_install_cnt
				       ,a.new_user_cnt
				       ,a.d0_active_cnt
				       ,a.d1_retention_cnt
				       ,a.lt7_cnt
				       ,safe_divide(skan_af_install_cnt,a.install_cnt)                    AS wight
				       ,safe_divide(skan_af_install_cnt,a.install_cnt) * new_user_cnt     AS ssot_new_user_cnt
				       ,safe_divide(skan_af_install_cnt,a.install_cnt) * d0_active_cnt    AS ssot_d0_active_cnt
				       ,safe_divide(skan_af_install_cnt,a.install_cnt) * d1_retention_cnt AS ssot_d1_retention_cnt
				       ,safe_divide(skan_af_install_cnt,a.install_cnt) * lt7_cnt          AS ssot_lt7_cnt
				       ,attribution_method
				FROM organic_with_metrics_data a
				LEFT JOIN af_skan_data b
				ON tag = 'normal' --只拿其中一条数据
				
			)
		)
	)
), 
skan_and_classic_data AS (

SELECT  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,max(account_name) as account_name
       ,account_id
       ,max(campaign_name) as campaign_name
       ,campaign_id
       ,max(ad_group_name) as ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
	   	,ad_category
       ,attribution_method
       ,MAX(country_code)     AS country_code
       ,SUM(install_cnt)      AS install_cnt
       ,SUM(wight)            AS wight
       ,SUM(new_user_cnt)     AS new_user_cnt
       ,SUM(d0_active_cnt)    AS d0_active_cnt
       ,SUM(d1_retention_cnt) AS d1_retention_cnt
       ,SUM(lt7_cnt)          AS lt7_cnt
FROM
(
	SELECT  dt
	       ,app_name
	       ,source
	       ,channel
	       ,platform
	       ,event_name
	       ,account_name
	       ,account_id
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
		   ,ad_category
	       ,country_code
	       ,ssot_install_cnt      AS install_cnt
	       ,ssot_wight            AS wight
	       ,ssot_new_user_cnt     AS new_user_cnt
	       ,ssot_d0_active_cnt    AS d0_active_cnt
	       ,ssot_d1_retention_cnt AS d1_retention_cnt
	       ,ssot_lt7_cnt          AS lt7_cnt
	       ,attribution_method
	FROM ssot_data
	UNION ALL
	SELECT  dt
	       ,app_name
	       ,source
	       ,channel
	       ,platform
	       ,event_name
	       ,account_name
	       ,account_id
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
		   ,ad_category
	       ,country_code
	       ,install_cnt
	       ,1         AS wight
	       ,new_user_cnt
	       ,d0_active_cnt
	       ,d1_retention_cnt
	       ,lt7_cnt
	       ,'CLASSIC' AS attribution_method
	FROM af_retention a
	WHERE source = 'organic'
	AND platform = 'IOS'
	AND app_name = 'Gensmo' 
	UNION ALL
	SELECT  dt
	       ,app_name
	       ,source
	       ,channel
	       ,platform
	       ,event_name
	       ,account_name
	       ,account_id
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
		   ,ad_category
	       ,country_code
	       ,install_cnt
	       ,1      AS wight
	       ,new_user_cnt
	       ,d0_active_cnt
	       ,d1_retention_cnt
	       ,lt7_cnt
	       ,'BOTH' AS attribution_method
	FROM af_retention a
	WHERE not (source = 'organic' AND platform = 'IOS')
  
)
GROUP BY  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,account_id
       ,campaign_id
       ,ad_group_id
       ,ad_id
       ,ad_name
	   ,ad_category
       ,attribution_method
) ,
ad_data as (

    SELECT    dt
	       ,source
	       ,platform
	       ,app_name
	       ,account_id
	       ,account_name
	       ,campaign_id
	       ,campaign_name
	       ,ad_group_id
	       ,ad_group_name
		   --af缺少ad id , 所以把 ad的 google的数据处理到group 粒度
	      , ad_id
	      , ad_name
         ,ad_category
	       ,max(country_code) as country_code 
	       ,sum(impression) as  impression 
	       ,sum(click) as click
	       ,sum(conversion) as conversion 
	       ,sum(cost) as cost 
	FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
       where dt=dt_param
       and app_name='Gensmo'
	group by dt
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
	       
)


select 
coalesce(a.dt,b.dt) as dt
,coalesce(a.source,b.source) as source
,Upper(coalesce(a.platform,b.platform)) as platform
,coalesce(a.app_name,b.app_name) as app_name
,coalesce(a.account_id,b.account_id) as account_id
,coalesce(a.account_name,b.account_name) as account_name
,coalesce(a.campaign_id,b.campaign_id) as campaign_id
,coalesce(a.campaign_name,b.campaign_name) as campaign_name
,coalesce(a.ad_group_id,b.ad_group_id) as ad_group_id
,coalesce(a.ad_group_name,b.ad_group_name) as ad_group_name
,coalesce(a.ad_id,b.ad_id) as ad_id
,coalesce(a.ad_name,b.ad_name) as ad_name
,coalesce(a.ad_category,b.ad_category) as ad_category
,coalesce(a.country_code,b.country_code) as country_code
,coalesce(b.channel,'ON_LINE') as channel
,coalesce(attribution_method,'BOTH')  as attribution_method
,coalesce(a.impression,0) as impression
,coalesce(a.click,0) as click
,coalesce(a.conversion,0) as conversion
,coalesce(a.cost,0) as cost
,coalesce(b.install_cnt,0)  as install_cnt
,coalesce(b.new_user_cnt,0) as  new_user_cnt
,coalesce(b.d0_active_cnt,0) as  d0_active_cnt
,coalesce(b.d1_retention_cnt,0) as  d1_retention_cnt
,coalesce(b.lt7_cnt,0) as lt7_cnt

from ad_data a
full  join skan_and_classic_data b
ON coalesce(a.campaign_id, '') = coalesce(b.campaign_id, '') AND coalesce(a.ad_group_id, '') = coalesce(b.ad_group_id, '') AND coalesce(a.ad_id, '') = coalesce(b.ad_id, '') AND a.dt = b.dt