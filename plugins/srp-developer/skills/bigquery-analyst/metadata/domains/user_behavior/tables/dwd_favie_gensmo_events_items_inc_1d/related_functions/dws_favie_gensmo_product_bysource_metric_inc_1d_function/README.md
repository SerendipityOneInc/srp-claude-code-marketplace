# dws_favie_gensmo_product_bysource_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_product_bysource_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-11-10
**最后更新**: 2025-11-10

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

- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read` (dws_gensmo_user_group_inc_1d_function_read)
- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d` (dwd_favie_gensmo_events_items_inc_1d)
- `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` (dws_favie_gensmo_user_feature_inc_1d)

---

## 💻 函数定义

```sql
with base_events_data AS (
    SELECT 
      dt
      --user info
      ,device_id

      --event info
      ,refer
      ,cal_pre_refer
      ,ap_name
      ,event_name
      ,event_method

    FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d 
    where 1=1
      and event_timestamp is not null 
      and refer is not null 
      and platform is not null
      and event_version='1.0.0' 
      and dt = dt_param
  ),

  base_dws_data as (
    SELECT 
      dt

      --user info
      ,device_id

      --event info
      ,refer
      ,cal_pre_refer
      ,ap_name
      ,event_name
      ,event_method

      --product detail card
      ,sum(if(
        refer in ('product_detail','product_detail_from_search') 
        and event_name = "select_item" 
        and event_method = 'click' 
        and ap_name = 'ap_product_card'
        ,1,0)
      ) as product_external_jump_click_cnt

      ,sum(if(
        refer in ('product_detail','product_detail_from_search') 
        and event_name = "view_item" 
        ,1,0)
      ) as product_detail_pv_cnt

    FROM base_events_data
    group by  
      dt
      ,device_id
      ,refer
      ,cal_pre_refer
      ,ap_name
      ,event_name
      ,event_method
  ),

  -- user_info as (
  --   select 
  --     device_id
  --     ,created_at
  --     ,last_day_feature.platform as last_platform
  --     ,last_day_feature.app_version as last_app_version
  --     ,last_30_days_feature.geo_country_name as geo_country_name
  --     ,last_day_feature.login_type as last_login_type
  --     ,user_tenure_type
  --   from srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d
  -- ),

  user_info_with_group as (
    select 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
    from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)
  ),

  base_dws_data_with_user as (
    select 
      t1.dt

      --user info
      ,t2.platform
      ,t2.app_version
      ,t2.country_name
      ,t2.user_login_type
      ,t2.user_tenure_type
      ,t2.user_group
      ,t1.device_id
      ,t2.device_id as user_device_id

      --event info
      ,t1.refer
      ,t1.cal_pre_refer
      ,t1.ap_name
      ,t1.event_name
      ,t1.event_method

      --product detail card
      ,t1.product_external_jump_click_cnt
      ,t1.product_detail_pv_cnt

    from base_dws_data as t1
    left outer join user_info_with_group t2
    on t1.device_id = t2.device_id
    where t2.user_group is not null
  ),

  base_dws_data_with_uv as (
    SELECT
      dt

      --User Info
      ,platform
      ,app_version
      ,country_name
      ,user_login_type
      ,user_tenure_type
      ,user_group
      ,device_id


      --event info
      ,refer
      ,cal_pre_refer
      ,ap_name
      ,event_name
      ,event_method

      --product detail card
      ,product_external_jump_click_cnt
      ,product_detail_pv_cnt
      ,if(
        refer in ('product_detail','product_detail_from_search') 
        and event_name = "select_item" 
        and event_method = 'click' 
        and ap_name = 'ap_product_card'
        ,user_device_id,null) as product_external_jump_click_device_id
      ,if(
        refer in ('product_detail','product_detail_from_search') 
        and event_name = "view_item" 
        ,user_device_id,null) as product_detail_pv_device_id
    FROM base_dws_data_with_user
    where user_device_id is not null
  )

  SELECT
      dt
      --User Info
      ,platform
      ,app_version
      ,country_name
      ,user_login_type
      ,user_tenure_type
      ,user_group
      ,device_id

      --event info      
      ,refer
      ,cal_pre_refer
      ,ap_name
      ,event_name
      ,event_method

      --product detail card
      ,product_external_jump_click_cnt
      ,product_external_jump_click_device_id
      ,product_detail_pv_cnt
      ,product_detail_pv_device_id
    FROM base_dws_data_with_uv
```

---

**文档生成**: 2026-01-30 13:42:03
**扫描工具**: scan_functions.py
