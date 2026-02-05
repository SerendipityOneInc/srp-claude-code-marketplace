# dws_gem_user_feature_with_ad_info_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_user_feature_with_ad_info_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-24
**最后更新**: 2025-09-24

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
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
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
