begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d (
     dt,

    --user info
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,

    collage_server_complete_task_cnt,
    collage_server_complete_user_cnt
    )
    SELECT
      dt,

    --user info
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,

    collage_server_complete_task_cnt,
    collage_server_complete_user_cnt

    FROM favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d_function(dt_param);
end