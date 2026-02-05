CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_avatar_task_insight_inc_1d_view`
AS WITH task_insight AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,
            device_id,
            validated_task_cnt,
            failed_task_cnt,
            discarded_task_cnt,
            refined_task_cnt,
            selected_task_cnt,
        FROM favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d
        WHERE dt >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    )
    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        'validated' AS scene,
        SUM(validated_task_cnt) AS cnt
    FROM
        task_insight
    GROUP BY
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group
    
    UNION ALL
    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        'failed' AS scene,
        SUM(failed_task_cnt) AS cnt
    FROM
        task_insight
    GROUP BY
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group

    UNION ALL
    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        'discarded' AS scene,
        SUM(discarded_task_cnt) AS cnt
    FROM
        task_insight
    GROUP BY
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group

    UNION ALL
    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        'refined' AS scene,
        SUM(refined_task_cnt) AS cnt
    FROM
        task_insight
    GROUP BY
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group

    UNION ALL
    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        'selected' AS scene,
        SUM(selected_task_cnt) AS cnt
    FROM
        task_insight
    GROUP BY
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group;