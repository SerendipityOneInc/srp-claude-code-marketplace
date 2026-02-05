# rpt_gem_growth_management_dashboard_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_growth_management_dashboard_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-08-04
**最后更新**: 2025-08-04

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
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
SELECT  b.first_device_id
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
       ,app_platform
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





,af_with_unique_af_id as (
SELECT        dt
              ,app_name
	       ,af_platform
	       ,country_code
	       ,af_campaign_id
	       ,af_campaign_name
	      
	       ,ad_group_id
	       ,ad_group_name
	       ,af_ad_id
	       ,af_ad_name
              ,finest_ad_class_id
              ,finest_ad_class_name
              ,source
              ,media_source
              ,appsflyer_id
             
FROM
(
	SELECT  
	        dt
               ,app_name
	       ,platform as af_platform 
	       ,country_code
	       ,campaign_id as af_campaign_id
	       ,campaign_name as af_campaign_name
	       ,ad_group_id
	       ,ad_group_name
	       ,ad_id as af_ad_id
	       ,ad_name as af_ad_name --af 的 googleadwords_int 、 Apple Search Ads 没有ad id
              ,media_source
              ,appsflyer_id
	       ,CASE WHEN media_source = 'googleadwords_int' THEN ad_group_id
	             WHEN media_source = 'Apple Search Ads' THEN ad_group_id
	             WHEN media_source = 'tiktokglobal_int' THEN campaign_id  ELSE ad_id END AS finest_ad_class_id
	       ,CASE WHEN media_source = 'googleadwords_int' THEN 'GROUP LEVEL'
	             WHEN media_source = 'Apple Search Ads' THEN 'GROUP LEVEL'
	             WHEN media_source = 'tiktokglobal_int' THEN 'CAMPAIGN' END             AS finest_ad_class_name
	       ,channel as source 
	       ,ROW_NUMBER() OVER ( PARTITION BY appsflyer_id ORDER BY  CASE WHEN source = 'ON_LINE' THEN 1 WHEN source = 'OFF_LINE' THEN 2 else 3 end ,CASE WHEN media_source NOT IN ('organic','None') THEN 1 WHEN media_source = 'organic' THEN 2 else 3 end ) AS rn
	FROM `favie_dw.dwd_gem_total_appsflyer_webhook_inc_1d_view`
	WHERE dt= dt_param 
) a
WHERE rn = 1
AND appsflyer_id is not null 


)





,install_retention as (

  --当天创建的用户
  SELECT
    t0.appsflyer_id as af_appsflyer_id
    ,t0.media_source
    ,t0.af_campaign_id
    ,t0.af_campaign_name
    ,t0.ad_group_id
    ,t0.ad_group_name
    ,t0.af_ad_id
    ,t0.af_ad_name
    ,t0.finest_ad_class_id
    ,t0.source
    ,t0.finest_ad_class_name
    ,t1.first_device_id
    ,t1.created_at
    ,t1.appsflyer_id as user_appsflyer_id
    ,t1.is_d0_active
    ,t1.is_d1_active
    ,t1.lt7
    ,coalesce(t0.dt, t1.dt) dt
    ,coalesce(t0.country_code,  t1.country_code) country_code
    ,t0.af_platform
    ,t1.app_platform
    ,coalesce(t0.af_platform,t1.app_platform) as platform
    ,t0.media_source as  af_media_source
    ,t0.app_name
  FROM
  af_with_unique_af_id AS t0
  full  JOIN   final_device_info  t1
  ON t0.appsflyer_id = t1.appsflyer_id

)

,install_retention_aggregate as (
  SELECT
    dt
    ,finest_ad_class_id
    ,af_media_source
    ,country_code
    ,platform
    ,app_name
    ,count(distinct af_appsflyer_id) as install_cnt
    ,count(distinct first_device_id) as new_user_cnt
    ,sum(is_d0_active) as d0_active_cnt
    ,sum(is_d1_active) as d1_retention_cnt
    ,sum(lt7) as lt7_cnt
  FROM install_retention
  group by 
    dt
    ,finest_ad_class_id
    ,af_media_source
    ,country_code
    ,platform
    ,app_name
)

--,ad as (
--  SELECT 
--    dt
--    ,case 
--      when platform = 'Apple Search Ads' then ad_group_id
--      when platform = 'GOOGLE Ad' then ad_group_id
--      when platform ='TikTok' then campaign_id
--      else ad_id
--    end as finest_ad_class_id
--    ,platform as ad_media_source
--    ,country_code
--    ,count(1) record_cnt
--    ,sum(coalesce(spend,0)) as spend
--    ,sum(coalesce(impressions,0)) as impressions
--    ,sum(coalesce(clicks,0)) as clicks
--    ,sum(coalesce(conversions,0)) as ad_conversions
--  FROM `srpproduct-dc37e.srp_user_growth_views.dwd_gem_ad_insights_channel_inc_1d_view` 
--  where dt=dt_param
--  group by 1,2,3,4
--)


,ad as  (
    SELECT  dt
          ,CASE WHEN source = 'Apple Search Ads' THEN ad_group_id
                WHEN source = 'Google Ads' THEN ad_group_id
                WHEN source = 'Tiktok Ads' THEN campaign_id  ELSE ad_id END                                                                           AS finest_ad_class_id
          ,source                                                                                                                                     AS ad_media_source --asa 和 google 这里处理为null 
          ,country_code
          ,MAX(case WHEN source = 'Apple Search Ads' THEN cast(null AS string) WHEN source = 'GOOGLE Ads' THEN cast(null AS string) else ad_id end)   AS ad_id
          ,MAX(case WHEN source = 'Apple Search Ads' THEN cast(null AS string) WHEN source = 'GOOGLE Ads' THEN cast(null AS string) else ad_name end) AS ad_name
          ,MAX(case WHEN source = 'Tiktok Ads' THEN cast(null AS string) else ad_group_id end)                                                        AS ad_group_id
          ,MAX(case WHEN source = 'Tiktok Ads' THEN cast(null AS string) else ad_group_name end)                                                      AS ad_group_name
          ,MAX(campaign_id)                                                                                                                           AS campaign_id
          ,MAX(campaign_name)                                                                                                                         AS campaign_name
          ,MAX(account_id)                                                                                                                            AS account_id
          ,MAX(account_name)                                                                                                                          AS account_name
          ,MAX(app_name)                                                                                                                              AS app_name
          ,MAX(platform)                                                                                                                              AS platform
          ,SUM(coalesce(cost,0))                                                                                                                      AS spend
          ,SUM(coalesce(impression,0))                                                                                                                AS impressions
          ,SUM(coalesce(click,0))                                                                                                                     AS clicks
          ,SUM(coalesce(conversion,0))                                                                                                                AS ad_conversions
    FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
    WHERE dt = dt_param
    GROUP BY  dt
          ,CASE WHEN source = 'Apple Search Ads' THEN ad_group_id
                WHEN source = 'Google Ads' THEN ad_group_id
                WHEN source = 'Tiktok Ads' THEN campaign_id  ELSE ad_id END                                                                          
          ,source 
          ,country_code
)


SELECT  coalesce(t0.dt,t1.dt)                                                                AS dt
       ,CASE WHEN coalesce(t0.ad_media_source,t1.af_media_source) = 'Apple Search Ads' THEN 'Apple Search Ads'
             WHEN coalesce(t0.ad_media_source,t1.af_media_source) = 'tiktokglobal_int' THEN 'Tiktok Ads'
             WHEN coalesce(t0.ad_media_source,t1.af_media_source) = 'googleadwords_int' THEN 'Google Ads'
             WHEN coalesce(t0.ad_media_source,t1.af_media_source) = '360security_int' or coalesce(t0.ad_media_source,t1.af_media_source) = 'Facebook Ads' THEN 'Meta Ads'  ELSE coalesce(t0.ad_media_source,t1.af_media_source) END AS media_source
       ,upper(coalesce(t0.platform,t1.platform))                                           AS platform
       ,coalesce(t0.app_name,t1.app_name) as app_name
       ,t0.account_id
       ,t0.account_name
       ,t0.campaign_id
       ,t0.campaign_name
       ,t0.ad_group_id
       ,t0.ad_group_name
       ,t0.ad_id
       ,t0.ad_name
       ,t1.country_code                                           AS country_code
       ,coalesce(t0.finest_ad_class_id,t1.finest_ad_class_id)                                AS finest_ad_class_id
--广告数据
       ,CASE WHEN t0.ad_media_source is null THEN 'NOT_FROM_AD'  ELSE t0.ad_media_source END AS ad_media_source
--AF数据
       ,CASE WHEN t1.af_media_source is null THEN 'NOT_FROM_AF'  ELSE t1.af_media_source END AS af_media_source
--补全的平台数据
       ,t0.spend
       ,t0.impressions
       ,t0.clicks
       ,t0.ad_conversions
       ,t1.install_cnt
       ,t1.new_user_cnt
       ,t1.d0_active_cnt
       ,t1.d1_retention_cnt
       ,t1.lt7_cnt
FROM ad AS t0
FULL JOIN install_retention_aggregate AS t1
ON t0.finest_ad_class_id = t1.finest_ad_class_id  AND t0.dt = t1.dt and t0.country_code=t1.country_code and coalesce(t0.app_name,'')=coalesce(t1.app_name,'')
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
