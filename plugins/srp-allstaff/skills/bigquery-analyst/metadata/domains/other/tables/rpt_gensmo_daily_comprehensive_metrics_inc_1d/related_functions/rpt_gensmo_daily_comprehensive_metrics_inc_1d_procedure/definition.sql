BEGIN

    -- 1. 插入/更新当天的基础指标
    MERGE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d` AS target
    USING (
        SELECT dt
                ,dau
                ,new_user_cnt
                ,old_user_cnt
                ,mau
                ,wnu_count
                ,us_user
                ,non_us_user
                ,android_user
                ,ios_user
                ,male_user_cnt
                ,female_user_cnt
                ,search_uv
                ,try_on_uv
                ,search_pv
                ,try_on_pv
                ,login_user_cnt
                ,install_cnt
                ,cost
                ,d1_retention_cnt
                ,d1_to_d7_retention_cnt
                ,w1_retention_cnt
                ,created_at
                ,updated_at 
            FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d_function`(dt_param)
    ) AS source
    ON target.dt = source.dt
    WHEN MATCHED THEN
        UPDATE SET 
            dau = source.dau,
            new_user_cnt = source.new_user_cnt,
            old_user_cnt = source.old_user_cnt,
            mau = source.mau,
            wnu_count = source.wnu_count,
            us_user = source.us_user,
            non_us_user = source.non_us_user,
            android_user = source.android_user,
            ios_user = source.ios_user,
            male_user_cnt = source.male_user_cnt,
            female_user_cnt = source.female_user_cnt,
            search_uv = source.search_uv,
            try_on_uv = source.try_on_uv,
            search_pv = source.search_pv,
            try_on_pv = source.try_on_pv,
            login_user_cnt = source.login_user_cnt,
            install_cnt = source.install_cnt,
            cost = source.cost,
            updated_at = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN
        INSERT (
            dt, dau, new_user_cnt, old_user_cnt, mau, wnu_count,
            us_user, non_us_user, android_user, ios_user,
            male_user_cnt, female_user_cnt, 
            search_uv, try_on_uv, search_pv, try_on_pv, login_user_cnt,
            install_cnt, cost,
            d1_retention_cnt, d1_to_d7_retention_cnt, w1_retention_cnt,
            created_at, updated_at
        )
        VALUES (
            source.dt, source.dau, source.new_user_cnt, source.old_user_cnt, 
            source.mau, source.wnu_count,
            source.us_user, source.non_us_user, source.android_user, source.ios_user,
            source.male_user_cnt, source.female_user_cnt, 
            source.search_uv, source.try_on_uv, source.search_pv, source.try_on_pv, source.login_user_cnt,
            source.install_cnt, source.cost,
            NULL, NULL, NULL,
            CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()
        );

    -- 2. 更新昨天的D1留存指标
    UPDATE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d`
    SET 
        d1_retention_cnt = (
            SELECT COUNT(b.device_id)
            FROM (
                SELECT device_id
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt = dt_param
                GROUP BY device_id
            ) a
            JOIN (
                SELECT device_id
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
                AND user_tenure_type = 'New User'
                GROUP BY device_id
            ) b
            ON a.device_id = b.device_id
        ),
        updated_at = CURRENT_TIMESTAMP()
    WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
    AND EXISTS (
        SELECT 1 FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d` 
        WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
    );

    -- 3. 更新7天前的1D7S留存指标
    UPDATE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d`
    SET 
        d1_to_d7_retention_cnt = (
            SELECT COUNT(b.device_id)
            FROM (
                -- d1到d7期间活跃的用户（过去6天到今天）
                SELECT device_id 
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` 
                WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 6 DAY) AND dt_param
                GROUP BY device_id
            ) a 
            JOIN (
                -- d0的新用户（7天前）
                SELECT device_id
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
                AND user_tenure_type = 'New User'
                GROUP BY device_id
            ) b
            ON a.device_id = b.device_id
        ),
        updated_at = CURRENT_TIMESTAMP()
    WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    AND EXISTS (
        SELECT 1 FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d` 
        WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    );

    -- 4. 更新8天前的W1留存指标（实际上是7天前cohort的W1留存）
    UPDATE `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d`
    SET 
        w1_retention_cnt = (
            SELECT COUNT(b.device_id)
            FROM (
                -- d1到d7期间活跃的用户（过去6天到今天）
                SELECT device_id 
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` 
                WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 6 DAY) AND dt_param
                GROUP BY device_id
            ) a 
            JOIN (
                -- d-6到d0的新用户（14-7天前的7天）
                SELECT device_id 
                FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
                WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 13 DAY) AND DATE_SUB(dt_param, INTERVAL 7 DAY)
                AND user_tenure_type = 'New User'
                GROUP BY device_id
            ) b
            ON a.device_id = b.device_id
        ),
        updated_at = CURRENT_TIMESTAMP()
    WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    AND EXISTS (
        SELECT 1 FROM `favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d` 
        WHERE dt = DATE_SUB(dt_param, INTERVAL 7 DAY)
    );

    -- 记录执行日志
    SELECT 
        dt_param AS execution_date,
        'SUCCESS' AS status,
        CURRENT_TIMESTAMP() AS execution_time,
        'Gensmo daily comprehensive metrics updated successfully' AS message;

END