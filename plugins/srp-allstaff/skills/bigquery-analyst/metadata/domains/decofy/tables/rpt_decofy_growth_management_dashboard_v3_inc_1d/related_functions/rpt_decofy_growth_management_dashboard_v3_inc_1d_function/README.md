# rpt_decofy_growth_management_dashboard_v3_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v3_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-04
**最后更新**: 2025-09-04

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| inc_dt | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with order_full_data as (
SELECT  Date(order_created_at)                                         AS order_created_at
       ,Date(subscription_created_at)                                  AS subscription_created_at
       ,user_id
       ,CASE WHEN coalesce(order_paid_amount,0) > 0 AND order_subscription_seq = 1 AND product_first_order_price != product_price THEN 'BENEFIT'
             WHEN coalesce(order_paid_amount,0) = 0 AND order_subscription_seq = 1 THEN 'TRIAL'
             WHEN coalesce(order_paid_amount,0) > 0 AND order_subscription_seq = 1 AND product_first_order_price = product_price THEN 'NORMAL'  ELSE null END AS first_order_type
       ,CASE WHEN order_subscription_seq = 1 THEN product_first_order_price
             WHEN order_subscription_seq != 1 THEN product_price END   AS real_order_paid_amount
       ,CASE WHEN coalesce(order_paid_amount,0) > 0 THEN 1  ELSE 0 END AS is_paid_order
       ,appsflyer_id
       ,order_id
       ,subscription_id
       ,subscription_seq
       ,order_subscription_seq
       ,order_category
       ,product_id
       ,product_price
       ,product_first_order_price
       ,order_type
       ,product_period
       ,'Decofy'                                                       AS app_name
       ,'NOT_FROM_AF'                                                  AS source
       ,'NOT_FROM_AF'                                                  AS channel
       ,'NOT_FROM_AF'                                                  AS event_name
       ,'NOT_FROM_AF'                                                  AS campaign_name
       ,'NOT_FROM_AF'                                                  AS campaign_id
       ,'NOT_FROM_AF'                                                  AS ad_group_name
       ,'NOT_FROM_AF'                                                  AS ad_group_id
       ,'NOT_FROM_AF'                                                  AS ad_id
       ,'NOT_FROM_AF'                                                  AS ad_name
       ,'NOT_FROM_AF'                                                  AS account_name
       ,'NOT_FROM_AF'                                                  AS account_id
FROM
(
	SELECT  *
	FROM `favie_dw.dwd_favie_decofy_subscription_order_full_1d`
	WHERE dt = (
	SELECT  MAX(dt)
	FROM `favie_dw.dwd_favie_decofy_subscription_order_full_1d` )
) a
),



full_user as (
SELECT  a.user_id
       ,coalesce(a.appsflyer_id,b.appsflyer_id)   AS appsflyer_id
       ,a.created_at                              AS user_created_at
       ,b.order_id
       ,b.subscription_id
       ,b.subscription_seq
       ,b.order_subscription_seq
       ,b.order_category
       ,b.order_created_at
       ,b.subscription_created_at
       ,b.product_id
       ,b.product_price
       ,b.product_first_order_price
       ,b.order_type
       ,b.product_period
       ,b.first_order_type
       ,b.real_order_paid_amount
       ,b.is_paid_order
       ,'US'                                      AS country_code
       ,'IOS'                                     AS platform
       ,coalesce(b.app_name,a.app_name)           AS app_name
       ,coalesce(b.source,a.source)               AS source
       ,coalesce(b.channel,a.channel)             AS channel
       ,coalesce(b.event_name,a.event_name)       AS event_name
       ,coalesce(b.account_name,a.account_name)   AS account_name
       ,coalesce(b.account_id,a.account_id)       AS account_id
       ,coalesce(b.campaign_name,a.campaign_name) AS campaign_name
       ,coalesce(b.campaign_id,a.campaign_id)     AS campaign_id
       ,coalesce(b.ad_group_name,a.ad_group_name) AS ad_group_name
       ,coalesce(b.ad_group_id,a.ad_group_id)     AS ad_group_id
       ,coalesce(b.ad_id,a.ad_id)                 AS ad_id
       ,coalesce(b.ad_name,a.ad_name)             AS ad_name
FROM
(
	SELECT  user_id
	       ,appsflyer_id
	       ,datetime(created_at) AS created_at
	       ,'Decofy'             AS app_name
	       ,'NOT_FROM_AF'        AS source
	       ,'NOT_FROM_AF'        AS channel
	       ,'NOT_FROM_AF'        AS event_name
	       ,'NOT_FROM_AF'        AS campaign_name
	       ,'NOT_FROM_AF'        AS campaign_id
	       ,'NOT_FROM_AF'        AS ad_group_name
	       ,'NOT_FROM_AF'        AS ad_group_id
	       ,'NOT_FROM_AF'        AS ad_id
	       ,'NOT_FROM_AF'        AS ad_name
	       ,'NOT_FROM_AF'        AS account_name
	       ,'NOT_FROM_AF'        AS account_id
	FROM `favie_dw.dim_favie_decofy_user_account_changelog_1d`
	WHERE user_id IS NOT NULL 
)a
LEFT JOIN order_full_data b
ON a.user_id = b.user_id
),

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
	,install_time
	,ad_category
FROM `favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view`
WHERE 
dt = inc_dt AND 
app_name = 'Decofy' 
),


af_join_full_user_with_order_data as (
--订单数据,给订单打标签
      SELECT  dt
       ,order_user_id
       ,af_appsflyer_id
       ,user_created_at
       ,order_id
       ,subscription_id
       ,subscription_seq
       ,order_subscription_seq
       ,order_category
       ,order_created_at
       ,subscription_created_at
       ,product_id
       ,product_price
       ,product_first_order_price
       ,order_type
       ,product_period
       ,first_order_type
       ,real_order_paid_amount
       ,is_paid_order
       ,app_name
       ,account_name
       ,account_id
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
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 THEN real_order_paid_amount  ELSE 0 END AS real_order_paid_amount_7d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 30 THEN real_order_paid_amount  ELSE 0 END AS real_order_paid_amount_30d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 AND order_subscription_seq = 1 THEN 1  ELSE 0 END AS is_first_order_7d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 AND order_subscription_seq = 1 AND first_order_type = 'BENEFIT' AND product_period = 7 THEN 1  ELSE 0 END AS is_attribution_7d_benefit_order_7d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 AND order_subscription_seq = 1 AND first_order_type = 'TRIAL' AND product_period = 7 THEN 1  ELSE 0 END AS is_attribution_7d_trail_order_7d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 AND order_subscription_seq = 1 AND first_order_type = 'NORMAL' AND product_period = 7 THEN 1  ELSE 0 END AS is_attribution_7d_normal_order_7d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 AND order_subscription_seq = 1 AND first_order_type = 'BENEFIT' AND product_period = 365 THEN 1  ELSE 0 END AS is_attribution_365d_benefit_order_7d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 AND order_subscription_seq = 1 AND first_order_type = 'TRIAL' AND product_period = 365 THEN 1  ELSE 0 END AS is_attribution_365d_trail_order_7d
       ,CASE WHEN date_diff(Date(order_created_at),dt,DAY) >= 0 AND date_diff(Date(order_created_at),dt,DAY) <= 7 AND order_subscription_seq = 1 AND first_order_type = 'NORMAL' AND product_period = 365 THEN 1  ELSE 0 END AS is_attribution_365d_normal_order_7d
FROM
(
	SELECT  --如果订单不归属于af, 就归属于用户创建时间,对于用户创建时间来说,也有归因周期
              b.dt as dt
	       ,a.user_id                                                                          AS order_user_id
	       ,b.appsflyer_id                                                                     AS af_appsflyer_id
	       ,a.user_created_at
	       ,a.order_id
	       ,a.subscription_id
	       ,a.subscription_seq
	       ,a.order_subscription_seq
	       ,a.order_category
	       ,a.order_created_at
	       ,a.subscription_created_at
	       ,a.product_id
	       ,a.product_price
	       ,a.product_first_order_price
	       ,a.order_type
	       ,a.product_period
	       ,a.first_order_type
	       ,a.real_order_paid_amount
	       ,a.is_paid_order
	       ,coalesce(b.app_name,a.app_name)                                                    AS app_name
	       ,coalesce(b.source,a.source)                                                        AS source
	       ,coalesce(b.channel,a.channel)                                                      AS channel
	       ,coalesce(b.platform,a.platform)                                                    AS platform
	       ,coalesce(b.event_name,a.event_name)                                                AS event_name
	       ,coalesce(b.account_name,a.account_name)                                            AS account_name
	       ,coalesce(b.account_id,a.account_id)                                                AS account_id
	       ,coalesce(b.campaign_name,a.campaign_name)                                          AS campaign_name
	       ,coalesce(b.campaign_id,a.campaign_id)                                              AS campaign_id
	       ,coalesce(b.ad_group_name,a.ad_group_name)                                          AS ad_group_name
	       ,coalesce(b.ad_group_id,a.ad_group_id)                                              AS ad_group_id
	       ,coalesce(b.ad_id,a.ad_id)                                                          AS ad_id
	       ,coalesce(b.ad_name,a.ad_name)                                                      AS ad_name
	       ,coalesce(b.country_code,a.country_code)                                            AS country_code
              
	FROM full_user a
	right JOIN af_data b
	ON a.appsflyer_id = b.appsflyer_id
)t1
-- where dt=inc_dt
),



user_with_ad as (
--用户粒度,在用户粒度上聚合
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
       ,af_appsflyer_id
       ,order_user_id
       ,SUM(real_order_paid_amount_7d)                               AS real_order_paid_amount_7d
       ,SUM(real_order_paid_amount_30d)                               AS real_order_paid_amount_30d
       ,SUM(is_first_order_7d)                                          AS is_first_order_7d--有多少个第一次订阅
       ,count(distinct order_id) as order_cnt--有多少个订单
       ,count(distinct case when is_paid_order = 1 then order_id else null end) as paid_order_cnt--有多少个付费订单
       ,sum(is_attribution_7d_benefit_order_7d) as attribution_7d_benefit_order_7d--在7天归因周期里有多少个7天benefit订单
       ,sum(is_attribution_7d_trail_order_7d) as attribution_7d_trail_order_7d--在7天归因周期里有多少个7天trail订单
       ,sum(is_attribution_7d_normal_order_7d) as attribution_7d_normal_order_7d--在7天归因周期里有多少个7天normal订单
       ,sum(is_attribution_365d_benefit_order_7d) as attribution_365d_benefit_order_7d--在7天归因周期里有多少个365天benefit订单
       ,sum(is_attribution_365d_trail_order_7d) as attribution_365d_trail_order_7d--在7天归因周期里有多少个365天trail订单
       ,sum(is_attribution_365d_normal_order_7d) as attribution_365d_normal_order_7d--在7天归因周期里有多少个365天normal订单
FROM af_join_full_user_with_order_data

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
       ,country_code
       ,af_appsflyer_id
       ,order_user_id
)
,
ad_with_order_data as (SELECT  dt
       ,app_name
       ,source
       ,channel
       ,platform
       ,event_name
       ,campaign_name
       ,campaign_id
       ,account_name
       ,account_id
       ,ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
       ,MAX(country_code)                                   AS country_code
       ,COUNT(distinct af_appsflyer_id)                     AS install_cnt
       ,COUNT(distinct order_user_id)                       AS user_cnt
       ,SUM(real_order_paid_amount_7d)                      AS real_order_paid_amount_7d
       ,SUM(real_order_paid_amount_30d)                     AS real_order_paid_amount_30d
       ,SUM(is_first_order_7d)                              AS is_first_order_7d --有多少个订阅
       ,SUM(order_cnt)                                      AS order_cnt --有多少个订单
       ,sum (paid_order_cnt)                                AS paid_order_cnt --有多少个付费订单
       ,SUM(case WHEN order_cnt > 0 THEN 1 else 0 end)      AS subscribed_user --有多少个用户
       ,SUM(case WHEN paid_order_cnt > 0 THEN 1 else 0 end) AS paid_user -- 有多少个付费用户
       ,SUM(attribution_7d_benefit_order_7d)                AS attribution_7d_benefit_order_7d --在7天归因周期里有多少个7天benefit订单
       ,SUM(attribution_7d_trail_order_7d)                  AS attribution_7d_trail_order_7d --在7天归因周期里有多少个7天trail订单
       ,SUM(attribution_7d_normal_order_7d)                 AS attribution_7d_normal_order_7d --在7天归因周期里有多少个7天normal订单
       ,SUM(attribution_365d_benefit_order_7d)              AS attribution_365d_benefit_order_7d --在7天归因周期里有多少个365天benefit订单
       ,SUM(attribution_365d_trail_order_7d)                AS attribution_365d_trail_order_7d --在7天归因周期里有多少个365天trail订单
       ,SUM(attribution_365d_normal_order_7d)               AS attribution_365d_normal_order_7d --在7天归因周期里有多少个365天normal订单
FROM user_with_ad
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
       where 
       dt=inc_dt and 
       app_name='Decofy'
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
,coalesce(a.account_id,b.account_id) as account_id
,coalesce(a.account_name,b.account_name) as account_name
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
,coalesce(real_order_paid_amount_7d,0) as real_order_paid_amount_7d
,coalesce(real_order_paid_amount_30d,0) as real_order_paid_amount_30d
,coalesce(is_first_order_7d,0) as is_first_order_7d --有多少个订阅
,coalesce(order_cnt,0) as order_cnt --有多少个订单
,coalesce(paid_order_cnt,0) as paid_order_cnt --有多少个付费订单
,coalesce(subscribed_user,0) as subscribed_user --有多少个用户
,coalesce(paid_user,0) as paid_user --有多少个付费用户
,coalesce(attribution_7d_benefit_order_7d,0) as attribution_7d_benefit_order_7d --在7天归因周期里有多少个7天benefit订单
,coalesce(attribution_7d_trail_order_7d,0) as attribution_7d_trail_order_7d --在7天归因周期里有多少个7天trail订单
,coalesce(attribution_7d_normal_order_7d,0) as attribution_7d_normal_order_7d --在7天归因周期里有多少个7天normal订单
,coalesce(attribution_365d_benefit_order_7d,0) as attribution_365d_benefit_order_7d --在7天归因周期里有多少个365天benefit订
,coalesce(attribution_365d_trail_order_7d,0) as attribution_365d_trail_order_7d --在7天归因周期里有多少个365天trail订单
,coalesce(attribution_365d_normal_order_7d,0) as attribution_365d_normal_order_7d --在7天归因周期里有多少个365天normal订单

from ad_data a
full  join ad_with_order_data b
ON coalesce(a.campaign_id, '') = coalesce(b.campaign_id, '') AND coalesce(a.ad_group_id, '') = coalesce(b.ad_group_id, '') AND coalesce(a.ad_id, '') = coalesce(b.ad_id, '') and a.dt=b.dt
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
