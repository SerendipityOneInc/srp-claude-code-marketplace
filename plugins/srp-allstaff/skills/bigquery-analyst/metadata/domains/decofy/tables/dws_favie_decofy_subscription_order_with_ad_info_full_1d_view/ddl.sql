CREATE VIEW `srpproduct-dc37e.favie_dw.dws_favie_decofy_subscription_order_with_ad_info_full_1d_view`
AS SELECT  	dt
		   ,user_id
		   ,appsflyer_id
		   ,product_id
		   ,simple_product_id
		   ,product_price
		   ,product_first_order_price
		   ,product_currency
		   ,product_with_trial
		   ,product_period
		   ,subscription_id
		   ,subscription_created_at
		   ,subscription_seq
		   ,original_transaction_id
		   ,order_id
		   ,order_source
		   ,order_paid_amount
		   ,order_paid_currency
		   ,order_created_at
		   ,order_updated_at
		   ,order_expires_date
		   ,order_deleted_at
		   ,order_renewal_at
		   ,order_category
		   ,order_type
		   ,order_seq
		   ,order_subscription_seq
		   ,order_days_to_expire
	       ,af_dt
			,app_name
			,source
			,channel
			,af_platform
			,af_event_name
			,ad_category
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
			,af_event_time
			,first_appsflyer_id
		   ,user_created_at
       	   ,ROW_NUMBER() OVER (PARTITION BY dt,user_id ORDER BY  af_event_time ASC) AS af_event_seq
--在这里拿到某一个用户归属于最新的哪一些事件(上一个可能同时归属于多个事件)
FROM
(
	SELECT  dt
		   ,a.user_id
		   ,a.appsflyer_id
		   ,product_id
		   ,simple_product_id
		   ,product_price
		   ,product_first_order_price
		   ,product_currency
		   ,product_with_trial
		   ,product_period
		   ,subscription_id
		   ,subscription_created_at
		   ,subscription_seq
		   ,original_transaction_id
		   ,order_id
		   ,order_source
		   ,order_paid_amount
		   ,order_paid_currency
		   ,order_created_at
		   ,order_updated_at
		   ,order_expires_date
		   ,order_deleted_at
		   ,order_renewal_at
		   ,order_category
		   ,order_type
		   ,order_seq
		   ,order_subscription_seq
		   ,order_days_to_expire
		 	,af_dt
			,app_name
			,source
			,channel
			,af_platform
			,af_event_name
			,ad_category
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
			,af_event_time
			,c.appsflyer_id 	as first_appsflyer_id
		   ,c.created_at 	as user_created_at
	       ,rank() OVER (PARTITION BY a.dt,a.appsflyer_id ORDER BY  date(af_dt) desc , case when af_event_name='re-engagement' then 0 when af_event_name='install' then 1 else 2 end desc,  EXTRACT(HOUR FROM SAFE.PARSE_DATETIME('%Y-%m-%d %H:%M:%E*S', af_event_time)) asc , EXTRACT( MINUTE FROM SAFE.PARSE_DATETIME('%Y-%m-%d %H:%M:%E*S', af_event_time)) asc  ) AS rk
		   
	FROM
	(
		select 
		dt
		,user_id
		,appsflyer_id
		,product_id
		,simple_product_id
		,product_price
		,product_first_order_price
		,product_currency
		,product_with_trial
		,product_period
		,subscription_id
		,subscription_created_at
		,subscription_seq
		,original_transaction_id
		,order_id
		,order_source
		,order_paid_amount
		,order_paid_currency
		,order_created_at
		,order_updated_at
		,order_expires_date
		,order_deleted_at
		,order_renewal_at
		,order_category
		,order_type
		,order_seq
		,order_subscription_seq
		,order_days_to_expire
		,full_dt
		from favie_dw.dwd_favie_decofy_subscription_order_inc_1d_view
		
	) a
	LEFT JOIN
		(
			SELECT  
		dt           AS af_dt
		,app_name
		,source
		,channel
		,platform     AS af_platform
		,event_name   AS af_event_name
		,ad_category
		,account_name
		,account_id
		,campaign_name
		,campaign_id
		,ad_group_name
		,ad_group_id
		,ad_id
		,ad_name
		,country_code
		,appsflyer_id AS af_appsflyer_id
		,install_time AS af_event_time
	FROM `favie_dw.dwd_all_app_appsflyer_webhook_v2_inc_1d_view`
	WHERE app_name = 'Decofy'
	AND channel = 'ON_LINE'
	)b
	ON a.appsflyer_id = b.af_appsflyer_id AND a.dt >= b.af_dt
	left join `favie_dw.dim_favie_decofy_user_account_changelog_1d` c 
	on a.user_id = c.user_id
) t1
WHERE rk = 1;