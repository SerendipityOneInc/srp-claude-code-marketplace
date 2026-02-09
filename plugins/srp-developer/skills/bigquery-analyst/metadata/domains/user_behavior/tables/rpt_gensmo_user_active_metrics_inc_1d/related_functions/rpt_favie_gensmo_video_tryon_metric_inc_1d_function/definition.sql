with user_dau as (
    select 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      SUM(active_user_d1_cnt) as active_user_d1_cnt
    from srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d
    where dt is not null and dt = dt_param
    group by 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group
  ),

  metric_with_uv as (
    select 
      dt,

      --user info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,

      sum(video_tryon_trigger_cnt) as video_tryon_trigger_cnt,
      count(distinct video_tryon_trigger_device_id) as video_tryon_trigger_user_cnt,

      sum(video_tryon_complete_task_cnt) as video_tryon_complete_task_cnt,
      count(distinct video_tryon_complete_device_id) as video_tryon_complete_user_cnt,

      sum(video_tryon_play_complete_task_cnt) as video_tryon_play_complete_task_cnt,
      count(distinct video_tryon_play_complete_device_id) as video_tryon_play_complete_user_cnt,

      sum(video_tryon_retry_task_cnt) as video_tryon_retry_task_cnt,
      count(distinct video_tryon_retry_device_id) as video_tryon_retry_user_cnt,

      sum(video_tryon_switch_mode_task_cnt) as video_tryon_switch_mode_task_cnt,
      count(distinct video_tryon_switch_mode_device_id) as video_tryon_switch_mode_user_cnt,

      sum(video_tryon_save_task_cnt) as video_tryon_save_task_cnt,
      count(distinct video_tryon_save_device_id) as video_tryon_save_user_cnt,

      sum(video_tryon_unsave_task_cnt) as video_tryon_unsave_task_cnt,
      count(distinct video_tryon_unsave_device_id) as video_tryon_unsave_user_cnt,

      sum(video_tryon_like_task_cnt) as video_tryon_like_task_cnt,
      count(distinct video_tryon_like_device_id) as video_tryon_like_user_cnt,

      sum(video_tryon_dislike_task_cnt) as video_tryon_dislike_task_cnt,
      count(distinct video_tryon_dislike_device_id) as video_tryon_dislike_user_cnt,

      sum(video_tryon_download_task_cnt) as video_tryon_download_task_cnt,
      count(distinct video_tryon_download_device_id) as video_tryon_download_user_cnt

    from favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d 
    where dt is not null and dt = dt_param
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

      --user info
      coalesce(t1.platform,t2.platform) as platform,
      coalesce(t1.app_version,t2.app_version) as app_version,
      coalesce(t1.country_name,t2.country_name) as country_name,
      coalesce(t1.user_login_type,t2.user_login_type) as user_login_type,
      coalesce(t1.user_tenure_type,t2.user_tenure_type) as user_tenure_type,
      coalesce(t1.user_group,t2.user_group) as user_group,

      --app
      t2.active_user_d1_cnt as active_user_d1_cnt,

      --video tryon metrics
      t1.video_tryon_trigger_cnt as video_tryon_trigger_cnt,
      t1.video_tryon_trigger_user_cnt as video_tryon_trigger_user_cnt,

      t1.video_tryon_complete_task_cnt as video_tryon_complete_task_cnt,
      t1.video_tryon_complete_user_cnt as video_tryon_complete_user_cnt,

      t1.video_tryon_play_complete_task_cnt as video_tryon_play_complete_task_cnt,
      t1.video_tryon_play_complete_user_cnt as video_tryon_play_complete_user_cnt,

      t1.video_tryon_retry_task_cnt as video_tryon_retry_task_cnt,
      t1.video_tryon_retry_user_cnt as video_tryon_retry_user_cnt,

      t1.video_tryon_switch_mode_task_cnt as video_tryon_switch_mode_task_cnt,
      t1.video_tryon_switch_mode_user_cnt as video_tryon_switch_mode_user_cnt,

      t1.video_tryon_save_task_cnt as video_tryon_save_task_cnt,
      t1.video_tryon_save_user_cnt as video_tryon_save_user_cnt,

      t1.video_tryon_unsave_task_cnt as video_tryon_unsave_task_cnt,
      t1.video_tryon_unsave_user_cnt as video_tryon_unsave_user_cnt,

      t1.video_tryon_like_task_cnt as video_tryon_like_task_cnt,
      t1.video_tryon_like_user_cnt as video_tryon_like_user_cnt,

      t1.video_tryon_dislike_task_cnt as video_tryon_dislike_task_cnt,
      t1.video_tryon_dislike_user_cnt as video_tryon_dislike_user_cnt,

      t1.video_tryon_download_task_cnt as video_tryon_download_task_cnt,
      t1.video_tryon_download_user_cnt as video_tryon_download_user_cnt
    from metric_with_uv t1 full outer join user_dau t2
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

    --user info
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,

    --app
    active_user_d1_cnt,

    --video tryon metrics
    video_tryon_trigger_cnt,
    video_tryon_trigger_user_cnt,
    video_tryon_complete_task_cnt,
    video_tryon_complete_user_cnt,
    video_tryon_play_complete_task_cnt,
    video_tryon_play_complete_user_cnt,
    video_tryon_retry_task_cnt,
    video_tryon_retry_user_cnt,
    video_tryon_switch_mode_task_cnt,
    video_tryon_switch_mode_user_cnt,
    video_tryon_save_task_cnt,
    video_tryon_save_user_cnt,
    video_tryon_unsave_task_cnt,
    video_tryon_unsave_user_cnt,
    video_tryon_like_task_cnt,
    video_tryon_like_user_cnt,
    video_tryon_dislike_task_cnt,
    video_tryon_dislike_user_cnt,
    video_tryon_download_task_cnt,
    video_tryon_download_user_cnt
  FROM metric_with_dau