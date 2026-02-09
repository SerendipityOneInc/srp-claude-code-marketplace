# dws_gem_growth_ad_skan_and_classic_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2026-01-21
**最后更新**: 2026-01-21

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
with  device_metrics as (
SELECT
 	dt,
    device_id,
    appsflyer_id,
    Date(user_created_at) as created_at,
	'US' as country_code,
    1 as is_d0_active,
	'NOT_FROM_AF' as app_platform,
    IF(CAST(dt + INTERVAL 1 DAY AS DATE) IN UNNEST(active_dates), 1, 0) AS is_d1_active,
    case when CURRENT_DATE() > DATE_ADD(dt, INTERVAL 6 DAY) then  ARRAY_LENGTH(ARRAY(	SELECT date_value	FROM UNNEST(active_dates) AS date_value	WHERE date_value BETWEEN CAST(dt AS DATE) AND CAST(dt + INTERVAL 6 DAY AS DATE)))  else 0 end as lt7
FROM
    favie_dw.dws_gensmo_user_forward_tracking_inc_1d
	--这里只拿创建用户等于dt_param的用户
	where dt = dt_param
	and dt<=DATE_ADD(dt_param, INTERVAL 3 DAY)
	and Date(user_created_at)=dt_param
),



af_id_metrics as (
select 
dt,
appsflyer_id,
count(distinct device_id) as device_id_cnt,
max(created_at) as created_at,
max(country_code) as country_code,
max(is_d0_active) as is_d0_active,
max(app_platform) as app_platform ,
max(is_d1_active) as is_d1_active,
max(lt7) as lt7,

from  device_metrics
    group by dt,
appsflyer_id),




af_data as (
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
FROM `favie_dw.dwd_all_app_total_appsflyer_webhook_inc_1d_view`
WHERE dt = dt_param
AND app_name = 'Gensmo'
AND channel != 'SKAN'
AND event_name = 'install'

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
       --,COUNT(distinct device_id) AS new_user_cnt
       ,sum(device_id_cnt) as new_user_cnt
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
	      ,b.device_id_cnt
	FROM af_data AS a
	FULL JOIN af_id_metrics b
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
	FROM `favie_dw.dwd_all_app_total_appsflyer_webhook_inc_1d_view`
	WHERE dt = dt_param
	AND app_name = 'Gensmo'
	AND channel = 'SKAN'
	AND event_name = 'install'
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
	--这里算出来的数据 是把skan-ad +剩下的 organic(被减去了skan-ad) 的数据
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
--最终的数据
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
       ,max(ad_name) as ad_name
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
       
	   ,ad_category
       ,attribution_method
) ,
ad_data as (

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
AND app_name = 'Gensmo'
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
),

final_google_ads_data as (


	
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
,coalesce(b.attribution_method,'BOTH')  as attribution_method
,a.account_put_type
,a.account_open_agency
,coalesce(a.impression,0) as impression
,coalesce(a.click,0) as click
,coalesce(a.conversion,0) as conversion
,coalesce(a.cost,0) as cost
,coalesce(weight*b.install_cnt,0) as install_cnt
,coalesce(weight*b.new_user_cnt,0) as new_user_cnt
,coalesce(weight*b.d0_active_cnt,0) as d0_active_cnt
,coalesce(weight*b.d1_retention_cnt,0) as d1_retention_cnt
,coalesce(weight*b.lt7_cnt,0) as lt7_cnt
,a.weight

from (
	
	select *,
	case when sum(conversion) over (partition by  dt,ad_id )  != 0 then coalesce(safe_divide(conversion, sum(conversion) over (partition by  dt,ad_id ) )  ,1) 
	else coalesce(safe_divide(cost, sum(cost) over (partition by  dt,ad_id ) )  ,1) end as weight
	from ad_data where source = 'Google Ads'

) a
full  join (select * from skan_and_classic_data where source = 'Google Ads'
) b
ON coalesce(a.campaign_id, '') = coalesce(b.campaign_id, '') AND coalesce(a.ad_group_id, '') = coalesce(b.ad_group_id, '')
)

,
other_source_data  as (
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
,coalesce(b.attribution_method,'BOTH')  as attribution_method
,a.account_put_type
,a.account_open_agency
,coalesce(a.impression,0) as impression
,coalesce(a.click,0) as click
,coalesce(a.conversion,0) as conversion
,coalesce(a.cost,0) as cost
,coalesce(b.install_cnt,0)  as install_cnt
,coalesce(b.new_user_cnt,0) as  new_user_cnt
,coalesce(b.d0_active_cnt,0) as  d0_active_cnt
,coalesce(b.d1_retention_cnt,0) as  d1_retention_cnt
,coalesce(b.lt7_cnt,0) as lt7_cnt

from (select * from ad_data where source != 'Google Ads') a
full  join (select * from skan_and_classic_data where source != 'Google Ads') b
ON coalesce(a.campaign_id, '') = coalesce(b.campaign_id, '') AND coalesce(a.ad_group_id, '') = coalesce(b.ad_group_id, '') AND coalesce(a.ad_id, '') = coalesce(b.ad_id, '') AND a.dt = b.dt 

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
,'US' as country_code
,channel
,attribution_method
,account_put_type
,account_open_agency
,impression
,click
,conversion
,cost
,install_cnt
,new_user_cnt
,d0_active_cnt
,d1_retention_cnt
,lt7_cnt
from final_google_ads_data 
union all 
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
,'US' as country_code
,channel
,attribution_method
,account_put_type
,account_open_agency
,impression
,click
,conversion
,cost
,install_cnt
,new_user_cnt
,d0_active_cnt
,d1_retention_cnt
,lt7_cnt
 from other_source_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
