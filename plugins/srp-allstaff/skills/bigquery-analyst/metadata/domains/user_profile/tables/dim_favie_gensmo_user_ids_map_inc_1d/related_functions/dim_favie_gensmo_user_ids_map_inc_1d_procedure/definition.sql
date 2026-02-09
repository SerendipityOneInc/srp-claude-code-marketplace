BEGIN
    -- 删除目标日期的现有数据
    DELETE FROM favie_dw.dim_favie_gensmo_user_ids_map_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dim_favie_gensmo_user_ids_map_inc_1d
    (
        dt,
        user_id,
        device_id,
        appsflyer_id,
        is_internal_user,
        last_timestamp
    )
    SELECT
        dt,
        user_id,
        device_id,
        appsflyer_id,
        is_internal_user,
        last_timestamp
    FROM favie_dw.dim_favie_gensmo_user_ids_map_inc_1d_function(dt_param);
    call favie_dw.record_partition('favie_dw.dim_favie_gensmo_user_ids_map_inc_1d', dt_param,"");
END