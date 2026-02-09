CREATE VIEW `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
AS SELECT 
      dt,
      device_id,
      device_id as first_device_id,
      appsflyer_id,
      is_internal_user,
      user_type,
      user_tenure_type,
      user_created_at as created_at,
      struct(
        geo_address.geo_continent_name as geo_continent_name,
        geo_address.geo_sub_continent_name as geo_sub_continent_name,
        geo_address.geo_country_name as geo_country_name,
        geo_address.geo_region_name as geo_region_name,
        geo_address.geo_metro_name as geo_metro_name,
        geo_address.geo_city_name as geo_city_name,
        appsflyer_id as appsflyer_id,
        last_event_timestamp as access_at,
        user_login_type as login_type,
        user_duration as duration,
        app_info.platform,
        app_info.app_version,
        cast(null as ARRAY<STRING>) as action_types,
        ARRAY(
          select 
            struct(
              common_action.action_type as event_action_type,
              common_action.action_cnt as event_action_type_count
            )
          from unnest(common_actions) as common_action
        ) as action_types_with_count
      ) as last_day_feature,
      cast(null as 
        struct<
          geo_continent_name STRING,
          geo_sub_continent_name STRING,
          geo_country_name STRING,
          geo_region_name STRING,
          geo_metro_name STRING,
          geo_city_name STRING,
          action_types ARRAY<STRING>,
          action_types_with_count ARRAY<STRUCT<
            event_action_type STRING,
            event_action_type_count INT64
          >> 
        > 
      ) as last_30_days_feature,
      last_event_timestamp as last_access_at
    FROM favie_dw.dws_gensmo_user_activity_profile_inc_1d
    WHERE dt is not null;