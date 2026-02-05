WITH dau AS (
    SELECT
      dt,
      device_id
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
    WHERE dt = dt_param
      AND event_method NOT IN ('app_launch','app_foreground','app_background')
    GROUP BY dt, device_id
  ),

  -- 2) 仅保留 DAU 范围内的用户
  base AS (
    SELECT
      e.dt,  
      e.event_item.item_id AS item_id,  
      e.event_item.item_type  AS item_type,
      e.device_id,  
      e.refer,  
      e.event_method,
      e.event_action_type, 
      e.ap_name,
      e.event_name,
      c.category AS feed_type,
      c.production_type
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d` e 
    -- 用 DAU 做内连接限制
    JOIN dau d
      ON e.dt = d.dt
     AND e.device_id = d.device_id
    LEFT JOIN `srpproduct-dc37e.favie_dw.dwd_gem_operation_feed_full` c
      ON e.event_item.item_id = c.collage_id
    WHERE e.dt = dt_param
  ),

  agg AS (
    SELECT
      dt,
      item_type,
      device_id,
      refer,
      feed_type,
      production_type,

      COUNT(CASE WHEN
        event_name='select_item' 
        AND event_method = 'true_view_trigger' 
        AND item_type!='reco' 
        THEN device_id END
      ) AS feed_view_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND item_type !='reco'
        AND event_action_type = 'enter_feed_detail'
        THEN device_id END
      ) AS feed_click_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type = 'like' 
        AND item_type !='reco'
        THEN device_id END
      ) AS feed_like_click_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type ='try_on' 
        AND item_type !='reco'
        THEN device_id END
      ) AS feed_try_on_pv_cnt,

      -- ✅ 改为 try_on_trigger
      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type ='try_on_trigger' 
        AND refer='feed_detail'
        AND ap_name='ap_try_on_btn'
        AND item_type !='reco'
        THEN device_id END
      ) AS feed_try_on_trigger_pv_cnt,

      -- ✅ 新增 remix/see it on me
      COUNT(CASE WHEN 
        event_method='click'
        AND refer='feed_detail'
        AND ap_name='ap_try_on_remix_btn'
        AND item_type!='reco'
        THEN device_id END
      ) AS feed_remix_see_it_on_me_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type = 'comment_send'
        THEN device_id END
      ) AS feed_comment_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type = 'save'
        THEN device_id END
      ) AS feed_save_pv_cnt,

      COUNT(CASE WHEN
        event_method = 'click' 
        AND event_action_type = 'product_external_jump'
        THEN device_id END
      ) AS feed_product_external_jump_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type = 'enter_product_detail'
        THEN device_id END
      ) AS feed_product_click_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type = 'external_share'
        AND refer IN('share','hashtag_page') 
        THEN device_id END
      ) AS feed_share_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'screenshot' 
        THEN device_id END
      ) AS feed_screen_shot_pv_cnt,

      COUNT(CASE WHEN 
        event_method = 'click' 
        AND event_action_type = 'enter_hashtag_detail'
        THEN device_id END
      ) AS feed_hashtag_click_pv_cnt,

      COUNT(CASE WHEN 
        ap_name='ap_hashtag_banner_list_item'
        AND event_method='true_view_trigger'
        AND item_type !='reco'
        AND refer in ('home','feed')
        THEN device_id END
      ) AS feed_editor_pick_view_pv_cnt,

      COUNT(CASE WHEN 
        ap_name='ap_hashtag_banner_list_item'
        AND event_method='click'
        AND event_action_type='enter_hashtag_detail'
        AND item_type !='reco'
        AND refer in ('home','feed')
        THEN device_id END
      ) AS feed_editor_pick_click_pv_cnt,

      COUNT(CASE WHEN 
        event_action_type='follow'
        AND event_method='click'
        THEN device_id END
      ) AS follow_click_cnt

    FROM base
    GROUP BY
      dt,
      item_type,
      device_id,
      refer,
      feed_type,
      production_type
  )

  SELECT
    a.dt,
    a.item_type,
    a.device_id,
    a.refer,
    a.feed_type,
    a.production_type,
    a.feed_view_pv_cnt,
    a.feed_click_pv_cnt,
    a.feed_like_click_pv_cnt,
    a.feed_try_on_pv_cnt, 
    a.feed_try_on_trigger_pv_cnt,         -- 新增
    a.feed_remix_see_it_on_me_pv_cnt,     -- 新增
    a.feed_comment_pv_cnt,
    a.feed_save_pv_cnt,
    a.feed_product_external_jump_pv_cnt,
    a.feed_product_click_pv_cnt,
    a.feed_share_pv_cnt,
    a.feed_screen_shot_pv_cnt,
    a.feed_hashtag_click_pv_cnt,
    a.feed_editor_pick_view_pv_cnt,
    a.feed_editor_pick_click_pv_cnt,
    a.follow_click_cnt,
    u.user_group,
    u.country_name,
    u.platform,
    u.app_version,
    u.user_login_type,
    u.user_tenure_type
  FROM agg a
  LEFT JOIN (select * from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)) u
    ON a.device_id = u.device_id
   AND a.dt = u.dt