# rpt_gensmo_user_x_active_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-22
**最后更新**: 2025-10-22

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| active_period_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with active_users as (
        select 
            dt,
            device_id,
            first_value(user_created_at) over(partition by device_id order by dt) as created_at,
            first_value(user_login_type) over(partition by device_id order by if(user_login_type = 'login',1,0) desc) as user_login_type,
            user_duration
        FROM favie_dw.dws_gensmo_user_activity_profile_inc_1d
        WHERE dt >= date_sub(dt_param, interval active_period_param-1 day) AND dt <= dt_param
    ),

    active_users_sum as (
        select 
            device_id,
            created_at,
            user_login_type,
            sum(user_duration) as user_duration
        from active_users
        group by
            device_id,
            created_at,
            user_login_type
    ),

    user_group_base as (
        select 
            user_group,
            device_id,
            country_name,
            platform,
            app_version,

            --取周期内最高的广告属性
            first_value(ad_source) over(partition by device_id,user_group order by dt) as ad_source,
            first_value(ad_id) over(partition by device_id,user_group order by dt) as ad_id,
            first_value(ad_group_id) over(partition by device_id,user_group order by dt) as ad_group_id,
            first_value(ad_campaign_id) over(partition by device_id,user_group order by dt) as ad_campaign_id,

            row_number() over(partition by device_id,user_group order by dt desc) as rn
        from favie_dw.dws_gensmo_user_group_inc_1d
        where dt >= date_sub(dt_param, interval active_period_param-1 day) AND dt <= dt_param        
    ),

    --获取每个分组的最新用户属性
    user_group_info as (
        select 
            user_group,
            device_id,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        from user_group_base
        where rn = 1
    ),

    active_user_with_group_info as (
        SELECT
            t2.country_name,
            t2.platform,
            t2.app_version,
            t1.user_login_type,
            favie_dw.gensmo_user_tenure_segment_udf(DATE(t1.created_at), dt_param) as user_tenure_segment,
            favie_dw.gensmo_user_tenure_type_udf(DATE(t1.created_at), date_sub(dt_param, interval active_period_param-1 day), dt_param) as user_tenure_type,

            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id,

            t2.user_group,

            t1.device_id,
            t1.user_duration
        FROM active_users_sum t1
        left outer join user_group_info t2
        on t1.device_id = t2.device_id
        where t2.user_group is not null
    ),

    user_active_metric AS (
        SELECT
            dt_param as dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_segment,
            user_tenure_type,

            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,

            user_group,

            COUNT(DISTINCT device_id) AS active_user_cnt,
            SUM(user_duration) AS user_duration
        FROM active_user_with_group_info
        GROUP BY
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_segment,
            user_tenure_type,

            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,

            user_group
    )


    SELECT
        dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_segment,
        user_tenure_type,

        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        user_group,

        active_period_param as active_period,

        active_user_cnt,
        user_duration
    FROM
        user_active_metric
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
