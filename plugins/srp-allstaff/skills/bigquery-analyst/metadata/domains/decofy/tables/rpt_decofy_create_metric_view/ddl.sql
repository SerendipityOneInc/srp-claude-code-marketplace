CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_create_metric_view`
AS SELECT
		dt,
		user_id,
		platform,
		app_version,
		country_name,
		user_group,
		user_login_type,
		user_tenure_type,
		ad_source,
		ad_campaign_id,
		ad_group_id,
		ad_id,
		SUM(IF(event_action_type = 'deco_start', refer_ap_click_cnt, 0)) AS deco_gen_intension_cnt,
		max(DISTINCT IF(event_action_type = 'deco_start', user_id, NULL)) AS deco_gen_intension_user_id,
		SUM(IF(event_action_type = 'deco_gen_trigger', refer_ap_click_cnt, 0)) AS deco_gen_trigger_cnt,
		max(DISTINCT IF(event_action_type = 'deco_gen_trigger', user_id, NULL)) AS deco_gen_trigger_user_id,
		SUM(IF(event_action_type = 'deco_gen', refer_ap_click_cnt, 0)) AS deco_gen_cnt,
		max(DISTINCT IF(event_action_type = 'deco_gen', user_id, NULL)) AS deco_gen_user_id,
		SUM(IF(refer = 'chat' AND ap_name = 'ap_deco_result', refer_view_item_list_cnt, 0)) AS deco_gen_complete_cnt,
		max(DISTINCT IF(refer = 'chat' AND ap_name = 'ap_deco_result' AND refer_view_item_list_cnt > 0, user_id, NULL)) AS deco_gen_complete_user_id
	FROM favie_dw.dws_decofy_refer_metrics_inc_1d
	WHERE dt IS NOT NULL
	GROUP BY
		dt,
		user_id,
		platform,
		app_version,
		country_name,
		user_group,
		user_login_type,
		user_tenure_type,
		ad_source,
		ad_campaign_id,
		ad_group_id,
		ad_id;