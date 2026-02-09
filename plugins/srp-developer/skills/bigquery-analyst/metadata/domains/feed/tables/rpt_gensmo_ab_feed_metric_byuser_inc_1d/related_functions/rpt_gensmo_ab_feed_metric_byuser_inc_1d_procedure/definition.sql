BEGIN
    DELETE FROM `favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d`
    WHERE dt IS NOT NULL AND dt = dt_param;

    INSERT INTO `favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d`(
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        refer,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        user_feed_stay_interval,
        user_feed_true_view,
        user_content_consumption,
        user_ctr
    )
    SELECT
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        refer,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        user_feed_stay_interval,
        user_feed_true_view,
        user_content_consumption,
        user_ctr
    FROM `favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d_function`(dt_param);
END