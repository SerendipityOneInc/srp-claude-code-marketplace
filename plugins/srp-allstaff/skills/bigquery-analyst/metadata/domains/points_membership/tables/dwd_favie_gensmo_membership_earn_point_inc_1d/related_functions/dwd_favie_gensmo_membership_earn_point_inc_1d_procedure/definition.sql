BEGIN
    -- 删除指定日期的旧数据
    DELETE FROM `favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d`
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO `favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d` (
        dt,
        user_id,
        device_id,
        earn_id,
        earn_type,
        earn_point_type,
        earn_points,
        earn_time
    )
    SELECT 
        dt,
        user_id,
        device_id,
        earn_id,
        earn_type,
        earn_point_type,
        earn_points,
        earn_time
    FROM `favie_dw.dwd_favie_gensmo_membership_earn_point_full_1d_function`(dt_param);

    -- 如有需要可登记分区
    call favie_dw.record_partition('favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d', dt_param, "");
END