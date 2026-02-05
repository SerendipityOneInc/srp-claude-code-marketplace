WITH base_events_data AS (
    SELECT 
      dt,
      -- User Info
      device_id,

      -- Event Info
      refer,
      cal_pre_refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      CONCAT(COALESCE(cal_pre_refer, "unknown"), "@", COALESCE(refer, "unknown"), "@", COALESCE(ap_name, "unknown")) AS event_source,

      -- Save Info
      event_item.item_id AS item_id,
      event_item.item_type AS item_type,
      event_uuid
    FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d 
    WHERE event_timestamp IS NOT NULL 
      AND refer IS NOT NULL 
      AND platform IS NOT NULL
      AND event_version = '1.0.0' 
      AND dt = dt_param
      and event_item.item_type not in ("channel","collage_gen_task")
  ),

  dim_gem_moodboard_with_rank AS (
    SELECT 
      moodboard_id,
      intention,
      updated_time,
      ROW_NUMBER() OVER (PARTITION BY moodboard_id ORDER BY updated_time DESC) AS rn
    FROM srpproduct-dc37e.favie_dw.dim_gem_moodboard_view
  ),

  base_events_data_with_item_intention AS (
    SELECT 
      t1.dt,
      -- User Info
      t1.device_id,

      -- Event Info
      t1.refer,
      t1.cal_pre_refer,
      t1.ap_name,
      t1.event_name,
      t1.event_method,
      t1.event_action_type,
      t1.event_source,

      -- Feed Info
      t1.item_id,
      t1.item_type,
      t1.event_uuid,
      COALESCE(t2.intention, t1.item_type) AS item_intention
    FROM base_events_data AS t1
    LEFT OUTER JOIN (
      SELECT * FROM dim_gem_moodboard_with_rank WHERE rn = 1
    ) AS t2
    ON t1.item_id = t2.moodboard_id
  ),

  base_dws_data AS (
    SELECT 
      dt,
      -- User Info
      device_id,

      -- Event Info
      refer,
      cal_pre_refer,
      ap_name,
      event_name,
      event_method,
      event_source,
      event_action_type,

      -- Feed Info
      item_type,
      item_intention,

      -- Total
      count(distinct IF(
        event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', event_uuid, null
      )) AS total_save_click_cnt,

      -- Feed Detail
      count(distinct IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', event_uuid, null
      )) AS feed_detail_save_click_cnt,

      count(distinct IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND item_intention = 'similar'
        AND event_action_type='save', event_uuid, null
      )) AS feed_item_similar_save_click_cnt,

      count(distinct IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'try_on_collage', event_uuid, null
      )) AS feed_item_tryon_save_click_cnt,

      count(distinct IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'general_collage', event_uuid, null
      )) AS feed_item_general_save_click_cnt,

      count(distinct IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'product', event_uuid, null
      )) AS feed_item_product_save_click_cnt,

      count(distinct IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'styling', event_uuid, null
      )) AS feed_item_styling_save_click_cnt,

      -- Try On Gen
      count(distinct IF(
        refer = 'try_on_gen' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', event_uuid, null
      )) AS tryon_gen_save_click_cnt,

      -- Product Detail
      count(distinct IF(
        refer = 'product_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', event_uuid, null
      )) AS product_detail_save_click_cnt,

      -- Product Detail from Search
      count(distinct IF(
        refer = 'product_detail_from_search' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', event_uuid, null
      )) AS product_detail_from_search_save_click_cnt,

      -- Full Screen Pic
      count(distinct IF(
        refer = 'full_screen_pic' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', event_uuid, null
      )) AS full_screen_pic_save_click_cnt,

      -- Collage Gen
      count(distinct IF(
        refer = 'collage_gen' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', event_uuid, null
      )) AS collage_gen_save_click_cnt

    FROM base_events_data_with_item_intention
    GROUP BY  
      dt, device_id, refer, cal_pre_refer, ap_name, event_name, event_method, event_source,event_action_type, item_type, item_intention
  ),

  -- user_info AS (
  --   SELECT 
  --     device_id,
  --     created_at,
  --     last_day_feature.platform as last_platform,
  --     last_day_feature.app_version as last_app_version,
  --     last_30_days_feature.geo_country_name as geo_country_name,
  --     last_day_feature.login_type as last_login_type,
  --     user_tenure_type
  --   FROM srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d
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
    from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` 
    where dt = dt_param
  ),

  base_dws_data_with_user AS (
    SELECT 
      t1.dt,
      -- User Info
      t2.platform,
      t2.app_version,
      t2.country_name,
      t2.user_login_type,
      t2.user_tenure_type,
      t2.user_group,
      t1.device_id,
      t2.device_id AS user_device_id,

      -- Event Info
      t1.refer,
      t1.cal_pre_refer,
      t1.ap_name,
      t1.event_name,
      t1.event_method,
      t1.event_source,
      t1.event_action_type,

      -- Feed Info
      t1.item_type,
      t1.item_intention,

      -- Total
      t1.total_save_click_cnt,

      -- Feed Detail
      t1.feed_detail_save_click_cnt,
      t1.feed_item_similar_save_click_cnt,
      t1.feed_item_tryon_save_click_cnt,
      t1.feed_item_general_save_click_cnt,
      t1.feed_item_product_save_click_cnt,
      t1.feed_item_styling_save_click_cnt,

      -- Try On Gen
      t1.tryon_gen_save_click_cnt,

      -- Product Detail
      t1.product_detail_save_click_cnt,

      -- Product Detail from Search
      t1.product_detail_from_search_save_click_cnt,

      -- Full Screen Pic
      t1.full_screen_pic_save_click_cnt,

      -- Collage Gen
      t1.collage_gen_save_click_cnt
    FROM base_dws_data AS t1
    LEFT OUTER JOIN user_info_with_group t2
    ON t1.device_id = t2.device_id
  ),

  base_dws_data_with_uv AS (
    SELECT
      dt,
      -- User Info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      device_id,

      -- Event Info
      refer,
      cal_pre_refer,
      ap_name,
      event_name,
      event_method,
      event_source,
      event_action_type,

      -- Feed Info
      item_type,
      item_intention,

      -- Total
      total_save_click_cnt,
      IF(
        event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', 
        user_device_id, NULL
      ) AS total_save_click_device_id,

      -- Feed Detail
      if(refer = "feed_detail" and event_name = "select_item" and event_method = 'page_view'
        ,user_device_id, NULL) as feed_detail_device_id,
      feed_detail_save_click_cnt,
      IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', 
        user_device_id, NULL
      ) AS feed_detail_save_click_device_id,
      
      feed_item_similar_save_click_cnt,
      IF(
              refer = 'feed_detail' 
              AND event_method = 'click' 
              AND event_name = "select_item"
              AND event_action_type='save'
              AND item_intention = 'similar', user_device_id, NULL
            ) AS feed_item_similar_save_click_device_id,
      feed_item_tryon_save_click_cnt,
      IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'try_on_collage', user_device_id, NULL
      ) AS feed_item_tryon_save_click_device_id,
      feed_item_general_save_click_cnt,
      IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'general_collage', user_device_id, NULL
      ) AS feed_item_general_save_click_device_id,
      feed_item_product_save_click_cnt,
      IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'product',user_device_id, NULL
      ) AS feed_item_product_save_click_device_id,
      feed_item_styling_save_click_cnt,
      IF(
        refer = 'feed_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save'
        AND item_intention = 'styling', user_device_id, NULL
      ) AS feed_item_styling_save_click_device_id,

      -- Try On Gen
      if(refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage") and event_name='select_item' and event_method='page_view'
        ,user_device_id, NULL) as tryon_gen_device_id,
      tryon_gen_save_click_cnt,
      IF(
        refer = 'try_on_gen' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', 
        user_device_id, NULL
      ) AS tryon_gen_save_click_device_id,

      -- Product Detail
      product_detail_save_click_cnt,
      IF(
        refer = 'product_detail' 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', 
        user_device_id, NULL
      ) AS product_detail_save_click_device_id,

      -- Product Detail from Search
      product_detail_from_search_save_click_cnt,
      IF(
        refer IN ('product_detail_from_search') 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', 
        user_device_id, NULL
      ) AS product_detail_from_search_save_click_device_id,

      -- Full Screen Pic
      full_screen_pic_save_click_cnt,
      IF(
        refer IN ('full_screen_pic') 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', 
        user_device_id, NULL
      ) AS full_screen_pic_save_click_device_id,

      -- Collage Gen
      if(refer = "collage_gen" and event_name = "select_item" and event_method = 'page_view'
        ,user_device_id, NULL) as collage_gen_device_id,
      collage_gen_save_click_cnt,
      IF(
        refer IN ('collage_gen') 
        AND event_method = 'click' 
        AND event_name = "select_item"
        AND event_action_type='save', 
        user_device_id, NULL
      ) AS collage_gen_save_click_device_id
    FROM base_dws_data_with_user
    WHERE user_device_id IS NOT NULL
  )

  SELECT
    dt,
    -- User Info
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    device_id,

    -- Event Info      
    refer,
    cal_pre_refer,
    ap_name,
    event_name,
    event_method,
    event_source,
    event_action_type,

    -- Feed Info
    item_type,
    item_intention,

    -- Total
    total_save_click_cnt,
    total_save_click_device_id,

    -- Feed Detail
    feed_detail_device_id,
    feed_detail_save_click_cnt,
    feed_detail_save_click_device_id,
    feed_item_similar_save_click_cnt,
    feed_item_similar_save_click_device_id,
    feed_item_tryon_save_click_cnt,
    feed_item_tryon_save_click_device_id,
    feed_item_general_save_click_cnt,
    feed_item_general_save_click_device_id,
    feed_item_product_save_click_cnt,
    feed_item_product_save_click_device_id,
    feed_item_styling_save_click_cnt,
    feed_item_styling_save_click_device_id,

    -- Try On Gen
    tryon_gen_device_id,
    tryon_gen_save_click_cnt,
    tryon_gen_save_click_device_id,

    -- Product Detail
    product_detail_save_click_cnt,
    product_detail_save_click_device_id,

    -- Product Detail from Search
    product_detail_from_search_save_click_cnt,
    product_detail_from_search_save_click_device_id,

    -- Full Screen Pic
    full_screen_pic_save_click_cnt,
    full_screen_pic_save_click_device_id,

    -- Collage Gen
    collage_gen_device_id,
    collage_gen_save_click_cnt,
    collage_gen_save_click_device_id
  FROM base_dws_data_with_uv