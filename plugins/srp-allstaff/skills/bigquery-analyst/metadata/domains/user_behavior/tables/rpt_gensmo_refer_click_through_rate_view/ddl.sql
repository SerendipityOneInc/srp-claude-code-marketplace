CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_click_through_rate_view`
AS WITH refer_pv_data AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            user_group,
            country_name,
            platform,
            COALESCE(app_version, 'unknown') AS app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            refer,
            sum(refer_pv_cnt) AS refer_pv_cnt
        FROM `favie_dw.dws_gensmo_refer_metrics_inc_1d`
        WHERE dt is not null 
            AND refer IS NOT NULL 
            and refer_pv_cnt > 0
        GROUP BY
            dt, user_tenure_type, user_login_type,user_group, country_name, platform, app_version,ad_source,ad_id,ad_group_id,ad_campaign_id,refer
    ),

    refer_click_data AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            user_group,
            country_name,
            platform,
            COALESCE(app_version, 'unknown') AS app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            refer,
            ap_name,
            sum(refer_ap_click_cnt) AS refer_ap_click_cnt
        FROM
            `favie_dw.dws_gensmo_refer_metrics_inc_1d`
        WHERE
            dt is not null 
            AND refer IS NOT NULL 
            and event_method = 'click'
            and refer_ap_click_cnt > 0
        GROUP BY
            dt, user_tenure_type, user_login_type,user_group, country_name, platform, app_version,ad_source,ad_id,ad_group_id,ad_campaign_id,refer,ap_name
    ),

    refer_ap_name_list AS (
        SELECT
            refer,
            ARRAY_AGG(DISTINCT ap_name) AS ap_names
        FROM
            refer_click_data
        WHERE
            dt is not null
            AND refer IS NOT NULL 
        group by refer
    ),

    -- 将refer分类join到active_user_cnt上，然后unnest
    refer_pv_data_with_ap_name AS (
        SELECT
            a.*,
            ap_name
        FROM refer_pv_data a left outer JOIN refer_ap_name_list rfl 
        ON a.refer = rfl.refer,
        UNNEST(rfl.ap_names) AS ap_name
    )
    SELECT
        t1.dt,
        t1.user_tenure_type,
        t1.user_login_type,
        t1.country_name,
        t1.platform,
        t1.app_version,
        t1.user_group,
        t1.ad_source,
        t1.ad_id,
        t1.ad_group_id,
        t1.ad_campaign_id,
        t1.refer,
        t1.ap_name,
        t2.refer_ap_click_cnt,
        t1.refer_pv_cnt
    FROM 
        refer_pv_data_with_ap_name t1
    left JOIN
        refer_click_data t2
    ON
        t1.dt = t2.dt
        AND t1.user_tenure_type = t2.user_tenure_type
        AND t1.user_login_type = t2.user_login_type
        AND t1.country_name = t2.country_name
        AND t1.platform = t2.platform
        AND t1.app_version = t2.app_version
        AND t1.user_group = t2.user_group
        AND t1.refer=t2.refer
        AND t1.ap_name = t2.ap_name
        AND t1.ad_source = t2.ad_source
        AND t1.ad_id = t2.ad_id
        AND t1.ad_group_id = t2.ad_group_id
        AND t1.ad_campaign_id = t2.ad_campaign_id;