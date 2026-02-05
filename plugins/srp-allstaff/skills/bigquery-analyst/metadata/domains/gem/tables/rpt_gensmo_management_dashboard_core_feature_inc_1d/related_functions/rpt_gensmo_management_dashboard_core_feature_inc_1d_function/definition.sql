with install as (
    select
      *
    from favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view
    where app_name= 'Gensmo'
  )

  ,device as (
    select 
      d.dt
      ,d.device_id
      ,d.appsflyer_id
      ,d.user_type
      ,date(d.created_at) as created_dt
      ,d.last_day_feature.geo_country_name as country
      ,d.last_day_feature.login_type as login_type
      ,d.last_day_feature.platform as platform
      ,d.last_day_feature.app_version as app_version
      ,i.source as media_source
    from (
      select *
      from favie_dw.dws_favie_gensmo_user_feature_inc_1d
      where 1=1
        and is_internal_user is false 
        and dt = dt_param
    ) d
    left join install i
    on d.appsflyer_id = i.appsflyer_id
  )

  ,event as (
    select 
      d.device_id
      ,d.created_dt
      ,d.media_source
      ,d.country
      ,d.platform
      ,d.app_version
      ,d.login_type
      ,d.user_type
      ,e.dt
      ,e.event_uuid
      ,e.event_name
      ,e.refer
      ,e.ap_name
      ,e.event_method
      ,e.event_action_type
      ,e.event_items
      ,e.event_version
      ,e.event_timestamp
      ,e.event_interval
    from (
      select * 
      from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
      where 1=1
        and device_id is not null
        and refer_group = 'valid'
        and dt = dt_param
    ) e
    join device d
    on e.device_id = d.device_id
      and e.dt = d.dt
  )

  ,event_with_duration as (
    select *,
      case 
        when event_interval >= 30000 then 0 
        else event_interval
      end as duration
    from event
  )

  SELECT 
    dt
    ,case 
      when dt < created_dt then 'irregular_dt' 
      when dt = created_dt then 'new'
      when date_diff(dt, created_dt, day) between 1 and 6 then '1_6_days'
      when date_diff(dt, created_dt, day) between 7 and 29 then '7_29_days'
    else 'above_30_days' end as is_new_user
    ,coalesce(media_source, 'unknown') as ad_media_source
    ,coalesce(country, 'unknown') AS user_country
    ,coalesce(platform, 'unknown') as last_platform
    ,coalesce(app_version, 'unknown') as last_app_version
    ,coalesce(user_type, 'unknown') as user_type
    ,count(distinct device_id) as total_active_user
    ,sum(duration)/1000 as total_active_seconds
    
    ,count(
      distinct(
        case when 1=1
          and login_type = 'login'
        then device_id
        else null
        end
      )
    ) as login_uv
    
    -- 模特生成页展示 (Avatar Start Page Show)
    ,count(
      distinct(
        case when 1=1
          and event_method = 'page_view'
          and refer = 'create_replica'
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as avatar_start_page_show_uv
    ,sum(
      case when 1=1
        and event_method = 'page_view'
        and refer = 'create_replica'
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as avatar_start_page_show_pv

    -- *NEW* 进入任一流程 (Enter Any Flow - Default or Selfie)
    ,count(
      distinct(
        case when 1=1
          and event_method = 'click'
          and refer = 'create_replica'
          and (ap_name = 'ap_use_default_avatar_btn' or ap_name = 'ap_upload_selfie_cta_btn')
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as enter_any_flow_uv
    ,sum(
      case when 1=1
          and event_method = 'click'
          and refer = 'create_replica'
          and (ap_name = 'ap_use_default_avatar_btn' or ap_name = 'ap_upload_selfie_cta_btn')
          and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as enter_any_flow_pv

    -- *NEW* 完成任一创建 (Complete Any Creation - Default or Selfie)
    ,count(
      distinct(
        case when 1=1
          and (
              ap_name = 'ap_avatar_generate_btn' -- Complete Selfie
              OR (ap_name = 'ap_confirm_btn' and refer = 'select_model') -- Complete Default
          )
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as complete_any_creation_uv
    ,sum(
      case when 1=1
          and (
              ap_name = 'ap_avatar_generate_btn' -- Complete Selfie
              OR (ap_name = 'ap_confirm_btn' and refer = 'select_model') -- Complete Default
          )
          and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as complete_any_creation_pv

    -- 进入 default 流程 (Enter Default Flow)
    ,count(
      distinct(
        case when 1=1
          and event_method = 'click'
          and refer = 'create_replica'
          and ap_name = 'ap_use_default_avatar_btn'
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as enter_default_flow_uv
    ,sum(
      case when 1=1
        and event_method = 'click'
        and refer = 'create_replica'
        and ap_name = 'ap_use_default_avatar_btn'
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as enter_default_flow_pv

    -- 完成 default 创建 (Complete Default Creation)
    ,count(
      distinct(
        case when 1=1
          and ap_name = 'ap_confirm_btn'
          and refer = 'select_model'
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as complete_default_creation_uv
    ,sum(
      case when 1=1
        and ap_name = 'ap_confirm_btn'
        and refer = 'select_model'
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as complete_default_creation_pv

    -- 进入 selfie 流程 (Enter Selfie Flow)
    ,count(
      distinct(
        case when 1=1
          and event_method = 'click'
          and refer = 'create_replica'
          and ap_name = 'ap_upload_selfie_cta_btn'
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as enter_selfie_flow_uv
    ,sum(
      case when 1=1
        and event_method = 'click'
        and refer = 'create_replica'
        and ap_name = 'ap_upload_selfie_cta_btn'
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as enter_selfie_flow_pv

    -- 完成 selfie 创建 (Complete Selfie Creation)
    ,count(
      distinct(
        case when 1=1
          and ap_name = 'ap_avatar_generate_btn'
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as complete_selfie_creation_uv
    ,sum(
      case when 1=1
        and ap_name = 'ap_avatar_generate_btn'
        and event_version = '1.0.0'
        -- Assuming ap_name is sufficient, add more conditions if needed
      then 1
      else 0
      end
    ) as complete_selfie_creation_pv

    -- *NEW* feed 真实曝光 (Feed True View Trigger)
    ,count(
      distinct(
        case when 1=1
          and refer in ('home', 'feed', 'hashtag_page', 'feed_detail')
          and event_method = 'true_view_trigger'
          and (ap_name like 'ap_dual_column_feed%' or ap_name like '%feed_list%')
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as feed_true_view_uv
    ,sum(
      case when 1=1
        and refer in ('home', 'feed', 'hashtag_page', 'feed_detail')
        and event_method = 'true_view_trigger'
        and (ap_name like 'ap_dual_column_feed%' or ap_name like '%feed_list%')
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as feed_true_view_pv

    -- *NEW* feed 交互 (Feed Interaction)
    ,count(
      distinct(
        case when 1=1
          and (
            (
              refer in ('home', 'feed', 'hashtag_page', 'feed_detail') 
              and (
                ap_name like 'ap_dual_column_feed%' 
                or ap_name like '%feed_list%'
              )
            ) 
            or (
              refer in ('home', 'feed') 
              and ap_name = 'ap_try_on_btn'
            )
          )
          and event_method = 'click'
          and event_action_type not in ('like', 'cancel_like')
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as feed_interaction_uv
    ,sum(
      case when 1=1
        and (
          (
            refer in ('home', 'feed', 'hashtag_page', 'feed_detail') 
            and (
              ap_name like 'ap_dual_column_feed%' 
              or ap_name like '%feed_list%'
            )
          ) 
          or (
            refer in ('home', 'feed') 
            and ap_name = 'ap_try_on_btn'
          )
        )
        and event_method = 'click'
        and event_action_type not in ('like', 'cancel_like')
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as feed_interaction_pv

    -- *NEW* feed 详情页曝光 (Feed Detail Page View)
    ,count(
      distinct(
        case when 1=1
          and refer = 'feed_detail'
          and event_method = 'page_view'
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as feed_detail_page_view_uv
    ,sum(
      case when 1=1
        and refer = 'feed_detail'
        and event_method = 'page_view'
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as feed_detail_page_view_pv

    -- 全部搜索
    ,count(
      distinct(
        case when 1=1
          and event_action_type = 'collage_gen_complete'
          and event_version = '1.0.0'
        then device_id
        else null
        end
      )
    ) as search_uv
    ,sum(
      case when 1=1
        and event_action_type = 'collage_gen_complete'
        and event_version = '1.0.0'
      then 1
      else 0
      end
    ) as search_pv

    -- 文搜 (Text Search)
    ,0 as query_text_only_uv
    ,0 as query_text_only_pv

    -- 图搜 (Image Search)
    ,0 as query_text_pic_uv
    ,0 as query_text_pic_pv

    ,count(
        distinct(
            case when 1=1
              and event_action_type = 'try_on_complete'
              and event_version = '1.0.0'
            then device_id
            else null
            end
        )
    ) as try_on_uv
    ,sum(
        case when 1=1
            and event_action_type = 'try_on_complete'
            and event_version = '1.0.0'
        then 1
        else 0
        end
    ) as try_on_pv

  FROM event_with_duration
  where 1=1 
  group by 1,2,3,4,5,6,7