# rpt_decofy_growth_management_dashboard_v2_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v2_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-08-15
**最后更新**: 2025-08-15

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| full_dt | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| inc_dt | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d` (dwd_favie_decofy_subscription_order_full_1d)

---

## 💻 函数定义

```sql
with user_info as (SELECT  user_id
       ,MAX(total_order_paid_amount)      AS total_order_paid_amount
       ,SUM(first_paid_weekly_9990_cnt)   AS first_paid_weekly_9990_cnt
       ,SUM(first_paid_annual_39990_cnt)  AS first_paid_annual_39990_cnt
       ,SUM(first_paid_free_trial_cnt)    AS first_paid_free_trial_cnt
       ,SUM(second_paid_weekly_9990_cnt)  AS second_paid_weekly_9990_cnt
       ,SUM(second_paid_annual_39990_cnt) AS second_paid_annual_39990_cnt
       ,SUM(second_paid_free_trial_cnt)   AS second_paid_free_trial_cnt
FROM
(
	SELECT  dt
	       ,user_id
	       ,order_id
	       ,order_source
	       ,order_paid_amount
	       ,order_paid_currency
	       ,order_created_at
	       ,order_updated_at
	       ,order_deleted_at
	       ,order_category
	       ,order_type
	       
	       
	       
	       ,order_days_to_expire
	       ,product_id
	       ,product_price
	       ,product_currency
	       ,product_with_trial
	       ,subscription_id
	       
	       
	       ,total_order_paid_amount
	       ,real_order_paid_amount
	       ,CASE WHEN rk = 1 THEN order_category  ELSE 'UNKNOWN' END                                                       AS first_order_category
	       ,CASE WHEN rk = 1 THEN order_type  ELSE 'UNKNOWN' END                                                           AS first_order_type
	       ,CASE WHEN rk = 1 THEN real_order_paid_amount  ELSE 0 END                                                       AS first_order_paid_amount
	       ,CASE WHEN coalesce(rk,0) = 2 THEN order_category  ELSE null END                                                AS second_order_category
	       ,CASE WHEN coalesce(rk,0) = 2 THEN order_type  ELSE null END                                                    AS second_order_type
	       ,CASE WHEN coalesce(rk,0) = 2 THEN real_order_paid_amount  ELSE null END                                        AS second_order_paid_amount
	       ,CASE WHEN rk = 1 AND product_id = 'one.srp.decofy.subscription.weekly_9.9' THEN 1  ELSE 0 END                  AS first_paid_weekly_9990_cnt
	       ,CASE WHEN rk = 1 AND product_id = 'one.srp.decofy.subscription.annual_39.99' THEN 1  ELSE 0 END                AS first_paid_annual_39990_cnt
	       ,CASE WHEN rk = 1 AND product_id = 'one.srp.decofy.subscription.weekly_9.9_3days_free_trial' THEN 1  ELSE 0 END AS first_paid_free_trial_cnt
	       ,CASE WHEN rk = 2 AND product_id = 'one.srp.decofy.subscription.weekly_9.9' THEN 1  ELSE 0 END                  AS second_paid_weekly_9990_cnt
	       ,CASE WHEN rk = 2 AND product_id = 'one.srp.decofy.subscription.annual_39.99' THEN 1  ELSE 0 END                AS second_paid_annual_39990_cnt
	       ,CASE WHEN rk = 2 AND product_id = 'one.srp.decofy.subscription.weekly_9.9_3days_free_trial' THEN 1  ELSE 0 END AS second_paid_free_trial_cnt
	       ,rk
	FROM
	(
		SELECT  dt
		       ,user_id
		       ,order_id
		       ,order_source
		       ,order_paid_amount
		       ,order_paid_currency
		       ,order_created_at
		       ,order_updated_at
		       ,order_deleted_at
		       ,order_category
		       ,order_type
		       
		       
		       
		       ,order_days_to_expire
		       ,product_id
		       ,product_price
		       ,product_currency
		       ,product_with_trial
		       ,subscription_id
		       
		       
		       ,CASE WHEN coalesce(order_paid_amount,0.0) > 0 THEN product_price  ELSE 0.0 END                                                                AS real_order_paid_amount
		       ,ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY  order_created_at ASC)                                                                       AS rk
		       ,SUM(case WHEN coalesce(order_paid_amount,0.0) > 0 THEN product_price else 0.0 end ) OVER (PARTITION BY user_id ORDER BY order_created_at ASC) AS total_order_paid_amount
		FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d`
		WHERE dt = (
		SELECT  MAX(dt)
		FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d` ) AND user_id is not null
	)
	WHERE rk <= 2 
)
GROUP BY  user_id
),

order_with_af  as (
--这个表是全量表,拿到af的数据,关联当天产生的af,拿到对应那天的状态信息
--
select
 a.dt
,a.user_id
,a.appsflyer_id
,a.created_at
,a.first_subscription_time
,a.latest_subscription_time
,a.total_subscription_count
,a.first_paid_time
,a.latest_paid_time
,a.total_paid_count
,a.total_paid_amount
,a.current_paid_package
,a.current_paid_expires_time
,a.current_package_price
,a.current_package_currency
,a.first_trial_time
,a.latest_trial_time
,a.total_trial_count
,a.current_trial_expires_time
,a.first_deleted_time
,a.latest_deleted_time
,a.total_deleted_count
,a.subscription_status
,a.days_to_expire
,b.total_order_paid_amount
,b.first_paid_weekly_9990_cnt
,b.first_paid_annual_39990_cnt
,b.first_paid_free_trial_cnt
,b.second_paid_weekly_9990_cnt
,b.second_paid_annual_39990_cnt
,b.second_paid_free_trial_cnt
from `favie_tmp.tmp_rpt_gem_growth_management_dashboard_v2_inc_1d_function`(full_dt) a 
left join user_info b 
on a.user_id = b.user_id

)
,af_data as (
select
       dt
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
from (
SELECT  
       dt
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
       ,ROW_NUMBER() OVER ( PARTITION BY appsflyer_id ORDER BY  CASE WHEN channel = 'ON_LINE' THEN 1 WHEN channel = 'OFF_LINE' THEN 2 else 3 end ,CASE WHEN source NOT IN ('organic','None') THEN 1 WHEN source = 'organic' THEN 2 else 3 end ) AS rn
FROM `favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view`
WHERE  dt=inc_dt and app_name='Decofy'
and appsflyer_id is not null
)
where rn=1
)




,order_af_agg_to_ad as (

SELECT  af_dt                                                                                                                                      AS dt
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
	  
       ,MAX(country_code)                                                                                                                          AS country_code
       ,COUNT(distinct af_appsflyer_id )                                                                                                           AS install_cnt
       ,COUNT(distinct user_id )                                                                                                                   AS user_cnt
       ,SUM( CASE WHEN date_diff(first_subscription_time,af_dt,DAY) >= 0 AND date_diff(first_subscription_time,af_dt,DAY) <= 7 THEN 1 else 0 end ) AS subscription_7d_cnt
       ,SUM( CASE WHEN date_diff(first_subscription_time,af_dt,DAY) >= 0 AND date_diff(first_subscription_time,af_dt,DAY) <= 3 THEN 1 else 0 end ) AS subscription_3d_cnt
       ,SUM( CASE WHEN date_diff(first_subscription_time,af_dt,DAY) >= 0 AND date_diff(first_subscription_time,af_dt,DAY) <= 1 THEN 1 else 0 end ) AS subscription_1d_cnt
       ,SUM( CASE WHEN date_diff(first_subscription_time,af_dt,DAY) >= 0 AND date_diff(first_subscription_time,af_dt,DAY) <= 0 THEN 1 else 0 end ) AS subscription_0d_cnt
       ,SUM( CASE WHEN date_diff(first_paid_time,af_dt,DAY) >= 0 AND date_diff(first_paid_time,af_dt,DAY) <= 7 THEN 1 else 0 end )                 AS paid_7d_cnt
       ,SUM( CASE WHEN date_diff(first_paid_time,af_dt,DAY) >= 0 AND date_diff(first_paid_time,af_dt,DAY) <= 3 THEN 1 else 0 end )                 AS paid_3d_cnt
       ,SUM( CASE WHEN date_diff(first_paid_time,af_dt,DAY) >= 0 AND date_diff(first_paid_time,af_dt,DAY) <= 1 THEN 1 else 0 end )                 AS paid_1d_cnt
       ,SUM( CASE WHEN date_diff(first_paid_time,af_dt,DAY) >= 0 AND date_diff(first_paid_time,af_dt,DAY) <= 0 THEN 1 else 0 end )                 AS paid_0d_cnt
       ,SUM( CASE WHEN date_diff(first_trial_time,af_dt,DAY) >= 0 AND date_diff(first_trial_time,af_dt,DAY) <= 7 THEN 1 else 0 end )               AS trial_7d_cnt
       ,SUM( CASE WHEN date_diff(first_trial_time,af_dt,DAY) >= 0 AND date_diff(first_trial_time,af_dt,DAY) <= 3 THEN 1 else 0 end )               AS trial_3d_cnt
       ,SUM( CASE WHEN date_diff(first_trial_time,af_dt,DAY) >= 0 AND date_diff(first_trial_time,af_dt,DAY) <= 1 THEN 1 else 0 end )               AS trial_1d_cnt
       ,SUM( CASE WHEN date_diff(first_trial_time,af_dt,DAY) >= 0 AND date_diff(first_trial_time,af_dt,DAY) <= 0 THEN 1 else 0 end )               AS trial_0d_cnt
,sum(total_order_paid_amount) as total_order_paid_amount
,sum(first_paid_weekly_9990_cnt) as first_paid_weekly_9990_cnt
,sum(first_paid_annual_39990_cnt) as first_paid_annual_39990_cnt
,sum(first_paid_free_trial_cnt) as first_paid_free_trial_cnt
,sum(second_paid_weekly_9990_cnt) as second_paid_weekly_9990_cnt
,sum(second_paid_annual_39990_cnt) as second_paid_annual_39990_cnt
,sum(second_paid_free_trial_cnt) as second_paid_free_trial_cnt
FROM
(
	SELECT  
	       a.dt                                                         AS af_dt
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
	       ,a.appsflyer_id                                               AS af_appsflyer_id
	       ,b.user_id
	       ,b.appsflyer_id                                               AS order_appsflyer_id
	       ,b.created_at
	       ,coalesce(Date(b.first_subscription_time),Date('1999-01-01')) AS first_subscription_time
	       ,b.latest_subscription_time
	       ,b.total_subscription_count
	       ,coalesce(Date(b.first_paid_time),Date('1999-01-01'))         AS first_paid_time
	       ,b.latest_paid_time
	       ,b.total_paid_count
	       ,b.total_paid_amount
	       ,b.current_paid_package
	       ,b.current_paid_expires_time
	       ,b.current_package_price
	       ,b.current_package_currency
	       ,b.first_trial_time
	       ,b.latest_trial_time
	       ,b.total_trial_count
	       ,b.current_trial_expires_time
	       ,b.first_deleted_time
	       ,b.latest_deleted_time
	       ,b.total_deleted_count
	       ,b.subscription_status
	       ,b.days_to_expire
,total_order_paid_amount
,first_paid_weekly_9990_cnt
,first_paid_annual_39990_cnt
,first_paid_free_trial_cnt
,second_paid_weekly_9990_cnt
,second_paid_annual_39990_cnt
,second_paid_free_trial_cnt
	FROM af_data a
	LEFT JOIN order_with_af b
	ON a.appsflyer_id = b.appsflyer_id
)
GROUP BY  dt
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

)

,
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
	       ,CASE WHEN source = 'Google Ads' THEN null  ELSE ad_id END   AS ad_id
	       ,CASE WHEN source = 'Google Ads' THEN null  ELSE ad_name END AS ad_name
	       ,max(country_code) as country_code 
	       ,sum(impression) as  impression 
	       ,sum(click) as click
	       ,sum(conversion) as conversion 
	       ,sum(cost) as cost 
	FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
       where dt=inc_dt
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
	       ,CASE WHEN source = 'Google Ads' THEN null  ELSE ad_id END   
	       ,CASE WHEN source = 'Google Ads' THEN null  ELSE ad_name END 
	       
)



select 
coalesce(a.dt,b.dt) as dt
,coalesce(a.source,b.source) as source
,Upper(coalesce(a.platform,b.platform)) as platform
,coalesce(a.app_name,b.app_name) as app_name
,account_id
,account_name
,coalesce(a.campaign_id,b.campaign_id) as campaign_id
,coalesce(a.campaign_name,b.campaign_name) as campaign_name
,coalesce(a.ad_group_id,b.ad_group_id) as ad_group_id
,coalesce(a.ad_group_name,b.ad_group_name) as ad_group_name
,coalesce(a.ad_id,b.ad_id) as ad_id
,coalesce(a.ad_name,b.ad_name) as ad_name
,coalesce(a.country_code,b.country_code) as country_code
,b.channel
,coalesce(a.impression,0) as impression
,coalesce(a.click,0) as click
,coalesce(a.conversion,0) as conversion
,coalesce(a.cost,0) as cost
,coalesce(b.install_cnt,0)  as install_cnt
,coalesce(b.user_cnt,0) as user_cnt
,coalesce(b.subscription_7d_cnt,0) as subscription_7d_cnt
,coalesce(b.subscription_3d_cnt,0) as subscription_3d_cnt
,coalesce(b.subscription_1d_cnt,0) as subscription_1d_cnt
,coalesce(b.subscription_0d_cnt,0) as subscription_0d_cnt
,coalesce(b.paid_7d_cnt,0) as paid_7d_cnt
,coalesce(b.paid_3d_cnt,0) as paid_3d_cnt
,coalesce(b.paid_1d_cnt,0) as paid_1d_cnt
,coalesce(b.paid_0d_cnt,0) as paid_0d_cnt
,coalesce(b.trial_7d_cnt,0) as trial_7d_cnt
,coalesce(b.trial_3d_cnt,0) as trial_3d_cnt
,coalesce(b.trial_1d_cnt,0) as trial_1d_cnt
,coalesce(b.trial_0d_cnt,0) as trial_0d_cnt
,coalesce(b.total_order_paid_amount,0) as  total_order_paid_amount
,coalesce(b.first_paid_weekly_9990_cnt,0) as first_paid_weekly_9990_cnt
,coalesce(b.first_paid_annual_39990_cnt,0) as first_paid_annual_39990_cnt
,coalesce(b.first_paid_free_trial_cnt,0) as first_paid_free_trial_cnt
,coalesce(b.second_paid_weekly_9990_cnt,0) as second_paid_weekly_9990_cnt
,coalesce(b.second_paid_annual_39990_cnt,0) as second_paid_annual_39990_cnt
,coalesce(b.second_paid_free_trial_cnt,0) as second_paid_free_trial_cnt
from ad_data a
full  join order_af_agg_to_ad b
ON coalesce(a.campaign_id, '') = coalesce(b.campaign_id, '') AND coalesce(a.ad_group_id, '') = coalesce(b.ad_group_id, '') AND coalesce(a.ad_id, '') = coalesce(b.ad_id, '') and a.dt=b.dt
```

---

**文档生成**: 2026-01-30 13:38:36
**扫描工具**: scan_functions.py
