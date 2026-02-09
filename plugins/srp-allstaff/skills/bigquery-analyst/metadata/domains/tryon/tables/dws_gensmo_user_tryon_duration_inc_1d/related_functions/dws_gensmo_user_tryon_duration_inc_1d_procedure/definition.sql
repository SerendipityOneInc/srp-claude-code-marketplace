BEGIN
    DELETE FROM `favie_dw.dws_gensmo_user_tryon_duration_inc_1d`
    WHERE dt IS NOT NULL AND dt = dt_param;
    -- Call the function to insert data into the table
    INSERT INTO favie_dw.dws_gensmo_user_tryon_duration_inc_1d (
        dt,
        device_id,
        tryon_complete_interval,
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
        tryon_complete_interval,
        user_group,
        user_tenure_type,
        user_login_type,
        country_name,
        app_version,
        platform
    FROM `favie_dw.dws_gensmo_user_tryon_duration_inc_1d_function`(dt_param);
END