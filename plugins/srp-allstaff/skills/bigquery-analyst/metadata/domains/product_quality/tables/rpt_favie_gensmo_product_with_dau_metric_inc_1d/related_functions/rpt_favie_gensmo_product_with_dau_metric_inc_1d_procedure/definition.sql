begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入目标日期数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        product_external_jump_click_cnt,
        product_external_jump_click_user_cnt,
        product_detail_pv_cnt,
        product_detail_user_cnt
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        product_external_jump_click_cnt,
        product_external_jump_click_user_cnt,
        product_detail_pv_cnt,
        product_detail_user_cnt
    FROM favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d_function(
        dt_param
    );                    
END