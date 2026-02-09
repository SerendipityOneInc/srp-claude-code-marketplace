CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_user_event_field_fill_cnt_monitor_view`
AS SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'session_id' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(session_id) AS fill_cnt,
    COUNTIF(lower(session_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d    
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    'ALL' AS refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'refer' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(refer) AS fill_cnt,
    COUNTIF(lower(refer) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    'ALL' AS event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(event_name) AS fill_cnt,
    COUNTIF(lower(event_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    'ALL' AS event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_method' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(event_method) AS fill_cnt,
    COUNTIF(lower(event_method) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    'ALL' AS ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'ap_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(ap_name) AS fill_cnt,
    COUNTIF(lower(ap_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
    and not(
        event_name = "select_item"
        and event_method = "page_view"
    )
GROUP BY
    dt,
    refer,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'user_id' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(user_id) AS fill_cnt,
    COUNTIF(lower(user_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_id' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_id) AS fill_cnt,
    COUNTIF(lower(device_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'pre_refer' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(pre_refer) AS fill_cnt,
    COUNTIF(lower(pre_refer) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'user_pseudo_id' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(user_pseudo_id) AS fill_cnt,
    COUNTIF(lower(user_pseudo_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'user_login_type' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(user_login_type) AS fill_cnt,
    COUNTIF(lower(user_login_type) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'appsflyer_id' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(appsflyer_id) AS fill_cnt,
    COUNTIF(lower(appsflyer_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_action_type' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(event_action_type) AS fill_cnt,
    COUNTIF(lower(event_action_type) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_ab_infos' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(event_ab_infos) AS fill_cnt,
    0 as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_items' AS field_name,
    COUNT(1) AS event_cnt,
    COUNTIF(ARRAY_LENGTH(event_items) > 0) AS fill_cnt,
    0 as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version

UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'item_id' AS field_name,
    COUNT(1) AS event_cnt,
    count(event_item.item_id) AS fill_cnt,
    COUNTIF(lower(event_item.item_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_items_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version

UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'item_name' AS field_name,
    COUNT(1) AS event_cnt,
    count(event_item.item_name) AS fill_cnt,
    COUNTIF(lower(event_item.item_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_items_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version

UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'item_type' AS field_name,
    COUNT(1) AS event_cnt,
    count(event_item.item_type) AS fill_cnt,
    COUNTIF(lower(event_item.item_type) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_items_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version

UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'item_index' AS field_name,
    COUNT(1) AS event_cnt,
    count(event_item.item_index) AS fill_cnt,
    0 as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_items_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version

UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_timestamp' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(event_timestamp) AS fill_cnt,
    COUNTIF(event_timestamp is not null and event_timestamp=TIMESTAMP('1970-01-01 00:00:00 UTC')) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'geo_continent_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(geo_continent_name) AS fill_cnt,
    COUNTIF(lower(geo_continent_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'geo_sub_continent_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(geo_sub_continent_name) AS fill_cnt,
    COUNTIF(lower(geo_sub_continent_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'geo_region_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(geo_region_name) AS fill_cnt,
    COUNTIF(lower(geo_region_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'geo_country_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(geo_country_name) AS fill_cnt,
    COUNTIF(lower(geo_country_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'geo_metro_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(geo_metro_name) AS fill_cnt,
    COUNTIF(lower(geo_metro_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'geo_city_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(geo_city_name) AS fill_cnt,
    COUNTIF(lower(geo_city_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_category' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_category) AS fill_cnt,
    COUNTIF(lower(device_category) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_mobile_brand_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_mobile_brand_name) AS fill_cnt,
    COUNTIF(lower(device_mobile_brand_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_mobile_model_name' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_mobile_model_name) AS fill_cnt,
    COUNTIF(lower(device_mobile_model_name) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_mobile_os_hardware_model' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_mobile_os_hardware_model) AS fill_cnt,
    COUNTIF(lower(device_mobile_os_hardware_model) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_operating_system' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_operating_system) AS fill_cnt,
    COUNTIF(lower(device_operating_system) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_operating_system_version' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_operating_system_version) AS fill_cnt,
    COUNTIF(lower(device_operating_system_version) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_vendor_id' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_vendor_id) AS fill_cnt,
    COUNTIF(lower(device_vendor_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_language' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_language) AS fill_cnt,
    COUNTIF(lower(device_language) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'device_is_limited_ad_tracking' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(device_is_limited_ad_tracking) AS fill_cnt,
    COUNTIF(lower(device_is_limited_ad_tracking) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'platform' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(platform) AS fill_cnt,
    COUNTIF(lower(platform) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'app_version' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(app_version) AS fill_cnt,
    COUNTIF(lower(app_version) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'web_version' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(web_version) AS fill_cnt,
    COUNTIF(lower(web_version) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'utm_source' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(utm_source) AS fill_cnt,
    COUNTIF(lower(utm_source) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'stream_id' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(stream_id) AS fill_cnt,
    COUNTIF(lower(stream_id) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_source' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(event_source) AS fill_cnt,
    COUNTIF(lower(event_source) in ("unknown","default")) as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version
UNION ALL
SELECT
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version,
    'event_interval' AS field_name,
    COUNT(1) AS event_cnt,
    COUNT(event_interval) AS fill_cnt,
    0 as default_cnt
FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY)
GROUP BY
    dt,
    refer,
    ap_name,
    event_method,
    event_name,
    event_version,
    platform,
    app_version,
    web_version;