with user_dau as (
    select 
      dt,
      country_name,
      platform,
      app_version,
      user_login_type,
      user_tenure_type,
      user_group,
      sum(active_user_d1_cnt) as active_user_d1_cnt
    from favie_rpt.rpt_gensmo_user_active_metrics_inc_1d
    where dt is not null and  dt = dt_param
    GROUP BY
      dt,
      country_name,
      platform,
      app_version,
      user_login_type,
      user_tenure_type,
      user_group

  ),

  metric_with_uv as (
    select 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,

      --home
      sum(home_pv_cnt) as home_pv_cnt,
      count(distinct home_device_id) as home_user_cnt,

      --feed list
      sum(feed_item_list_pv_cnt) as feed_item_list_pv_cnt,
      count(distinct feed_item_list_device_id) as feed_item_list_user_cnt, 

      --feed view
      sum(feed_item_view_pv_cnt) as feed_item_view_pv_cnt,
      count(distinct feed_item_view_device_id) as feed_item_view_user_cnt,

      --feed click
      sum(feed_item_click_cnt) as feed_item_click_cnt,
      count(distinct feed_item_click_device_id) as feed_item_click_user_cnt,

      --feed detail
      sum(feed_detail_click_cnt) as feed_detail_click_cnt,
      sum(feed_item_tryon_click_cnt) as feed_item_tryon_click_cnt,
      sum(feed_item_remix_click_cnt) as feed_item_remix_click_cnt,
      sum(feed_item_save_share_click_cnt) as feed_item_save_share_click_cnt,
      sum(feed_item_product_click_cnt) as feed_item_product_click_cnt,
      sum(feed_item_detail_pv_cnt) as feed_item_detail_pv_cnt,
      count(distinct feed_item_detail_click_device_id) as feed_item_detail_click_user_cnt,

      --product detail
      sum(feed_product_detail_click_cnt) as feed_product_detail_click_cnt,
      sum(feed_product_detail_pv_cnt) as feed_product_detail_pv_cnt,
      count(distinct feed_product_detail_device_id) as feed_product_detail_user_cnt

    from favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d 
    where dt = dt_param
    group by 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group
  ),

  metric_with_dau as (
    select 
      coalesce(t1.dt,t2.dt) as dt,
      coalesce(t1.platform,t2.platform) as platform,
      coalesce(t1.app_version,t2.app_version) as app_version,
      coalesce(t1.country_name,t2.country_name) as country_name,
      coalesce(t1.user_login_type,t2.user_login_type) as user_login_type,
      coalesce(t1.user_tenure_type,t2.user_tenure_type) as user_tenure_type,
      coalesce(t1.user_group,t2.user_group) as user_group,

      --app
      t2.active_user_d1_cnt,

      --home
      t1.home_pv_cnt,
      t1.home_user_cnt,

      --feed list
      t1.feed_item_list_pv_cnt,
      t1.feed_item_list_user_cnt,

      --feed view
      t1.feed_item_view_pv_cnt,
      t1.feed_item_view_user_cnt,

      --feed click
      t1.feed_item_click_cnt,
      t1.feed_item_click_user_cnt,

      --feed detail
      t1.feed_detail_click_cnt,
      t1.feed_item_tryon_click_cnt,
      t1.feed_item_remix_click_cnt,
      t1.feed_item_save_share_click_cnt,
      t1.feed_item_product_click_cnt,
      t1.feed_item_detail_pv_cnt,
      t1.feed_item_detail_click_user_cnt

      --product detail
      ,t1.feed_product_detail_click_cnt,
      t1.feed_product_detail_pv_cnt,
      t1.feed_product_detail_user_cnt

    from metric_with_uv t1
    full outer join user_dau t2
    on t1.dt = t2.dt
    and t1.platform = t2.platform
    and t1.app_version = t2.app_version
    and t1.country_name = t2.country_name
    and t1.user_login_type = t2.user_login_type
    and t1.user_tenure_type = t2.user_tenure_type
    and t1.user_group = t2.user_group
  )

  SELECT
    dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,

    --app
    active_user_d1_cnt,

    --home
    home_pv_cnt,
    home_user_cnt,

    --feed list
    feed_item_list_pv_cnt,
    feed_item_list_user_cnt,

    --feed view
    feed_item_view_pv_cnt,
    feed_item_view_user_cnt,

    --feed click
    feed_item_click_cnt,
    feed_item_click_user_cnt,

    --feed detail
    feed_detail_click_cnt,
    feed_item_tryon_click_cnt,
    feed_item_remix_click_cnt,
    feed_item_save_share_click_cnt,
    feed_item_product_click_cnt,
    feed_item_detail_pv_cnt,
    feed_item_detail_click_user_cnt,

    --product detail
    feed_product_detail_click_cnt,
    feed_product_detail_pv_cnt,
    feed_product_detail_user_cnt
  FROM metric_with_dau