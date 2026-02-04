# rpt_gensmo_action_user_penetration_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_action_user_penetration_metric_inc_1d_function`
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
WITH action_data AS (
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
            event_action_type,
            COUNT(DISTINCT device_id) AS event_action_user_cnt
        FROM `favie_dw.dws_gensmo_refer_metrics_inc_1d`
        WHERE dt = dt_param
            AND event_action_type IS NOT NULL 
        GROUP BY
            dt, user_tenure_type, user_login_type,user_group, country_name, platform, app_version,event_action_type,ad_source,ad_id,ad_group_id,ad_campaign_id
    ),
    
    action_list AS (
        SELECT
            ARRAY_AGG(DISTINCT event_action_type) AS event_action_types
        FROM `favie_dw.dws_gensmo_refer_metrics_inc_1d`
        WHERE dt = dt_param
            AND event_action_type IS NOT NULL
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
        FROM `favie_rpt.rpt_gensmo_user_active_metrics_inc_1d`
        WHERE dt = dt_param
        GROUP BY
            dt, user_tenure_type, user_login_type, country_name, platform, app_version,user_group,ad_source,ad_id,ad_group_id,ad_campaign_id
    ),
    -- 将refer分类join到active_user_cnt上，然后unnest
    active_user_cnt_with_action AS (
        SELECT
            a.*,
            event_action_type
        FROM
            active_user_cnt_base a
        CROSS JOIN
            action_list rfl,
            UNNEST(rfl.event_action_types) AS event_action_type
    ),
    final_result AS (
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
            t1.event_action_type,
            COALESCE(t2.event_action_user_cnt, 0) AS event_action_user_cnt,
            COALESCE(t1.active_user_d1_cnt,0) AS active_user_d1_cnt
        FROM
            active_user_cnt_with_action t1
        left JOIN
            action_data t2
        ON
            t1.dt = t2.dt
            AND t1.user_tenure_type = t2.user_tenure_type
            AND t1.user_login_type = t2.user_login_type
            AND t1.country_name = t2.country_name
            AND t1.platform = t2.platform
            AND t1.app_version = t2.app_version
            AND t1.user_group = t2.user_group
            AND t1.event_action_type=t2.event_action_type
            AND t1.ad_source = t2.ad_source
            AND t1.ad_id = t2.ad_id
            AND t1.ad_group_id = t2.ad_group_id
            AND t1.ad_campaign_id = t2.ad_campaign_id
    )
    select 
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
        event_action_type,
        event_action_user_cnt,
        active_user_d1_cnt
    from final_result
    where event_action_user_cnt+active_user_d1_cnt>0
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
