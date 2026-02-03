# rpt_gensmo_refer_click_user_penetration_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-17
**最后更新**: 2025-12-17

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH page_click_user_with_group AS (
        SELECT
            dt,
            refer,
            ap_name,
            device_id,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id
        FROM `favie_dw.dws_gensmo_refer_metrics_inc_1d`
        where dt = dt_param 
            and refer_ap_click_cnt > 0
            and event_method = 'click'
    ),

    -- 获取PV用户明细，包含device_id和用户分组信息
    page_pv_user_with_group AS (
        SELECT
            dt,
            refer,
            device_id,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id
        FROM `favie_dw.dws_gensmo_refer_metrics_inc_1d` 
        where dt = dt_param 
            and refer_pv_cnt > 0
    ),

    -- 获取所有ap_name的集合，按日期和页面分组
    all_ap_names AS (
        SELECT
            dt,
            refer,
            ARRAY_AGG(DISTINCT ap_name) AS ap_name_array
        FROM
            page_click_user_with_group
        GROUP BY
            dt, refer
    ),

    -- 将所有ap_name展开到每个PV用户明细上
    pv_user_with_all_ap_names AS (
        SELECT
            pv.dt,
            pv.refer,
            pv.device_id,
            pv.user_group,
            pv.country_name,
            pv.platform,
            pv.app_version,
            pv.user_login_type,
            pv.user_tenure_type,
            pv.ad_source,
            pv.ad_group_id,
            pv.ad_campaign_id,
            pv.ad_id,
            ap_name
        FROM
            page_pv_user_with_group pv
        CROSS JOIN
            all_ap_names acp
        CROSS JOIN
            UNNEST(acp.ap_name_array) AS ap_name
        WHERE
            pv.dt = acp.dt
            AND pv.refer = acp.refer
    ),

    -- 统计每个ap_name的渗透率明细
    ap_name_penetration_detail AS (
        SELECT
            pv.dt,
            pv.refer,
            pv.ap_name,
            pv.user_group,
            pv.country_name,
            pv.platform,
            pv.app_version,
            pv.user_login_type,
            pv.user_tenure_type,
            pv.ad_source,
            pv.ad_group_id,
            pv.ad_campaign_id,
            pv.ad_id,
            pv.device_id,
            CASE WHEN click.device_id IS NOT NULL THEN 1 ELSE 0 END AS is_clicked,
            1 AS is_pv_user
        FROM
            pv_user_with_all_ap_names pv
        LEFT JOIN
            page_click_user_with_group click
        ON
            pv.dt = click.dt
            AND pv.refer = click.refer
            AND pv.ap_name = click.ap_name
            AND pv.device_id = click.device_id
            AND pv.user_group = click.user_group
            AND pv.country_name = click.country_name
            AND pv.platform = click.platform
            AND pv.app_version = click.app_version
            AND pv.user_login_type = click.user_login_type
            AND pv.user_tenure_type = click.user_tenure_type
            and pv.ad_source = click.ad_source
            and pv.ad_group_id = click.ad_group_id
            and pv.ad_campaign_id = click.ad_campaign_id
            and pv.ad_id = click.ad_id
    ),

    -- 输出每个ap_name的渗透率聚合数据，支持多维度聚合分析
    final_result AS (
        SELECT
            dt,
            refer,
            ap_name,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id,
            COUNT(DISTINCT device_id) AS pv_user_cnt,
            COUNT(DISTINCT CASE WHEN is_clicked = 1 THEN device_id END) AS click_user_cnt
        FROM
            ap_name_penetration_detail
        GROUP BY
            dt,
            refer,
            ap_name,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id
    )
    SELECT 
        dt,
        refer,
        ap_name,
        user_group,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_type,
        ad_source,
        ad_group_id,
        ad_campaign_id, 
        ad_id,
        pv_user_cnt,
        click_user_cnt
    FROM final_result
    where pv_user_cnt + click_user_cnt > 0
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
