CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_refer_click_user_penetration_rate_view`
AS WITH 
    -- 获取点击用户明细，包含device_id和用户分组信息
    page_click_user_with_group AS (
        SELECT
            dt,
            refer,
            CONCAT(event_method, '@', ap_name) AS click_point,
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
            ad_campaign_id
        FROM `favie_dw.dws_decofy_refer_metrics_inc_1d`
        where dt is not null 
            and refer_ap_click_cnt > 0
    ),

    -- 获取PV用户明细，包含device_id和用户分组信息
    page_pv_user_with_group AS (
        SELECT
            dt,
            refer,
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
            ad_campaign_id
        FROM `favie_dw.dws_decofy_refer_metrics_inc_1d` 
        where dt is not null
            and refer_pv_cnt > 0
    ),

    -- 获取所有click_point的集合，按日期和页面分组
    all_click_points AS (
        SELECT
            dt,
            refer,
            ARRAY_AGG(DISTINCT click_point) AS click_point_array
        FROM
            page_click_user_with_group
        GROUP BY
            dt, refer
    ),

    -- 将所有click_point展开到每个PV用户明细上
    pv_user_with_all_click_points AS (
        SELECT
            pv.dt,
            pv.refer,
            pv.user_id,
            pv.user_group,
            pv.country_name,
            pv.platform,
            pv.app_version,
            pv.user_login_type,
            pv.user_tenure_type,
            pv.ad_source,
            pv.ad_id,
            pv.ad_group_id,
            pv.ad_campaign_id,
            click_point
        FROM
            page_pv_user_with_group pv
        CROSS JOIN
            all_click_points acp
        CROSS JOIN
            UNNEST(acp.click_point_array) AS click_point
        WHERE
            pv.dt = acp.dt
            AND pv.refer = acp.refer
    ),

    -- 统计每个click_point的渗透率明细
    click_point_penetration_detail AS (
        SELECT
            pv.dt,
            pv.refer,
            pv.click_point,
            pv.user_group,
            pv.country_name,
            pv.platform,
            pv.app_version,
            pv.user_login_type,
            pv.user_tenure_type,
            pv.user_id,
            pv.ad_source,
            pv.ad_id,
            pv.ad_group_id,
            pv.ad_campaign_id,
            CASE WHEN click.user_id IS NOT NULL THEN 1 ELSE 0 END AS is_clicked,
            1 AS is_pv_user
        FROM
            pv_user_with_all_click_points pv
        LEFT JOIN
            page_click_user_with_group click
        ON
            pv.dt = click.dt
            AND pv.refer = click.refer
            AND pv.click_point = click.click_point
            AND pv.user_id = click.user_id
            AND pv.user_group = click.user_group
            AND pv.country_name = click.country_name
            AND pv.platform = click.platform
            AND pv.app_version = click.app_version
            AND pv.user_login_type = click.user_login_type
            AND pv.user_tenure_type = click.user_tenure_type
            AND pv.ad_source = click.ad_source
            AND pv.ad_id = click.ad_id
            AND pv.ad_group_id = click.ad_group_id
            AND pv.ad_campaign_id = click.ad_campaign_id
    )

    -- 输出每个click_point的渗透率聚合数据，支持多维度聚合分析
    SELECT
        dt,
        refer,
        click_point,
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
        COUNT(DISTINCT user_id) AS pv_user_cnt,
        COUNT(DISTINCT CASE WHEN is_clicked = 1 THEN user_id END) AS click_user_cnt
    FROM
        click_point_penetration_detail
    GROUP BY
        dt,
        refer,
        click_point,
        user_group,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_type,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id;