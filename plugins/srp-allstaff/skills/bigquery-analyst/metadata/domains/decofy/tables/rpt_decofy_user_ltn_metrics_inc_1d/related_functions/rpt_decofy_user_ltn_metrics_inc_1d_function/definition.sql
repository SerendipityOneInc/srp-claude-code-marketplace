WITH user_base_dt_active_data AS (
        SELECT
            dt,
            user_id
        FROM `favie_dw.dws_favie_decofy_user_feature_inc_1d`
        WHERE dt = date_sub(dt_param, interval n-1 day)
    ),

    user_group_info as (
        select 
            user_group,
            user_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        from favie_dw.dws_decofy_user_group_inc_1d 
        where dt = date_sub(dt_param, interval n-1 day)
    ),

    user_base_dt_active_data_with_group AS (
        SELECT
            t1.dt,
            t1.user_id,
            t2.user_tenure_type,
            t2.user_login_type,
            t2.membership_tenure_type,
            t2.membership_pay_status,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_group,
            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id
        FROM user_base_dt_active_data t1
        LEFT JOIN user_group_info t2
        ON t1.user_id = t2.user_id 
        WHERE t2.user_group IS NOT NULL
    ),

    user_future_activity AS (
        SELECT
            user_id,
            COUNT(DISTINCT dt) AS user_active_days_cnt
        FROM `favie_dw.dws_favie_decofy_user_feature_inc_1d`
        WHERE dt >= date_sub(dt_param, interval n-1 day) 
            and dt <= dt_param 
        GROUP BY user_id
    ),

    user_ltn_metrics AS (
        SELECT
            f.dt,
            f.user_tenure_type,
            f.user_login_type,
            f.membership_tenure_type,
            f.membership_pay_status,
            f.country_name,
            f.platform,
            f.app_version,
            f.user_group,
            f.ad_source,
            f.ad_id,
            f.ad_group_id,
            f.ad_campaign_id,
            COUNT(DISTINCT f.user_id) AS active_user_cnt,
            SUM(fa.user_active_days_cnt) AS active_days_cnt
        FROM user_base_dt_active_data_with_group f
        LEFT JOIN user_future_activity fa
        ON f.user_id = fa.user_id
        GROUP BY
            f.dt,
            f.user_tenure_type,
            f.user_login_type,
            f.membership_tenure_type,
            f.membership_pay_status,
            f.country_name,
            f.platform,
            f.app_version,
            f.user_group,
            f.ad_source,
            f.ad_id,
            f.ad_group_id,
            f.ad_campaign_id
    )

    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        membership_tenure_type,
        membership_pay_status,
        country_name,
        platform,
        app_version,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        n as lifetime_days,
        active_days_cnt,
        active_user_cnt
    FROM user_ltn_metrics