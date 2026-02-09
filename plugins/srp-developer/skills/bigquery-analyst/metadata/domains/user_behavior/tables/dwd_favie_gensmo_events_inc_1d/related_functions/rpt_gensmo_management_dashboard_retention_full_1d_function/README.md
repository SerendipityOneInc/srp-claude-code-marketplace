# rpt_gensmo_management_dashboard_retention_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_retention_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-09-01
**最后更新**: 2025-09-01

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d` (dwd_favie_gensmo_events_inc_1d)
- `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_inc_1d_view` (dim_gem_appsflyer_inc_1d_view)

---

## 💻 函数定义

```sql
with install_with_rn as (
    SELECT
      *
      ,row_number() over (
        partition by appsflyer_id 
        order by 
          case
            when source = 'ON_LINE' then 1
            when source = 'OFF_LINE' then 2
            else 3
          end
          ,case 
            when media_source not in ('organic', 'None') then 1
            when media_source = 'organic' then 2
            else 3
          end
      ) as rn
    FROM `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_inc_1d_view` 
  )

  ,install as (
    select
      * except(rn)
    from install_with_rn
    where rn = 1
  )

  ,device as (
    select 
      d.dt
      ,d.device_id
      ,d.first_device_id
      ,d.appsflyer_id
      ,d.user_type
      ,date(d.created_at) as created_dt
      ,d.last_day_feature.geo_country_name as country
      ,d.last_day_feature.login_type as login_type
      ,d.last_day_feature.platform as platform
      ,d.last_day_feature.app_version as app_version
      ,i.media_source
    from (
      select *
      from favie_dw.dws_favie_gensmo_user_feature_inc_1d
      where 1=1
        and is_internal_user is false 
    ) d
    left join install i
    on d.appsflyer_id = i.appsflyer_id
  )

  ,event as (
    select 
      d.first_device_id as device_id
      ,d.created_dt
      ,d.media_source
      ,d.country
      ,d.platform
      ,d.app_version
      ,d.login_type
      ,d.user_type
      ,e.dt as event_dt
      ,e.event_name
      ,e.refer
      ,e.ap_name
      ,e.event_method
      ,e.event_action_type
      ,e.event_items
      ,e.event_version
    from (
      select * 
      from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
      where 1=1
        and (
          event_method not in ('app_launch', 'app_foreground', 'app_background')
          or event_method is null 
        )
        and dt >= '2025-04-30'
    ) e
    join device d
    on e.device_id = d.device_id
      and e.dt = d.dt
  )

  ,active as (
    select distinct
      event_dt
      ,case 
        when event_dt < created_dt then 'irregular_dt' 
        when event_dt = created_dt then 'new'
        when date_diff(event_dt, created_dt, day) between 1 and 6 then '1_6_days'
        when date_diff(event_dt, created_dt, day) between 7 and 29 then '7_29_days'
      else 'above_30_days' end as is_new_user      ,coalesce(media_source, 'unknown') as ad_media_source
      ,coalesce(country, 'unknown') AS user_country
      ,coalesce(platform, 'unknown') as last_platform
      ,coalesce(app_version, 'unknown') as last_app_version
      ,coalesce(user_type, 'unknown') as user_type
      ,device_id
    from event
  )

  ,retention_detail as (
    select distinct
      a1.*
      ,a2.event_dt as retention_dt
      ,date_diff(a2.event_dt, a1.event_dt, day) as days
    from active a1 
    left join active a2 
    on 
      a1.device_id = a2.device_id 
      and a1.event_dt < a2.event_dt
  )

  select
    dt_param as dt 
    ,event_dt 
    ,is_new_user
    ,ad_media_source
    ,user_country
    ,last_platform
    ,last_app_version
    ,user_type
    ,count(distinct device_id) as d0_active
    ,count(distinct case when days = 1 then device_id else null end) as d1_retention
    ,count(distinct case when days = 2 then device_id else null end) as d2_retention
    ,count(distinct case when days = 6 then device_id else null end) as d6_retention
    ,count(distinct case when days between 1 and 6 then concat(days,device_id) else null end) as LT_1_to_6
    ,count(distinct(case when days between 7 and 13 then device_id else null end)) as w1_retention
    ,count(distinct case when days between 1 and 7 then device_id else null end) as d1_7_retention
  from retention_detail
  group by 1,2,3,4,5,6,7,8
```

---

**文档生成**: 2026-01-30 13:39:30
**扫描工具**: scan_functions.py
