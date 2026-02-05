BEGIN
    -- 删除指定日期的数据
    DELETE FROM `favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d`
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO `favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d` (
        dt,

        -- user info
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        -- earn dims
        earn_type,
        earn_point_type,
        hit_limit_group,

        -- metrics
        earn_points_user_cnt,
        earn_ponits_task_cnt,
        earn_ponits_points_amt
    )
    SELECT
        dt,

        -- user info
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        -- earn dims
        earn_type,
        earn_point_type,
        hit_limit_group,

        -- metrics
        earn_points_user_cnt,
        earn_ponits_task_cnt,
        earn_ponits_points_amt
    FROM `favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d_function`(dt_param);

    -- 记录分区
    CALL favie_dw.record_partition(
      'dws_faive_gensmo_membership_earn_points_metric_inc_1d',
      dt_param,
      ''
    );
END