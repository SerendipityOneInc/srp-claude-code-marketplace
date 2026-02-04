BEGIN
    -- 删除目标日期的现有数据
    DELETE FROM favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d
    (
        user_id,
        device_id,
        appsflyer_id,
        dt
    )
    SELECT
        user_id,
        device_id,
        appsflyer_id,
        dt
    FROM favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d_function(dt_param);
    call favie_dw.record_partition('favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d', dt_param,"");
END