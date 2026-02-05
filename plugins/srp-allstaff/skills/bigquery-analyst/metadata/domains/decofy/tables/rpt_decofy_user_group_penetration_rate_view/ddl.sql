CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_user_group_penetration_rate_view`
AS WITH user_group_data AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            COALESCE(app_version, 'unknown') AS app_version,
            user_group,
            COUNT(DISTINCT user_id) AS group_user_cnt
        FROM `favie_dw.dws_decofy_user_group_inc_1d`
        WHERE dt is not null 
            AND user_group IS NOT NULL 
        GROUP BY
            dt, user_tenure_type, user_login_type, country_name, platform, app_version, user_group,ad_source,ad_id,ad_group_id,ad_campaign_id
    ),

    -- 获取所有非'all'的user_group列表
    user_group_list AS (
        SELECT
            ARRAY_AGG(DISTINCT user_group) AS user_groups
        FROM
            `favie_dw.dws_decofy_user_group_inc_1d`
        WHERE
            dt is not null
            AND user_group IS NOT NULL 
    ),

    active_user_cnt_base AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            COALESCE(app_version, 'unknown') AS app_version,
            COUNT(DISTINCT user_id) AS active_user_cnt
        FROM `favie_dw.dws_decofy_user_group_inc_1d`
        WHERE dt is not null AND user_group = 'all'
            and user_id != "unknown"
        GROUP BY
            dt, user_tenure_type, user_login_type, country_name, platform, app_version,ad_source,ad_id,ad_group_id,ad_campaign_id
    ),

    -- 将user_group数组join到active_user_cnt上，然后unnest
    active_user_cnt_with_user_group AS (
        SELECT
            a.*,
            user_group
        FROM
            active_user_cnt_base a
        CROSS JOIN
            user_group_list ugl,
            UNNEST(ugl.user_groups) AS user_group
    )

    SELECT
        t1.dt,
        t1.user_tenure_type,
        t1.user_login_type,
        t1.country_name,
        t1.platform,
        t1.app_version,
        t1.ad_source,
        t1.ad_id,
        t1.ad_group_id,
        t1.ad_campaign_id,
        t1.user_group,
        COALESCE(t2.group_user_cnt, 0) AS group_user_cnt,
        t1.active_user_cnt
    FROM
        active_user_cnt_with_user_group t1
    LEFT JOIN
        user_group_data t2
    ON
        t1.dt = t2.dt
        AND t1.user_tenure_type = t2.user_tenure_type
        AND t1.user_login_type = t2.user_login_type
        AND t1.country_name = t2.country_name
        AND t1.platform = t2.platform
        AND t1.app_version = t2.app_version
        AND t1.user_group = t2.user_group
        AND t1.ad_source = t2.ad_source
        AND t1.ad_id = t2.ad_id
        AND t1.ad_group_id = t2.ad_group_id
        AND t1.ad_campaign_id = t2.ad_campaign_id;