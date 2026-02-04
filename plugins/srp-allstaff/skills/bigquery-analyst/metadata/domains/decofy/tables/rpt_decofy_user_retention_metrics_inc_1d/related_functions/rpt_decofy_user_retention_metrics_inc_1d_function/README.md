# rpt_decofy_user_retention_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_user_retention_metrics_inc_1d_function`
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
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with user_yestoday_active_data as (
        select 
            dt,
            user_id
        from favie_dw.dws_favie_decofy_user_feature_inc_1d 
        where dt = DATE_SUB(dt_param, INTERVAL 1 DAY) 
    ),

    user_group_info as (
        select 
            user_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            user_group
        from favie_dw.dws_decofy_user_group_inc_1d 
        where dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
    ),

    user_yestoday_active_data_with_group as (
        select 
            t1.dt,
            t1.user_id,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_login_type,
            t2.user_tenure_type,
            t2.membership_tenure_type,
            t2.membership_pay_status,
            t2.user_group,
            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id
        from user_yestoday_active_data t1
        left outer join user_group_info t2
        on t1.user_id = t2.user_id
        where t2.user_group is not null
    ),

    user_today_active_data as (
        select 
            dt,
            user_id,
        from favie_dw.dws_favie_decofy_user_feature_inc_1d 
        where dt = dt_param 
    ),

    user_retention_data AS (
        select
            t1.dt,
            t1.user_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.membership_tenure_type,
            t1.membership_pay_status,
            t1.user_group,
            t1.ad_source,
            t1.ad_id,
            t1.ad_group_id,
            t1.ad_campaign_id,
            t2.user_id as today_device_id,
        from user_yestoday_active_data_with_group t1 
        left outer join user_today_active_data t2
        on t1.user_id = t2.user_id
    ),

    user_retention_metric as (
        select
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            COUNTIF(today_device_id is not null) as retention_user_d1_cnt,
            COUNT(user_id) as active_user_cnt
        from user_retention_data
        group by
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
    )

    SELECT
        dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_type,
        membership_tenure_type,
        membership_pay_status,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        retention_user_d1_cnt,
        active_user_cnt
    FROM user_retention_metric
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
