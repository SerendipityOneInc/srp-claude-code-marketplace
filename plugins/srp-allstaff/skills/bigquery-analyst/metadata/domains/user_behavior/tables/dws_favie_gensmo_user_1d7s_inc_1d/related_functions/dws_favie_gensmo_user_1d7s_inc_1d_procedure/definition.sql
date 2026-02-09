begin
    DELETE FROM favie_dw.dws_favie_gensmo_user_1d7s_inc_1d
    WHERE base_dt is not null and base_dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_user_1d7s_inc_1d (
    base_dt,
    user_login_type,
    platform,
    app_version,
    function_type,
    active_user_cnt,
    revisit_user_cnt
    )
    SELECT
    base_dt,
    user_login_type,
    platform,
    app_version,
    function_type,
    active_user_cnt,
    revisit_user_cnt
    FROM favie_dw.dws_favie_gensmo_user_1d7s_inc_1d_function(
        dt_param
    );   
END