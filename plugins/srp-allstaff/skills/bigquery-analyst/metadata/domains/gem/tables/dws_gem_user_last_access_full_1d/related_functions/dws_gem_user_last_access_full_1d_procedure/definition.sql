BEGIN
    -- 增量更新用户最后访问日期及完整特征信息
    -- 1. 获取当天出现的用户及其完整特征
    -- 2. 更新已存在用户的最后访问信息（如果日期更新）
    -- 3. 插入新用户记录
    
    -- 临时存储当天的用户完整数据
    CREATE OR REPLACE TEMP TABLE temp_today_users AS
    SELECT 
        dt AS last_access_date,
        device_id,
        first_device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        created_at,
        last_day_feature,
        last_30_days_feature,
        CURRENT_TIMESTAMP() AS updated_at
    FROM `favie_dw.dws_favie_gensmo_user_feature_inc_1d`
    WHERE dt = dt_param
        AND device_id IS NOT NULL;

    -- 更新已存在的用户记录（只有当新日期更大时才更新）
    UPDATE `favie_dw.dws_gem_user_last_access_full_1d` AS target
    SET 
        last_access_date = source.last_access_date,
        appsflyer_id = source.appsflyer_id,
        is_internal_user = source.is_internal_user,
        user_type = source.user_type,
        user_tenure_type = source.user_tenure_type,
        last_day_feature = source.last_day_feature,
        last_30_days_feature = source.last_30_days_feature,
        updated_at = source.updated_at
    FROM temp_today_users AS source
    WHERE target.device_id = source.device_id
        AND source.last_access_date > target.last_access_date;

    -- 插入新用户记录
    INSERT INTO `favie_dw.dws_gem_user_last_access_full_1d` (
        last_access_date,
        device_id,
        first_device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        created_at,
        last_day_feature,
        last_30_days_feature,
        updated_at
    )
    SELECT 
        last_access_date,
        device_id,
        first_device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        created_at,
        last_day_feature,
        last_30_days_feature,
        updated_at
    FROM temp_today_users
    WHERE device_id NOT IN (
        SELECT device_id 
        FROM `favie_dw.dws_gem_user_last_access_full_1d`
    );

    -- 清理临时表
    DROP TABLE temp_today_users;
    
END