# rpt_gensmo_user_x_action_retention_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_action_retention_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-28
**最后更新**: 2025-10-28

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| retention_type_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |
| active_user_start_dt | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| active_user_end_dt | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| retention_user_start_dt | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| retention_user_end_dt | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with user_active_data as (
        select 
            device_id,
            action_type,
            user_created_at,
            user_login_type
        from(
            select 
                device_id,
                action.action_type as action_type,
                user_created_at,
                first_value(user_login_type) over(partition by device_id order by if(user_login_type = 'login',1,0) desc) as user_login_type,
                row_number() over(partition by device_id,action.action_type order by dt) as rn, 
            FROM favie_dw.dws_gensmo_user_activity_profile_inc_1d,unnest(common_actions) as action
            WHERE dt >= active_user_start_dt AND dt <= active_user_end_dt
        ) where rn = 1
    ),

    user_group_active_period as (
        select 
            *
        from (
            select 
                user_group,
                device_id,
                country_name,
                platform,
                app_version,
                ad_source,
                ad_id,
                ad_group_id,
                ad_campaign_id,
                row_number() over(partition by device_id,user_group order by dt desc) as rn
            from favie_dw.dws_gensmo_user_group_inc_1d 
            where dt >= active_user_start_dt
                    and dt <= active_user_end_dt
        ) where rn = 1
    ),

    user_active_data_with_group as (
        select 
            active_user_end_dt as dt,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t1.user_login_type,
            favie_dw.gensmo_user_tenure_segment_udf(DATE(t1.user_created_at), active_user_end_dt) as user_tenure_segment,
            favie_dw.gensmo_user_tenure_type_udf(DATE(t1.user_created_at),active_user_start_dt,active_user_end_dt) as user_tenure_type,


            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id,

            t2.user_group,
            t1.device_id,
            t1.action_type
        from user_active_data t1
        left outer join user_group_active_period t2
        on t1.device_id = t2.device_id
        where t2.user_group is not null
    ),

    user_retention_data as (
        select 
            distinct device_id,
            action.action_type as action_type
        FROM favie_dw.dws_gensmo_user_activity_profile_inc_1d,unnest(common_actions) as action
        WHERE dt >= retention_user_start_dt AND dt <= retention_user_end_dt
    ),

    finally_data AS (
        select
            t1.dt,
            t1.device_id as active_device_id,
            t1.action_type,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_segment,
            t1.user_tenure_type,

            t1.ad_source,
            t1.ad_id,
            t1.ad_group_id,
            t1.ad_campaign_id,

            t1.user_group,
            t2.device_id as retention_device_id
        from user_active_data_with_group t1
        left outer join user_retention_data t2
        on t1.device_id = t2.device_id and t1.action_type = t2.action_type
    ),

    user_retention_metric as (
        select
            dt,
            action_type,

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

            COUNT(distinct retention_device_id) as retention_user_cnt,
            COUNT(distinct active_device_id) as active_user_cnt
        from finally_data
        group by
            dt,
            action_type,
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
        action_type,
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

        retention_type_param as retention_type,

        active_user_cnt,
        retention_user_cnt
    FROM user_retention_metric
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
