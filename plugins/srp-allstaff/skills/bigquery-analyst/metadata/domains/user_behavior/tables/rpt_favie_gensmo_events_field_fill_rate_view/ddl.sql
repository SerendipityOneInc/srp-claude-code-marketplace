CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_events_field_fill_rate_view`
AS WITH fill_rates AS (
    SELECT 
      dt, event_name, event_version,
      'session_id' AS field_name, COUNT(session_id) * 1.0 / COUNT(*) AS fill_rate
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'user_id', COUNT(user_id) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_id', COUNT(device_id) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'refer', COUNT(refer) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'pre_refer', COUNT(pre_refer) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'ap_name', COUNT(ap_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'user_pseudo_id', COUNT(user_pseudo_id) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'user_is_active', COUNT(user_is_active) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'user_type', COUNT(user_type) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'event_method', COUNT(event_method) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'event_action_type', COUNT(event_action_type) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'event_ab_infos', COUNT(event_ab_infos) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'event_items', COUNT(IF(ARRAY_LENGTH(event_items) > 0, 1, NULL)) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'event_timestamp', COUNT(event_timestamp) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'geo_continent_name', COUNT(geo_continent_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'geo_sub_continent_name', COUNT(geo_sub_continent_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'geo_region_name', COUNT(geo_region_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'geo_metro_name', COUNT(geo_metro_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'geo_country_name', COUNT(geo_country_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'geo_city_name', COUNT(geo_city_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_category', COUNT(device_category) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_mobile_brand_name', COUNT(device_mobile_brand_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_mobile_model_name_name', COUNT(device_mobile_model_name_name) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_mobile_os_hardware_model', COUNT(device_mobile_os_hardware_model) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_operating_system', COUNT(device_operating_system) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_operating_system_version', COUNT(device_operating_system_version) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_vendor_id', COUNT(device_vendor_id) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_language', COUNT(device_language) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'device_is_limited_ad_tracking', COUNT(device_is_limited_ad_tracking) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'platform', COUNT(platform) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'app_version', COUNT(app_version) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'utm_source', COUNT(utm_source) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'stream_id', COUNT(stream_id) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version

    UNION ALL

    SELECT 
      dt, event_name, event_version,
      'event_version', COUNT(event_version) * 1.0 / COUNT(*)
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY dt, event_name, event_version
  )
  SELECT
    event_name,
    event_version,
    field_name,
    fill_rate,
    dt
  FROM fill_rates;