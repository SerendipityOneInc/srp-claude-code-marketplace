# rpt_decofy_user_active_metrics_inc_1w_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_user_active_metrics_inc_1w_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-05
**最后更新**: 2025-10-05

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
with active_users_base as (
        select 
            dt,
            user_id,
            last_day_feature.duration as duration,
        FROM favie_dw.dws_favie_decofy_user_feature_inc_1d
        WHERE dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
    ),

    week_user_group as (
        select 
            *
        from(
            select 
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
                ad_campaign_id,
                row_number() over (partition by user_id,user_group order by dt) as row_num
            from favie_dw.dws_decofy_user_group_inc_1d 
            where dt is not null and dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
                AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
        ) where row_num = 1
    ),

    with_user_group_info as (
        SELECT
            t1.user_id,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_login_type,
            t2.user_tenure_type,
            t1.duration,
            t2.user_group,
            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id
        FROM active_users_base t1 
        left outer join week_user_group t2 
        on t1.user_id = t2.user_id
        where t2.user_group is not null
    ),
    
    user_active_metric AS (
        SELECT
            DATE_TRUNC(dt_param, WEEK(SUNDAY)) AS week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            COUNT(DISTINCT user_id) AS active_user_w1_cnt,
            SUM(duration) AS total_duration
        FROM with_user_group_info
        GROUP BY
            week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id         
    )

    SELECT
        week_end_dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_type,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        active_user_w1_cnt,
        total_duration
    FROM
        user_active_metric
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
