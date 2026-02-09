BEGIN
      DELETE FROM `favie_dw.dwd_favie_gensmo_events_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dwd_favie_gensmo_events_inc_1d` (
        dt,
        session_id,
        user_id,
        device_id,
        refer,
        refer_pv_seq,
        pre_refer,
        cal_pre_refer,
        cal_pre_refer_event,
        cal_pre_refer_event_items,
        cal_next_refer,
        cal_refer_last_event,
        cal_refer_last_event_items,
        ap_name,
        
        user_pseudo_id,
        user_login_type,

        event_name,
        event_method,
        event_action_type,
        event_ab_infos,
        event_items,

        event_interval,
        event_version,
        event_source,
        event_timestamp, 
        event_uuid,

        geo_continent_name,
        geo_sub_continent_name,
        geo_region_name,
        geo_metro_name,
        geo_country_name,
        geo_city_name,

        device_category,
        device_mobile_brand_name,
        device_mobile_model_name,
        device_mobile_os_hardware_model,
        device_operating_system,
        device_operating_system_version,
        device_vendor_id,
        device_language,
        device_is_limited_ad_tracking,

        platform,
        app_version,
        web_version,
        utm_source,
        stream_id,
        appsflyer_id,

        home_request_seq,
        home_request_first_event_name,
        home_request_first_event_method,
        home_request_first_event_action_type,
        home_request_first_event_ap_name,
        home_request_first_event_items,

        app_version_seq,
        web_version_seq,
        event_version_seq,
        refer_group
      )
      SELECT
        dt,
        session_id,
        user_id,
        device_id,
        refer,
        refer_pv_seq,
        pre_refer,
        cal_pre_refer,
        cal_pre_refer_event,
        cal_pre_refer_event_items,
        cal_next_refer,
        cal_refer_last_event,
        cal_refer_last_event_items,
        ap_name,
        
        user_pseudo_id,
        user_login_type,

        event_name,
        event_method,
        event_action_type,
        event_ab_infos,
        event_items,

        event_interval,
        event_version,
        event_source,
        event_timestamp, 
        event_uuid,

        geo_continent_name,
        geo_sub_continent_name,
        geo_region_name,
        geo_metro_name,
        geo_country_name,
        geo_city_name,

        device_category,
        device_mobile_brand_name,
        device_mobile_model_name,
        device_mobile_os_hardware_model,
        device_operating_system,
        device_operating_system_version,
        device_vendor_id,
        device_language,
        device_is_limited_ad_tracking,

        platform,
        app_version,
        web_version,
        utm_source,
        stream_id,
        appsflyer_id,

        home_request_seq,
        home_request_first_event_name,
        home_request_first_event_method,
        home_request_first_event_action_type,
        home_request_first_event_ap_name,
        home_request_first_event_items,

        app_version_seq,
        web_version_seq,
        event_version_seq,
        refer_group
      FROM `favie_dw.dwd_favie_events_with_duration_inc_1d_function`(dt_param,'gensmo');
      call favie_dw.record_partition('favie_dw.dwd_favie_gensmo_events_inc_1d', dt_param,"");
END