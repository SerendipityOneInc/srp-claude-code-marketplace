CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_ab_home_metrics_inc_1d_view`
AS SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
        SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
        SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,
        SUM(refer_user_cnt) AS refer_user_cnt,
        SUM(active_user_d1_cnt) AS active_user_d1_cnt
    FROM
        `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_pv_user_penetration_rate_view`
    WHERE
        dt is not null AND user_group LIKE 'ab%' and refer in ('home', 'feed')
    GROUP BY
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        ab_project_name,
        ab_router_id,
        ab_router_name;