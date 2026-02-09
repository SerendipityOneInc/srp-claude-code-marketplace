# dwd_favie_gensmo_events_items_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-08
**最后更新**: 2025-12-08

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
      DELETE FROM `favie_dw.dwd_favie_gensmo_events_items_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dwd_favie_gensmo_events_items_inc_1d` (
        dt,
        session_id,
        user_id,
        device_id,
        refer,
        refer_pv_seq,
        pre_refer,
        cal_pre_refer,
        cal_pre_refer_event,
        cal_next_refer,
        cal_refer_last_event,
        ap_name,
        
        user_pseudo_id,
        user_login_type,

        event_name,
        event_method,
        event_action_type,
        event_ab_infos,
        event_item,

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
        cal_next_refer,
        cal_refer_last_event,
        ap_name,
        
        user_pseudo_id,
        user_login_type,

        event_name,
        event_method,
        event_action_type,
        event_ab_infos,
        event_item,

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
      FROM `favie_dw.dwd_favie_gensmo_events_items_inc_1d_function`(dt_param);
      call favie_dw.record_partition('favie_dw.dwd_favie_gensmo_events_items_inc_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
