CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_metric_view`
AS select 
        dt,
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

        sum(if(refer = 'subscribe_view', refer_pv_cnt, 0)) as deco_subscription_intension_cnt,
        count(distinct if(refer = 'subscribe_view', user_id, null)) as deco_subscription_intension_user_cnt,
        sum(if(event_action_type = 'deco_gen_trigger', refer_ap_click_cnt, 0)) as deco_gen_trigger_cnt,
        count(distinct if(event_action_type = 'deco_gen_trigger', user_id, null)) as deco_gen_trigger_user_cnt,
        sum(if(ap_name = 'ap_deco_result', refer_view_item_list_cnt, 0)) as deco_gen_complete_cnt,
        count(distinct if(ap_name = 'ap_deco_result' and refer_view_item_list_cnt>0, user_id, null)) as deco_gen_complete_user_cnt
    from favie_dw.dws_decofy_refer_metrics_inc_1d
    where dt is not null
    group by 
        dt, platform, app_version, 
        country_name, user_group, user_login_type, 
        user_tenure_type, ad_source, ad_campaign_id, ad_group_id, ad_id;