begin
    DELETE FROM favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d (
        dt
        --User Info
        ,platform
        ,app_version
        ,country_name
        ,user_login_type
        ,user_tenure_type
        ,user_group
        ,device_id

        --event info      
        ,refer
        ,ap_name
        ,event_name
        ,event_method
        ,event_action_type
        ,event_source

        --feed info
        ,item_type
        ,item_intention
        ,feed_source

        --home
        ,home_pv_cnt
        ,home_device_id

        --feed item list
        ,feed_item_list_pv_cnt
        ,feed_item_list_device_id

        --feed item view
        ,feed_item_view_pv_cnt
        ,feed_item_view_device_id

        --feed click
        ,feed_item_click_cnt
        ,feed_item_click_device_id

        --feed detail
        ,feed_detail_click_cnt
        ,feed_item_tryon_click_cnt
        ,feed_item_remix_click_cnt
        ,feed_item_save_share_click_cnt
        ,feed_item_product_click_cnt     
        ,feed_item_detail_pv_cnt
        ,feed_item_detail_click_device_id

        --product detail
        ,feed_product_detail_click_cnt
        ,feed_product_detail_pv_cnt
        ,feed_product_detail_device_id
    )
    SELECT
        dt
        --User Info
        ,platform
        ,app_version
        ,country_name
        ,user_login_type
        ,user_tenure_type
        ,user_group
        ,device_id

        --event info      
        ,refer
        ,ap_name
        ,event_name
        ,event_method
        ,event_action_type
        ,event_source

        --feed info
        ,item_type
        ,item_intention
        ,feed_source

        --home
        ,home_pv_cnt
        ,home_device_id

        --feed item list
        ,feed_item_list_pv_cnt
        ,feed_item_list_device_id

        --feed item view
        ,feed_item_view_pv_cnt
        ,feed_item_view_device_id

        --feed click
        ,feed_item_click_cnt
        ,feed_item_click_device_id

        --feed detail
        ,feed_detail_click_cnt
        ,feed_item_tryon_click_cnt
        ,feed_item_remix_click_cnt
        ,feed_item_save_share_click_cnt
        ,feed_item_product_click_cnt     
        ,feed_item_detail_pv_cnt
        ,feed_item_detail_click_device_id

        --product detail
        ,feed_product_detail_click_cnt
        ,feed_product_detail_pv_cnt
        ,feed_product_detail_device_id
    FROM favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d_function(
        dt_param
    );   
END