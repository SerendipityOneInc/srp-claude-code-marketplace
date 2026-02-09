WITH user_first_week_active_data AS (
        SELECT DISTINCT
            user_id,
        FROM `favie_dw.dws_favie_decofy_user_feature_inc_1d`
        WHERE dt >= DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(SUNDAY))
    ),

    week_user_group as (
        select 
            *
        from(
            select 
                user_id, 
                user_group,
                country_name,
                platform,
                app_version,
                user_login_type,
                user_tenure_type,
                ad_source,
                ad_id,
                ad_group_id,
                ad_campaign_id,
                row_number() over (partition by user_id,user_group order by dt) as row_num
            from favie_dw.dws_decofy_user_group_inc_1d 
            where dt is not null and dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
                AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
        ) where row_num = 1
    ),

    user_first_week_data_with_group AS (
        SELECT 
            t1.user_id,
            t2.user_tenure_type,
            t2.user_login_type,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_group,
            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id
        FROM user_first_week_active_data t1
        INNER JOIN week_user_group t2
        ON t1.user_id = t2.user_id AND t2.user_group IS NOT NULL
    ),

    user_second_week_active_data AS (
        SELECT DISTINCT
            user_id
        FROM `favie_dw.dws_favie_decofy_user_feature_inc_1d`
        WHERE dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
    ),

    user_retention_data AS (
        SELECT
            t1.user_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.user_group,
            t1.ad_source,
            t1.ad_id,
            t1.ad_group_id,
            t1.ad_campaign_id,
            t2.user_id AS second_week_device_id
        FROM user_first_week_data_with_group t1
        LEFT JOIN user_second_week_active_data t2
        ON t1.user_id = t2.user_id
    ),

    user_retention_metric AS (
        SELECT
            DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(SUNDAY)) AS week_end_dt,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            COUNT(DISTINCT second_week_device_id) as retention_user_w1_cnt,
            COUNT(DISTINCT user_id) as active_user_cnt
        FROM user_retention_data
        GROUP BY
            week_end_dt,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
    )

    SELECT
        week_end_dt,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_type,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        retention_user_w1_cnt,
        active_user_cnt
    FROM user_retention_metric