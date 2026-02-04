begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_save_metric_inc_1d
    WHERE dt is not null and dt = dt_param;      

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_save_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        --event info      
        refer,
        cal_pre_refer,
        ap_name,
        event_name,
        event_method,
        event_source,
        event_action_type,

        --feed info
        item_type,
        item_intention,

        --total
        total_save_click_cnt,
        total_save_click_device_id,

        --feed detail
        feed_detail_device_id,
        feed_detail_save_click_cnt,
        feed_detail_save_click_device_id,
        feed_item_similar_save_click_cnt,
        feed_item_similar_save_click_device_id,
        feed_item_tryon_save_click_cnt,
        feed_item_tryon_save_click_device_id,
        feed_item_general_save_click_cnt,
        feed_item_general_save_click_device_id,
        feed_item_product_save_click_cnt,
        feed_item_product_save_click_device_id,
        feed_item_styling_save_click_cnt,
        feed_item_styling_save_click_device_id,

        --try on gen
        tryon_gen_device_id,
        tryon_gen_save_click_cnt,
        tryon_gen_save_click_device_id,

        --product detail
        product_detail_save_click_cnt,
        product_detail_save_click_device_id,

        --product detail from search
        product_detail_from_search_save_click_cnt,
        product_detail_from_search_save_click_device_id,

        --full screen pic
        full_screen_pic_save_click_cnt, 
        full_screen_pic_save_click_device_id,

        --collage gen
        collage_gen_device_id,
        collage_gen_save_click_cnt,
        collage_gen_save_click_device_id
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        --event info      
        refer,
        cal_pre_refer,
        ap_name,
        event_name,
        event_method,
        event_source,
        event_action_type,

        --feed info
        item_type,
        item_intention,

        --total
        total_save_click_cnt,
        total_save_click_device_id,

        --feed detail
        feed_detail_device_id,
        feed_detail_save_click_cnt,
        feed_detail_save_click_device_id,
        feed_item_similar_save_click_cnt,
        feed_item_similar_save_click_device_id,
        feed_item_tryon_save_click_cnt,
        feed_item_tryon_save_click_device_id,
        feed_item_general_save_click_cnt,
        feed_item_general_save_click_device_id,
        feed_item_product_save_click_cnt,
        feed_item_product_save_click_device_id,
        feed_item_styling_save_click_cnt,
        feed_item_styling_save_click_device_id,

        --try on gen
        tryon_gen_device_id,
        tryon_gen_save_click_cnt,
        tryon_gen_save_click_device_id,

        --product detail
        product_detail_save_click_cnt,
        product_detail_save_click_device_id,

        --product detail from search
        product_detail_from_search_save_click_cnt,
        product_detail_from_search_save_click_device_id,

        --full screen pic
        full_screen_pic_save_click_cnt, 
        full_screen_pic_save_click_device_id,

        --collage gen
        collage_gen_device_id,
        collage_gen_save_click_cnt,
        collage_gen_save_click_device_id
    FROM favie_rpt.rpt_favie_gensmo_save_metric_inc_1d_function(dt_param);   

end