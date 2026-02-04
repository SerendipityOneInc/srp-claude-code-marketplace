# rpt_gensmo_user_group_penetration_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-11-13
**最后更新**: 2025-11-13

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
WITH user_group_data AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            user_group,
            COUNT(DISTINCT device_id) AS group_user_cnt
        FROM
            `favie_dw.dws_gensmo_user_group_inc_1d`
        WHERE
            dt = dt_param
            AND user_group IS NOT NULL 
            AND user_activity_type = 'active'
            AND user_group != 'all'
        GROUP BY
            dt, user_tenure_type, user_login_type, country_name, platform, app_version, user_group, ad_source, ad_id, ad_group_id, ad_campaign_id
    ),

    -- 获取所有非'all'的user_group列表
    user_group_list AS (
        SELECT
            ARRAY_AGG(DISTINCT user_group) AS user_groups
        FROM
            `favie_dw.dws_gensmo_user_group_inc_1d`
        WHERE
            dt = dt_param
            AND user_group IS NOT NULL 
            AND user_group != 'all'
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
            SUM(active_user_d1_cnt) AS active_user_cnt
        FROM
            `favie_rpt.rpt_gensmo_user_active_metrics_inc_1d`
        WHERE 
            dt = dt_param
            AND user_group = 'all'
        GROUP BY
            dt, user_tenure_type, user_login_type, country_name, platform, app_version, ad_source, ad_id, ad_group_id, ad_campaign_id
    ),

    -- 将user_group数组join到active_user_cnt上，然后unnest
    active_user_cnt_with_user_group AS (
        SELECT
            a.dt,
            a.user_tenure_type,
            a.user_login_type,
            a.country_name,
            a.platform,
            a.app_version,
            a.ad_source,
            a.ad_id,
            a.ad_group_id,
            a.ad_campaign_id,
            user_group,
            a.active_user_cnt
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
        t1.user_group,
        t1.ad_source,
        t1.ad_id,
        t1.ad_group_id,
        t1.ad_campaign_id,
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
        AND t1.ad_campaign_id = t2.ad_campaign_id
    UNION ALL 
    select 
        t1.dt,
        t1.user_tenure_type,
        t1.user_login_type,
        t1.country_name,
        t1.platform,
        t1.app_version,
        'all' as user_group,
        t1.ad_source,
        t1.ad_id,
        t1.ad_group_id,
        t1.ad_campaign_id,
        t1.active_user_cnt AS group_user_cnt,
        t1.active_user_cnt    
    from active_user_cnt_base t1
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
