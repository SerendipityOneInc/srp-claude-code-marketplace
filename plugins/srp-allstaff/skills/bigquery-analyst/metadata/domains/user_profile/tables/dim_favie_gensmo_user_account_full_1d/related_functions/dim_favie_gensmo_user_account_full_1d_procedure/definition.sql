BEGIN
    -- 删除目标分区的数据
    DELETE FROM favie_dw.dim_favie_gensmo_user_account_full_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dim_favie_gensmo_user_account_full_1d (
        dt,
        user_id,
        user_name,
        user_email,
        user_phone,
        user_type,
        last_device_id,
        device_ids,
        first_device_id,
        updated_at,
        created_at,
        is_internal_user,
        is_bot_user
    )
    SELECT
        dt,
        user_id,
        user_name,
        user_email,
        user_phone,
        user_type,
        last_device_id,
        device_ids,
        first_device_id,
        updated_at,
        created_at,
        is_internal_user,
        is_bot_user
    FROM favie_dw.dim_favie_gensmo_user_account_full_1d_function(dt_param);
    call favie_dw.record_partition('favie_dw.dim_favie_gensmo_user_account_full_1d', dt_param,"");
END