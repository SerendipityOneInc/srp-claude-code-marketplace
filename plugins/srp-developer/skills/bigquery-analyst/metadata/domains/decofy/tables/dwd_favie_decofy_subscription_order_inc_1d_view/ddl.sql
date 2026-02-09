CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_inc_1d_view`
AS select 
		Date(order_created_at) as dt
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
        ,dt as full_dt
		from srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d
		where dt=(select max(dt) from srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d where dt is not null);