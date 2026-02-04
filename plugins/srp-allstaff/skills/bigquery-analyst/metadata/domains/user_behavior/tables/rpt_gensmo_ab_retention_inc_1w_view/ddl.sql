CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_retention_inc_1w_view`
AS WITH ab_users AS (
        SELECT
            week_end_dt,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,
            retention_user_w1_cnt,
            active_user_cnt
        FROM
            `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1w`
        WHERE
            user_group LIKE 'ab_%' AND week_end_dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
    )

    SELECT
        week_end_dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        retention_user_w1_cnt,
        active_user_cnt
    FROM
        ab_users;