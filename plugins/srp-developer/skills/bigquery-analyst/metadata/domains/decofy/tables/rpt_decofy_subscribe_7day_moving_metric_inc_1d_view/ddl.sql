CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_7day_moving_metric_inc_1d_view`
AS SELECT
	dt,
	country_name,
	platform,
	app_version,
	user_group,
	ad_source,
	ad_id,
	ad_group_id,
	ad_campaign_id,
	product_id,
	simple_product_id,
	order_category,
	order_type,
	subscribe_trigger_source,
	AVG(subscribe_trigger_cnt) OVER w AS subscribe_trigger_cnt_7d_avg,
	AVG(subscribe_first_order_cnt) OVER w AS subscribe_first_order_cnt_7d_avg
FROM favie_dw.dws_decofy_subscribe_process_metric_inc_1d
where dt is not null
WINDOW w AS (
	PARTITION BY
		country_name,
		platform,
		app_version,
		user_group,
		ad_source,
		ad_id,
		ad_group_id,
		ad_campaign_id,
		product_id,
		simple_product_id,
		order_category,
		order_type,
		subscribe_trigger_source
	ORDER BY dt
	ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
);