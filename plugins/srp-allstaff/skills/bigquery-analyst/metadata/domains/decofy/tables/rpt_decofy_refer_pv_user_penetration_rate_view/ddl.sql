CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_refer_pv_user_penetration_rate_view`
AS WITH refer_data AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            user_group,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            refer,
            COUNT(DISTINCT user_id) AS refer_user_cnt
        FROM `favie_dw.dws_decofy_refer_metrics_inc_1d`
        WHERE dt is not null 
            AND refer IS NOT NULL 
        GROUP BY
            dt, user_tenure_type, user_login_type,user_group, country_name, platform, app_version,refer,ad_source,ad_id,ad_group_id,ad_campaign_id
    ),
    refer_list AS (
        SELECT
            ARRAY_AGG(DISTINCT refer) AS refers
        FROM `favie_dw.dws_decofy_refer_metrics_inc_1d`
        WHERE dt is not null
            AND refer IS NOT NULL 
    ),
    active_user_cnt_base AS (
        SELECT
            dt,
            platform,
            app_version,
            country_name,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            user_group,
            sum(active_user_d1_cnt) as active_user_d1_cnt
        FROM `favie_rpt.rpt_decofy_user_active_metrics_inc_1d`
        WHERE dt is not null
        GROUP BY
            dt, user_tenure_type, user_login_type, country_name, platform, app_version,user_group,ad_source,ad_id,ad_group_id,ad_campaign_id
    ),
    -- 将refer分类join到active_user_cnt上，然后unnest
    active_user_cnt_with_refer AS (
        SELECT
            a.*,
            refer
        FROM
            active_user_cnt_base a
        CROSS JOIN
            refer_list rfl,
            UNNEST(rfl.refers) AS refer
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
        t1.refer,
        COALESCE(t2.refer_user_cnt, 0) AS refer_user_cnt,
        t1.active_user_d1_cnt
    FROM 
        active_user_cnt_with_refer t1
    left JOIN
        refer_data t2
    ON
        t1.dt = t2.dt
        AND t1.user_tenure_type = t2.user_tenure_type
        AND t1.user_login_type = t2.user_login_type
        AND t1.country_name = t2.country_name
        AND t1.platform = t2.platform
        AND t1.app_version = t2.app_version
        AND t1.user_group = t2.user_group
        AND t1.refer=t2.refer
        AND t1.ad_source = t2.ad_source
        AND t1.ad_id = t2.ad_id
        AND t1.ad_group_id = t2.ad_group_id
        AND t1.ad_campaign_id = t2.ad_campaign_id;