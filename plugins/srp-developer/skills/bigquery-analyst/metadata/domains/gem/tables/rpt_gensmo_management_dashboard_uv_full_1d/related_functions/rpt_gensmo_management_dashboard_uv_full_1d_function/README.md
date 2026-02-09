# rpt_gensmo_management_dashboard_uv_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_uv_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-07-17
**最后更新**: 2025-07-17

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

  ,dts AS (
      SELECT DISTINCT event_dt as dt FROM event
  )

  ,dau AS (
      SELECT
          event_dt dt
          ,coalesce(media_source, 'unknown') as ad_media_source
          ,coalesce(country, 'unknown') AS user_country
          ,coalesce(platform, 'unknown') as last_platform
          ,coalesce(app_version, 'unknown') as last_app_version
          ,coalesce(user_type, 'unknown') as user_type
          ,COUNT(DISTINCT device_id) AS dau
      FROM event
      GROUP BY 1,2,3,4,5,6
  )
  ,wau AS (
      SELECT
          d.dt
          ,coalesce(ua.media_source, 'unknown') as ad_media_source
          ,coalesce(ua.country, 'unknown') AS user_country
          ,coalesce(ua.platform, 'unknown') as last_platform
          ,coalesce(ua.app_version, 'unknown') as last_app_version
          ,coalesce(ua.user_type, 'unknown') as user_type
          ,COUNT(DISTINCT ua.device_id) AS wau
      FROM dts d
      JOIN event ua
        ON ua.event_dt BETWEEN DATE_SUB(d.dt, INTERVAL 6 DAY) AND d.dt
      GROUP BY 1,2,3,4,5,6
  )
  ,mau AS (
      SELECT
          d.dt  
          ,coalesce(ua.media_source, 'unknown') as ad_media_source
          ,coalesce(ua.country, 'unknown') AS user_country
          ,coalesce(ua.platform, 'unknown') as last_platform
          ,coalesce(ua.app_version, 'unknown') as last_app_version
          ,coalesce(ua.user_type, 'unknown') as user_type
          ,COUNT(DISTINCT ua.device_id) AS mau
      FROM dts d
      JOIN event ua
        ON ua.event_dt BETWEEN DATE_SUB(d.dt, INTERVAL 29 DAY) AND d.dt
      GROUP BY 1,2,3,4,5,6
  )
  SELECT
      dt_param as dt
      ,mau.dt   as event_dt
      ,mau.ad_media_source
      ,mau.user_country
      ,mau.last_platform
      ,mau.last_app_version
      ,mau.user_type
      ,mau.mau
      ,dau.dau
      ,wau.wau
  FROM mau
  FULL JOIN wau 
  ON 
      mau.dt = wau.dt
      and mau.ad_media_source = wau.ad_media_source
      and mau.user_country = wau.user_country
      and mau.last_platform = wau.last_platform
      and mau.last_app_version = wau.last_app_version
      and mau.user_type = wau.user_type
  FULL JOIN dau 
  ON 
      mau.dt = dau.dt
      and mau.ad_media_source = dau.ad_media_source
      and mau.user_country = dau.user_country
      and mau.last_platform = dau.last_platform
      and mau.last_app_version = dau.last_app_version
      and mau.user_type = dau.user_type
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
