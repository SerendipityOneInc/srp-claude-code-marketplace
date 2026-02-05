# dws_favie_gensmo_feed_bysource_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-11-11
**最后更新**: 2025-11-11

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
- `srpproduct-dc37e.favie_dw.dim_gem_moodboard_view` (dim_gem_moodboard_view)

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
      ,refer_pv_seq
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,concat(coalesce(refer,"unknown"),"@",coalesce(ap_name,"unknown")) as event_source

      --feed info
      ,event_item.item_id as item_id
      ,event_item.item_type as item_type
    FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d 
    where 1=1
      and event_timestamp is not null 
      and refer is not null 
      and platform is not null
      and event_version='1.0.0' 
      -- and event_item.item_id is not null
      -- and event_item.item_type is not null
      and dt is not null
      and dt = dt_param
      and (
        refer in ("home","feed_detail","hashtag_page",'feed') 
        or 
        refer in ("pseudo_product_detail","product_detail") and cal_pre_refer = "feed_detail"
        or
        event_action_type = 'enter_feed_detail'
      )
      and event_item.item_type in ("try_on_collage","general_collage")
      and refer_group = 'valid'
  ),

  dim_gem_moodboard_with_rank as (
    select 
      moodboard_id,
      intention,
      updated_time,
      row_number() over(partition by moodboard_id order by updated_time desc) as rn
    from srpproduct-dc37e.favie_dw.dim_gem_moodboard_view
  ),

  base_events_data_with_item_intention as (
    SELECT 
      t1.dt
      --user info
      ,t1.device_id

      --event info
      ,t1.refer
      ,t1.ap_name
      ,t1.event_name
      ,t1.event_method
      ,t1.event_action_type
      ,t1.event_source

      --feed info
      ,t1.item_id
      ,t1.item_type
      ,coalesce(t2.intention,t1.item_type) as item_intention
      ,concat(coalesce(ap_name,"unknown"),"@",coalesce(t2.intention,t1.item_type,"unknown")) as feed_source

    FROM base_events_data as t1
    left outer join (select * from dim_gem_moodboard_with_rank where rn = 1) as t2
    on  t1.item_id = t2.moodboard_id
  ),

  base_dws_data as (
    SELECT 
      dt

      --user info
      ,device_id

      --event info
      ,refer
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,event_source

      --feed info
      ,item_type
      ,item_intention
      ,feed_source

      --home
      ,sum(if(refer in ('home', 'feed'),1,0)) as home_pv_cnt

      --feed list
      ,sum(if(
        refer in ('home', 'feed')
        and event_name = "view_item_list"
        and (ap_name like 'ap_dual_column_feed%' or ap_name = 'ap_feed_list')
        ,1,0)) as feed_item_list_pv_cnt

      --feed view
      ,sum(if(
        (refer in ('home', 'feed')
        and event_name = "select_item"
        and event_method = 'true_view_trigger'
        and (ap_name = 'ap_feed_list_item' or ap_name like 'ap_dual_column_feed%')
        )
        or
        (
          refer = 'hashtag_page'
          and event_name = "select_item"
          and event_method = 'true_view_trigger'
          and ap_name = 'ap_hashtag_feed_list'
        )
        or
        (
          refer = 'feed_detail'
          and event_name = "select_item"
          and event_method = 'true_view_trigger'
          and ap_name = 'ap_feed_list'
        )
        ,1,0)) as feed_item_view_pv_cnt

      --feed click
      ,sum(if(
        event_action_type = 'enter_feed_detail'
        ,1,0)) as feed_item_click_cnt

      --feed detail
      ,sum(if(
        refer = 'feed_detail' 
        and event_name = "select_item" 
        and event_method in ('click','shake','screenshot')
        ,1,0)) as feed_detail_click_cnt

      ,sum(if(
        refer in ('feed_detail','product_detail') 
        and (
         (event_name = "select_item" and event_method = 'click' and ap_name like 'ap_try_on_%')
         or 
         event_method = "shake"
        )
        ,1,0)) as feed_item_tryon_click_cnt

      ,sum(if(
        refer in ('feed_detail','product_detail') 
        and event_name = "select_item" and event_method = 'click' and ap_name like 'ap_remix_%'
        ,1,0)) as feed_item_remix_click_cnt

      ,sum(if(
        refer in ('feed_detail','product_detail') 
        and (
         (event_name = "select_item" and event_method = 'click' and ap_name in ('ap_save_btn','ap_share_btn'))
         or 
         event_method = "screenshot"
        )
        ,1,0)) as feed_item_save_share_click_cnt 

      ,sum(if(
        refer in ('feed_detail','product_detail') 
        and event_name = "select_item" and event_method = 'click' and (ap_name like 'ap_product_%' or ap_name = 'ap_collage_entity_list_entity')
        ,1,0)) as feed_item_product_click_cnt

      ,sum(if(refer = "feed_detail" and event_name = "select_item" and event_method = 'page_view'
        ,1,0)) as feed_item_detail_pv_cnt

      --product detail
      ,sum(if(
        refer in ('product_detail','pseudo_product_detail') 
        and event_name = "select_item" 
        and event_method = 'click' 
        and ap_name like 'ap_%'
        ,1,0)) as feed_product_detail_click_cnt
      ,sum(if(
        refer in ('product_detail','pseudo_product_detail') 
        and event_name = "view_item" 
        ,1,0)) as feed_product_detail_pv_cnt

    FROM base_events_data_with_item_intention
    group by  
      dt
      ,device_id
      ,refer
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,event_source
      ,item_type
      ,item_intention
      ,feed_source
  ),

  -- active_user_info AS (
  --   SELECT 
  --     device_id,
  --     last_day_feature.platform as platform,
  --     last_day_feature.app_version as app_version,
  --     last_30_days_feature.geo_country_name as country_name,
  --     last_day_feature.login_type as user_login_type,
  --     user_tenure_type
  --   FROM srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d
  --   where dt is not null and dt = dt_param
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
      ,t1.ap_name
      ,t1.event_name
      ,t1.event_method
      ,t1.event_action_type
      ,t1.event_source

      --feed info
      ,t1.item_type
      ,t1.item_intention
      ,t1.feed_source

      --home
      ,t1.home_pv_cnt

      --feed list
      ,t1.feed_item_list_pv_cnt

      --feed view
      ,t1.feed_item_view_pv_cnt

      --feed click
      ,t1.feed_item_click_cnt

      --feed detail
      ,t1.feed_detail_click_cnt
      ,t1.feed_item_tryon_click_cnt
      ,t1.feed_item_remix_click_cnt
      ,t1.feed_item_save_share_click_cnt
      ,t1.feed_item_product_click_cnt
      ,t1.feed_item_detail_pv_cnt

      --product detail
      ,t1.feed_product_detail_click_cnt
      ,t1.feed_product_detail_pv_cnt

    from (
      select 
        * from base_dws_data
      where  (COALESCE(home_pv_cnt, 0)
        + COALESCE(feed_item_list_pv_cnt, 0)
        + COALESCE(feed_item_view_pv_cnt, 0)
        + COALESCE(feed_item_click_cnt, 0)
        + COALESCE(feed_detail_click_cnt, 0)
        + COALESCE(feed_item_tryon_click_cnt, 0)
        + COALESCE(feed_item_remix_click_cnt, 0)
        + COALESCE(feed_item_save_share_click_cnt, 0)
        + COALESCE(feed_item_product_click_cnt, 0)
        + COALESCE(feed_item_detail_pv_cnt, 0)
        + COALESCE(feed_product_detail_click_cnt, 0)
        + COALESCE(feed_product_detail_pv_cnt, 0)) > 0
    ) as t1 left outer join user_info_with_group t2
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
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,event_source

      --feed info
      ,item_type
      ,item_intention
      ,feed_source

      --home
      ,home_pv_cnt
      ,if(refer in ('home', 'feed'),user_device_id,null) as home_device_id

      --feed item list
      ,feed_item_list_pv_cnt
      ,if(refer in ('home', 'feed')
        and event_name = "view_item_list"
        and ap_name like 'ap_dual_column_feed%'
        ,user_device_id,null) as feed_item_list_device_id

      --feed item view
      ,feed_item_view_pv_cnt
      ,if((refer in ('home', 'feed')
        and event_name = "select_item" 
        and event_method = 'true_view_trigger' 
        and ap_name like 'ap_dual_column_feed%')
        or
        (
          refer = 'hashtag_page'
          and event_name = "select_item"
          and event_method = 'true_view_trigger'
          and ap_name = 'ap_hashtag_feed_list'
        )
        or
        (
          refer = 'feed_detail'
          and event_name = "select_item"
          and event_method = 'true_view_trigger'
          and ap_name = 'ap_feed_list'
        )
        ,user_device_id,null) as feed_item_view_device_id


      --feed click
      ,feed_item_click_cnt
      ,if(
        event_action_type = 'enter_feed_detail'
        ,user_device_id,null) as feed_item_click_device_id

      --feed detail
      ,feed_detail_click_cnt
      ,feed_item_tryon_click_cnt
      ,feed_item_remix_click_cnt
      ,feed_item_save_share_click_cnt
      ,feed_item_product_click_cnt
      ,feed_item_detail_pv_cnt
      ,if(refer in ('feed_detail','product_detail') 
        and event_name = "select_item" 
        and event_method = 'click' 
        and ap_name like 'ap_%'
        ,user_device_id,null) as feed_item_detail_click_device_id

      --product detail
      ,feed_product_detail_click_cnt
      ,feed_product_detail_pv_cnt
      ,if(refer in ('product_detail','pseudo_product_detail'),user_device_id,null) as feed_product_detail_device_id

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
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,event_source

      --feed info
      ,item_type
      ,item_intention
      ,feed_source

      --home
      ,home_pv_cnt
      ,home_device_id

      --feed item list
      ,feed_item_list_pv_cnt
      ,feed_item_list_device_id

      --feed item view
      ,feed_item_view_pv_cnt
      ,feed_item_view_device_id

      --feed click
      ,feed_item_click_cnt
      ,feed_item_click_device_id

      --feed detail
      ,feed_detail_click_cnt
      ,feed_item_tryon_click_cnt
      ,feed_item_remix_click_cnt
      ,feed_item_save_share_click_cnt
      ,feed_item_product_click_cnt
      ,feed_item_detail_pv_cnt
      ,feed_item_detail_click_device_id

      --product detail
      ,feed_product_detail_click_cnt
      ,feed_product_detail_pv_cnt
      ,feed_product_detail_device_id
    FROM base_dws_data_with_uv
```

---

**文档生成**: 2026-01-30 13:42:02
**扫描工具**: scan_functions.py
