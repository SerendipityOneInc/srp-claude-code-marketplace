BEGIN
    --   DECLARE n_day int64 default 2;
    DECLARE current_dt DATE;
    SET current_dt = dt_param;

    WHILE n_day >= 1 DO
        DELETE FROM favie_dw.dws_gem_user_feature_with_ad_info_inc_1d
        WHERE dt = current_dt;

        INSERT INTO favie_dw.dws_gem_user_feature_with_ad_info_inc_1d(
            dt,
            device_id,
            first_device_id,
            user_event_appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,
            last_access_at,

            last_day_feature_geo_continent_name,
            last_day_feature_geo_sub_continent_name,
            last_day_feature_geo_country_name,
            last_day_feature_geo_region_name,
            last_day_feature_geo_metro_name,
            last_day_feature_geo_city_name,
            last_day_feature_access_at,
            last_day_feature_login_type,
            last_day_feature_duration,
            last_day_feature_platform,
            last_day_feature_app_version,
            last_day_feature_action_types_with_count,

            last_30_days_feature_geo_continent_name,
            last_30_days_feature_geo_sub_continent_name,
            last_30_days_feature_geo_country_name,
            last_30_days_feature_geo_region_name,
            last_30_days_feature_geo_metro_name,
            last_30_days_feature_geo_city_name,
            last_30_days_feature_action_types_with_count,

            af_event_time,
            af_platform,
            af_event_name,
            app_name,
            source,
            channel,
            campaign_name,
            campaign_id,
            ad_group_name,
            ad_group_id,
            ad_id,
            ad_name,
            af_event_seq
        )
        SELECT 
            user_event_dt AS dt,
            device_id,
            first_device_id,
            user_event_appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,
            last_access_at,
            
            last_day_feature_geo_continent_name,
            last_day_feature_geo_sub_continent_name,
            last_day_feature_geo_country_name,
            last_day_feature_geo_region_name,
            last_day_feature_geo_metro_name,
            last_day_feature_geo_city_name,
            last_day_feature_access_at,
            last_day_feature_login_type,
            last_day_feature_duration,
            last_day_feature_platform,
            last_day_feature_app_version,
            last_day_feature_action_types_with_count,

            last_30_days_feature_geo_continent_name,
            last_30_days_feature_geo_sub_continent_name,
            last_30_days_feature_geo_country_name,
            last_30_days_feature_geo_region_name,
            last_30_days_feature_geo_metro_name,
            last_30_days_feature_geo_city_name,
            last_30_days_feature_action_types_with_count,

            af_event_time,
            af_platform,
            af_event_name,
            app_name,
            source,
            channel,
            campaign_name,
            campaign_id,
            ad_group_name,
            ad_group_id,
            ad_id,
            ad_name,
            af_event_seq
        FROM favie_dw.dws_gem_user_feature_with_ad_info_inc_1d_function(current_dt);

        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END