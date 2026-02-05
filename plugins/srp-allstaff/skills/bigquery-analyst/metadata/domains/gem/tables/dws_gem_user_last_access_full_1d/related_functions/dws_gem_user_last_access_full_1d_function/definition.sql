WITH user_last_access AS (
        SELECT 
            device_id,
            MAX(dt) AS last_access_date
        FROM `favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt <= dt_param
            AND device_id IS NOT NULL
        GROUP BY device_id
    )
    
    SELECT 
        base.dt AS last_access_date,
        base.device_id,
        base.first_device_id,
        base.appsflyer_id,
        base.is_internal_user,
        base.user_type,
        base.user_tenure_type,
        base.created_at,
        
        -- 最后一天的完整特征信息
        base.last_day_feature,
        base.last_30_days_feature,
        
        CURRENT_TIMESTAMP() AS updated_at
    FROM `favie_dw.dws_favie_gensmo_user_feature_inc_1d` base
    INNER JOIN user_last_access ula
        ON base.device_id = ula.device_id
        AND base.dt = ula.last_access_date