WITH last_x_days_user_profile as (
        select 
            dt,
            device_id,
            appsflyer_id,

            is_internal_user,
            user_type,
            user_tenure_type,
            user_tenure_segment,
            user_login_type,
            user_created_at,

            user_duration,
            common_actions
        from favie_dw.dws_gensmo_user_activity_profile_inc_1d
        WHERE dt >= start_dt
            and dt <= end_dt  
    ),

    user_x_days_tracking_data as (
        select 
            device_id,
            -- 直接合并 common_actions 数组
            ARRAY_CONCAT_AGG(common_actions) as all_common_actions,
            -- 活跃日期
            ARRAY_AGG(dt ORDER BY dt) as active_dates
        from last_x_days_user_profile
        group by device_id
    ),

    -- 去重并聚合合并后的数组
    user_x_days_final_data as (
        select 
            device_id,
            -- 去重 common_actions
            ARRAY(
                SELECT AS STRUCT action_type, SUM(action_cnt) as action_cnt
                FROM UNNEST(all_common_actions) as action
                GROUP BY action_type
            ) as common_actions_xd,
            active_dates
        from user_x_days_tracking_data
    ),

    finally_data as (
        select
            t1.dt,
            t1.device_id,
            t1.appsflyer_id,
            t1.is_internal_user,
            t1.user_type,
            t1.user_tenure_type,
            t1.user_tenure_segment,
            t1.user_login_type,
            t1.user_created_at,
            t1.user_duration,
            t1.common_actions as common_actions_1d,
            t2.common_actions_xd as common_actions_xd,
            t2.active_dates
        from (select * from last_x_days_user_profile where dt = start_dt) as t1
        left outer join user_x_days_final_data t2
        on t1.device_id = t2.device_id
    )

    SELECT 
        dt,
        device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        user_tenure_segment,
        user_login_type,
        user_created_at,
        tracking_period_param AS tracking_period,
        IFNULL(user_duration, 0) AS user_duration,
        IFNULL(common_actions_1d, []) AS common_actions_1d,
        IFNULL(common_actions_xd, []) AS common_actions_xd,
        IFNULL(active_dates, []) AS active_dates
    FROM finally_data