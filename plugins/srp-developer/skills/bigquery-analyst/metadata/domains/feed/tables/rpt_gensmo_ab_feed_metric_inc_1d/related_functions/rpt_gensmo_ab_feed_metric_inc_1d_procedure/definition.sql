BEGIN
    DELETE FROM `favie_rpt.rpt_gensmo_ab_feed_metric_inc_1d`
    WHERE dt IS NOT NULL AND dt = dt_param;

    INSERT INTO `favie_rpt.rpt_gensmo_ab_feed_metric_inc_1d`(
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        refer,

        content_consumption_pv_cnt,
        feed_stay_interval_total_cnt,
        feed_true_view_pv_cnt,

        content_consumption_user_cnt,
        feed_stay_user_cnt,
        feed_true_view_user_cnt
    )
    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        refer,
        content_consumption_pv_cnt,
        feed_stay_interval_total_cnt,
        feed_true_view_pv_cnt,

        content_consumption_user_cnt,
        feed_stay_user_cnt,
        feed_true_view_user_cnt
    FROM `favie_rpt.rpt_gensmo_ab_feed_metric_inc_1d_function`(dt_param);
END