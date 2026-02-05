WITH user_base_dt_active_data AS (
    -- 基准日活跃用户集合
    SELECT
        dt AS base_dt,
        device_id,
        user_login_type,
        app_version,
        platform,
        CASE 
        WHEN event_action_type = 'try_on' THEN 'try_on'
        WHEN event_action_type = 'collage_gen'  THEN 'search'
        WHEN event_action_type = 'enter_feed_detail' THEN 'feed'
        WHEN event_action_type = 'try_on_scene_gen'     THEN 'vibe_gen'
        WHEN event_action_type = 'post'         THEN 'post'
        else null
    END AS function_type
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d`
    WHERE dt = dt_param
),

user_future_activity AS (
    -- 未来 7 天的活跃记录
    SELECT
        device_id,
        COUNT(DISTINCT dt) AS active_days_7d
    FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
    WHERE dt BETWEEN DATE_ADD(dt_param, INTERVAL 1 DAY) AND DATE_ADD(dt_param, INTERVAL 7 DAY)
    GROUP BY device_id
),

user_1d7s AS (
    SELECT
        f.base_dt,
        f.user_login_type,
        f.platform,
        f.app_version,
        f.function_type,
        COUNT(DISTINCT f.device_id) AS active_user_cnt,   -- 基准日活跃数
        COUNT(DISTINCT CASE WHEN fa.active_days_7d >= 1 THEN f.device_id END) AS revisit_user_cnt -- 至少 1 次回访
    FROM user_base_dt_active_data f
    
    LEFT JOIN user_future_activity fa
           ON f.device_id = fa.device_id
    where f.function_type is not null
    GROUP BY f.base_dt,f.user_login_type,f.platform,f.app_version,f.function_type
)

SELECT
    base_dt,
    user_login_type,
    platform,
    app_version,
    function_type,
    active_user_cnt,
    revisit_user_cnt
FROM user_1d7s