BEGIN

    -- 1. 插入/更新当天的基础指标（4个新用户行为指标）
    MERGE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d` AS target
    USING (
        SELECT * FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d_function`(dt_param)
    ) AS source
    ON target.dt = source.dt
    WHEN MATCHED THEN
        UPDATE SET 
            new_user_search_uv = source.new_user_search_uv,
            new_user_try_on_uv = source.new_user_try_on_uv,
            new_user_search_pv = source.new_user_search_pv,
            new_user_try_on_pv = source.new_user_try_on_pv,
            login_new_user_cnt = source.login_new_user_cnt,
            updated_at = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN
        INSERT (
            dt, new_user_search_uv, new_user_try_on_uv, new_user_search_pv, new_user_try_on_pv,
            login_new_user_cnt,
            login_d1_retention_cnt, login_d1_to_d7_retention_cnt, login_w1_retention_cnt,
            created_at, updated_at
        )
        VALUES (
            source.dt, source.new_user_search_uv, source.new_user_try_on_uv, 
            source.new_user_search_pv, source.new_user_try_on_pv,
            source.login_new_user_cnt,
            NULL, NULL, NULL,
            CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()
        );

    -- 2. 更新昨天的登录用户D1留存指标
    UPDATE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d`
    SET 
        login_d1_retention_cnt = (
            SELECT COUNT(b.device_id)
            FROM (
                -- 今天活跃的用户
                SELECT device_id
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt = dt_param
                GROUP BY device_id
            ) a
            JOIN (
                -- 昨天的新用户且是登录用户
                SELECT dt, device_id
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
                AND user_tenure_type = 'New User'
                AND last_day_feature.login_type = 'login'
                GROUP BY dt, device_id
            ) b
            ON a.device_id = b.device_id
        ),
        updated_at = CURRENT_TIMESTAMP()
    WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
    AND EXISTS (
        SELECT 1 FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d` 
        WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
    );

    -- 3. 更新7天前的登录用户1D7S留存指标
    UPDATE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d`
    SET 
        login_d1_to_d7_retention_cnt = (
            SELECT COUNT(b.device_id)
            FROM (
                -- d1到d7期间活跃的用户（过去6天到今天）
                SELECT device_id 
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` 
                WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 6 DAY) AND dt_param
                GROUP BY device_id
            ) a 
            JOIN (
                -- d0的新用户且是登录用户（7天前）
                SELECT device_id, dt
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
                AND user_tenure_type = 'New User'
                AND last_day_feature.login_type = 'login'
                GROUP BY device_id, dt
            ) b
            ON a.device_id = b.device_id
        ),
        updated_at = CURRENT_TIMESTAMP()
    WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    AND EXISTS (
        SELECT 1 FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d` 
        WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    );

    -- 4. 更新7天前的登录用户W1留存指标
    UPDATE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d`
    SET 
        login_w1_retention_cnt = (
            SELECT COUNT(b.device_id)
            FROM (
                -- d1到d7期间活跃的用户（过去6天到今天）
                SELECT device_id 
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` 
                WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 6 DAY) AND dt_param
                GROUP BY device_id
            ) a 
            JOIN (
                -- d-6到d0的新用户且是登录用户（14-7天前的7天）
                SELECT device_id 
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 13 DAY) AND DATE_SUB(dt_param, INTERVAL 7 DAY)
                AND user_tenure_type = 'New User'
                AND last_day_feature.login_type = 'login'
                GROUP BY device_id
            ) b
            ON a.device_id = b.device_id
        ),
        updated_at = CURRENT_TIMESTAMP()
    WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    AND EXISTS (
        SELECT 1 FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d` 
        WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    );

    -- 记录执行日志
    SELECT 
        dt_param AS execution_date,
        'SUCCESS' AS status,
        CURRENT_TIMESTAMP() AS execution_time,
        CONCAT(
            'Gensmo supply metrics updated successfully. ',
            'Updated login retention metrics for: ',
            'D1 (', DATE_SUB(dt_param, INTERVAL 1 DAY), '), ',
            '1D7S (', DATE_SUB(dt_param, INTERVAL 7 DAY), '), ',
            'W1 (', DATE_SUB(dt_param, INTERVAL 7 DAY), ')'
        ) AS message;

END