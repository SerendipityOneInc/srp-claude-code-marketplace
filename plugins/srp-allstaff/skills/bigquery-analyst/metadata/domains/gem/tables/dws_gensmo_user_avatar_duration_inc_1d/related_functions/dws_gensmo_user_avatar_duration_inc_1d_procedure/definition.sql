BEGIN
    DELETE FROM `favie_dw.dws_gensmo_user_avatar_duration_inc_1d`
    WHERE dt IS NOT NULL AND dt = dt_param;

    INSERT INTO `favie_dw.dws_gensmo_user_avatar_duration_inc_1d`
    (
        dt,
        device_id,
        avatar_task_interval,
        user_group,
        user_tenure_type,
        user_login_type,
        country_name,
        app_version,
        platform
    )
    SELECT
        dt,
        device_id,
        avatar_task_interval,
        user_group,
        user_tenure_type,
        user_login_type,
        country_name,
        app_version,
        platform
    FROM
        `favie_dw.dws_gensmo_user_avatar_duration_inc_1d_function`(dt_param);
END