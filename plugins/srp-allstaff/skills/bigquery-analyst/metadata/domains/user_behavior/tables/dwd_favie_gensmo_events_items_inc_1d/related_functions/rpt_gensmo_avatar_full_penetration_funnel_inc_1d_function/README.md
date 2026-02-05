# rpt_gensmo_avatar_full_penetration_funnel_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-11-14
**最后更新**: 2025-11-14

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read` (dws_gensmo_user_group_inc_1d_function_read)
- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d` (dwd_favie_gensmo_events_items_inc_1d)
- `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d` (rpt_gensmo_user_active_metrics_inc_1d)

---

## 💻 函数定义

```sql
WITH event_info AS (
        SELECT
            device_id,
            refer,
            ap_name,
            cal_pre_refer AS pre_refer,
            cal_pre_refer_event.event_action_type AS pre_refer_event_action_type,
            cal_pre_refer_event.ap_name AS pre_refer_ap_name,
            cal_pre_refer_event.event_name AS pre_refer_event_name,
            cal_pre_refer_event.event_method AS pre_refer_event_method,
            event_action_type,
            event_item.item_type AS item_type,
            event_item.item_name AS item_name,
            event_name,
            event_method,
            dt,
            platform,
            app_version,
            geo_country_name AS country_name
        FROM
            `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
        WHERE
            dt = dt_param
            AND event_version = '1.0.0'
            AND device_id IS NOT NULL
            --AND event_timestamp IS NOT NULL
            AND refer IS NOT NULL
    ),

    user_info AS (
        SELECT
            dt,
            user_group,
            device_id,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version
        FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)
    ),
    
    info AS (
        SELECT
            e.device_id,
            e.refer,
            e.pre_refer,
            e.pre_refer_ap_name,
            e.pre_refer_event_action_type,
            e.pre_refer_event_name,
            e.pre_refer_event_method,
            e.ap_name,
            e.event_action_type,
            e.item_type,
            e.item_name,
            e.event_name,
            e.event_method,
            e.dt,
            u.platform,
            u.app_version,
            u.country_name,
            COALESCE(u.user_login_type, 'unknown') AS user_login_type,
            COALESCE(u.user_tenure_type, 'unknown') AS user_tenure_type,
            u.user_group
        FROM 
            event_info e
        LEFT JOIN 
            user_info u ON e.device_id = u.device_id
    ),

    info_by_events AS (
        SELECT
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            device_id,
            user_group,

            IF(
                refer = 'create_replica' AND event_action_type = 'default' AND ap_name = 'ap_screen' AND event_method = 'page_view' AND event_name = 'select_item',
                1, 0) AS create_replica_intention,

            IF(refer = 'create_replica' AND event_action_type = 'create_replica' AND ap_name IN ('ap_use_default_avatar_btn', 'ap_upload_selfie_cta_btn') AND event_method = 'click', 
                1, 0) AS create_replica_action,

            IF(ap_name = 'ap_use_default_avatar_btn' AND refer = 'create_replica' AND event_method = 'click', 1, 0) AS use_default_avatar_btn_click,
            IF(ap_name = 'ap_set_face_btn' AND refer = 'select_model', 1, 0) AS set_face_btn_click,
            IF(ap_name = 'ap_set_body_btn' AND refer = 'select_model', 1, 0) AS set_body_btn_click,
            IF((ap_name = 'ap_set_body_btn' OR ap_name = 'ap_set_face_btn') AND refer = 'select_model', 1, 0) AS set_model,
            IF(refer = 'camera_set_face' AND pre_refer = 'webview' AND ap_name = 'ap_shutter_btn', 1, 0) AS default_upload_by_camera,
            IF(refer = 'camera_set_face' AND pre_refer = 'webview' AND ap_name = 'ap_album_item', 1, 0) AS default_upload_by_album,
            IF(ap_name = 'ap_confirm_btn' AND refer = 'select_model', 1, 0) AS confirm_default_avatar,

            IF(ap_name = 'ap_upload_selfie_cta_btn' AND refer = 'create_replica', 1, 0) AS upload_selfie_btn_click,
            IF((pre_refer = 'create_replica' OR pre_refer LIKE 'login%') AND ap_name = 'ap_album_item' AND refer = 'camera_set_face' AND event_method = 'click', 1, 0) AS selfie_upload_by_album,
            IF((pre_refer = 'create_replica' OR pre_refer LIKE 'login%') AND ap_name = 'ap_shutter_btn' AND refer = 'camera_set_face' AND event_method = 'click', 1, 0) AS selfie_upload_by_camera,
            IF(ap_name = 'bd_avatar_selfie' AND event_action_type = 'selfie_check_complete' AND item_name = 'pass', 1, 0) AS avatar_selfie_check_pass,
            IF(ap_name = 'bd_avatar_selfie' AND event_action_type = 'selfie_check_complete' AND item_name = 'no_pass', 1, 0) AS avatar_selfie_check_fail,
            IF(refer = 'create_replica' AND ap_name = 'ap_avatar_generate_btn' AND event_method = 'click', 1, 0) AS avatar_generate_btn_click,

            IF((ap_name = 'ap_confirm_btn' AND refer = 'select_model') OR (refer = 'create_replica' AND ap_name = 'ap_avatar_generate_btn' AND event_method = 'click'), 1, 0) AS avatar_gen_click
        FROM
            info
    ),

    pv AS (
        SELECT
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            user_group,
            SUM(create_replica_intention) AS create_replica_intention_pv_cnt,
            SUM(create_replica_action) AS create_replica_action_pv_cnt,
            SUM(use_default_avatar_btn_click) AS use_default_avatar_btn_click_cnt,
            SUM(set_face_btn_click) AS set_face_btn_click_cnt,
            SUM(set_body_btn_click) AS set_body_btn_click_cnt,
            SUM(set_model) AS set_model_click_cnt,
            SUM(default_upload_by_camera) AS default_upload_by_camera_cnt,
            SUM(default_upload_by_album) AS default_upload_by_album_cnt,
            SUM(confirm_default_avatar) AS confirm_default_avatar_click_cnt,
            SUM(upload_selfie_btn_click) AS upload_selfie_btn_click_cnt,
            SUM(selfie_upload_by_album) AS selfie_upload_by_album_click_cnt,
            SUM(selfie_upload_by_camera) AS selfie_upload_by_camera_click_cnt,
            SUM(avatar_selfie_check_pass) AS avatar_selfie_check_pass_cnt,
            SUM(avatar_selfie_check_fail) AS avatar_selfie_check_fail_cnt,
            SUM(avatar_generate_btn_click) AS avatar_generate_btn_click_cnt,
            SUM(avatar_gen_click) AS avatar_gen_click_cnt
        FROM
            info_by_events
        GROUP BY
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            user_group
    ),

    events_device_id AS (
        SELECT
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            user_group,
            IF(create_replica_intention = 1, device_id, NULL) AS create_replica_intention_device_id,
            IF(create_replica_action = 1, device_id, NULL) AS create_replica_action_device_id,
            IF(use_default_avatar_btn_click = 1, device_id, NULL) AS use_default_avatar_btn_click_device_id,
            IF(set_face_btn_click = 1, device_id, NULL) AS set_face_btn_click_device_id,
            IF(set_body_btn_click = 1, device_id, NULL) AS set_body_btn_click_device_id,
            IF(set_model = 1, device_id, NULL) AS set_model_device_id,
            IF(default_upload_by_camera = 1, device_id, NULL) AS default_upload_by_camera_device_id,
            IF(default_upload_by_album = 1, device_id, NULL) AS default_upload_by_album_device_id,
            IF(confirm_default_avatar = 1, device_id, NULL) AS confirm_default_avatar_device_id,
            IF(upload_selfie_btn_click = 1, device_id, NULL) AS upload_selfie_btn_click_device_id,
            IF(selfie_upload_by_album = 1, device_id, NULL) AS selfie_upload_by_album_device_id,
            IF(selfie_upload_by_camera = 1, device_id, NULL) AS selfie_upload_by_camera_device_id,
            IF(avatar_selfie_check_pass = 1, device_id, NULL) AS avatar_selfie_check_pass_device_id,
            IF(avatar_selfie_check_fail = 1, device_id, NULL) AS avatar_selfie_check_fail_device_id,
            IF(avatar_generate_btn_click = 1, device_id, NULL) AS avatar_generate_btn_click_device_id,
            IF(avatar_gen_click = 1, device_id, NULL) AS avatar_gen_click_device_id
        FROM
            info_by_events
    ),

    aggregation AS (
        SELECT
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            user_group,
            COUNT(DISTINCT create_replica_intention_device_id) AS create_replica_intention_user_cnt,
            COUNT(DISTINCT create_replica_action_device_id) AS create_replica_action_user_cnt,
            COUNT(DISTINCT use_default_avatar_btn_click_device_id) AS use_default_avatar_btn_user_cnt,
            COUNT(DISTINCT set_face_btn_click_device_id) AS set_face_btn_click_user_cnt,
            COUNT(DISTINCT set_body_btn_click_device_id) AS set_body_btn_click_user_cnt,
            COUNT(DISTINCT set_model_device_id) AS set_model_user_cnt,
            COUNT(DISTINCT default_upload_by_camera_device_id) AS default_upload_by_camera_user_cnt,
            COUNT(DISTINCT default_upload_by_album_device_id) AS default_upload_by_album_user_cnt,
            COUNT(DISTINCT confirm_default_avatar_device_id) AS confirm_default_avatar_user_cnt,
            COUNT(DISTINCT upload_selfie_btn_click_device_id) AS upload_selfie_btn_user_cnt,
            COUNT(DISTINCT selfie_upload_by_album_device_id) AS selfie_upload_by_album_user_cnt,
            COUNT(DISTINCT selfie_upload_by_camera_device_id) AS selfie_upload_by_camera_user_cnt,
            COUNT(DISTINCT avatar_selfie_check_pass_device_id) AS avatar_selfie_check_pass_user_cnt,
            COUNT(DISTINCT avatar_selfie_check_fail_device_id) AS avatar_selfie_check_fail_user_cnt,
            COUNT(DISTINCT avatar_generate_btn_click_device_id) AS avatar_generate_btn_click_user_cnt,
            COUNT(DISTINCT avatar_gen_click_device_id) AS avatar_gen_click_user_cnt
        FROM 
            events_device_id
        GROUP BY
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            user_group
    ),

    full_event_info AS (
        SELECT
            t1.dt,
            t1.platform,
            t1.app_version,
            t1.country_name,
            t1.user_tenure_type,
            t1.user_login_type,
            t1.user_group,

            t1.create_replica_intention_user_cnt,
            t1.create_replica_action_user_cnt,
            t1.use_default_avatar_btn_user_cnt,
            t1.set_face_btn_click_user_cnt,
            t1.set_body_btn_click_user_cnt,
            t1.set_model_user_cnt,
            t1.default_upload_by_camera_user_cnt,
            t1.default_upload_by_album_user_cnt,
            t1.confirm_default_avatar_user_cnt,
            t1.upload_selfie_btn_user_cnt,
            t1.selfie_upload_by_album_user_cnt,
            t1.selfie_upload_by_camera_user_cnt,
            t1.avatar_selfie_check_pass_user_cnt,
            t1.avatar_selfie_check_fail_user_cnt,
            t1.avatar_generate_btn_click_user_cnt,
            t1.avatar_gen_click_user_cnt,

            t2.create_replica_intention_pv_cnt,
            t2.create_replica_action_pv_cnt,
            t2.use_default_avatar_btn_click_cnt,
            t2.set_face_btn_click_cnt,
            t2.set_body_btn_click_cnt,
            t2.set_model_click_cnt,
            t2.default_upload_by_camera_cnt,
            t2.default_upload_by_album_cnt,
            t2.confirm_default_avatar_click_cnt,
            t2.upload_selfie_btn_click_cnt,
            t2.selfie_upload_by_album_click_cnt,
            t2.selfie_upload_by_camera_click_cnt,
            t2.avatar_selfie_check_pass_cnt,
            t2.avatar_selfie_check_fail_cnt,
            t2.avatar_generate_btn_click_cnt,
            t2.avatar_gen_click_cnt
        FROM
            aggregation t1
        LEFT JOIN
            pv t2 ON 
            t1.dt = t2.dt
            AND t1.platform = t2.platform
            AND t1.app_version = t2.app_version
            AND t1.country_name = t2.country_name
            AND t1.user_login_type = t2.user_login_type
            AND t1.user_tenure_type = t2.user_tenure_type
            AND t1.user_group = t2.user_group
    ),

    dau_info AS (
        SELECT
            dt,
            platform,
            app_version,
            country_name,
            COALESCE(user_login_type, 'unknown') AS user_login_type,
            COALESCE(user_tenure_type, 'unknown') AS user_tenure_type,
            user_group,
            SUM(active_user_d1_cnt) AS active_user_d1_cnt
        FROM
            `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d`
        WHERE
            dt = dt_param
        GROUP BY
            dt,
            platform,
            app_version,
            country_name,
            user_login_type,
            user_tenure_type,
            user_group
    ),

    bd_avatar_complete_info AS (
        SELECT
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            user_group,

            COUNT(DISTINCT validated_task_device_id) AS bd_avatar_validated_user_cnt,
            COUNT(DISTINCT failed_task_device_id) AS bd_avatar_failed_user_cnt,
            COUNT(DISTINCT discarded_task_device_id) AS bd_avatar_discarded_user_cnt,
            COUNT(DISTINCT refined_task_device_id) AS bd_avatar_refined_user_cnt,
            COUNT(DISTINCT selected_task_device_id) AS bd_avatar_selected_user_cnt,

            SUM(validated_task_cnt) AS bd_avatar_validated_cnt,
            SUM(failed_task_cnt) AS bd_avatar_failed_cnt,
            SUM(discarded_task_cnt) AS bd_avatar_discarded_cnt,
            SUM(refined_task_cnt) AS bd_avatar_refined_cnt,
            SUM(selected_task_cnt) AS bd_avatar_selected_cnt
        FROM
            favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d
        WHERE
            dt = dt_param
        GROUP BY
            dt,
            platform,
            app_version,
            country_name,
            user_tenure_type,
            user_login_type,
            user_group
    )

    SELECT
        COALESCE(a.dt, b.dt) AS dt,
        COALESCE(a.platform, b.platform) AS platform,
        COALESCE(a.app_version, b.app_version) AS app_version,
        COALESCE(a.country_name, b.country_name) AS country_name,
        COALESCE(a.user_tenure_type, b.user_tenure_type) AS user_tenure_type,
        COALESCE(a.user_login_type, b.user_login_type) AS user_login_type,
        a.user_group,
        a.create_replica_intention_user_cnt,
        a.create_replica_action_user_cnt,
        a.use_default_avatar_btn_user_cnt,
        a.set_face_btn_click_user_cnt,
        a.set_body_btn_click_user_cnt,
        a.set_model_user_cnt,
        a.default_upload_by_camera_user_cnt,
        a.default_upload_by_album_user_cnt,
        a.confirm_default_avatar_user_cnt,
        a.upload_selfie_btn_user_cnt,
        a.selfie_upload_by_album_user_cnt,
        a.selfie_upload_by_camera_user_cnt,
        a.avatar_selfie_check_pass_user_cnt,
        a.avatar_selfie_check_fail_user_cnt,
        a.avatar_generate_btn_click_user_cnt,
        a.avatar_gen_click_user_cnt,

        a.create_replica_intention_pv_cnt,
        a.create_replica_action_pv_cnt,
        a.use_default_avatar_btn_click_cnt,
        a.set_face_btn_click_cnt,
        a.set_body_btn_click_cnt,
        a.set_model_click_cnt,
        a.default_upload_by_camera_cnt,
        a.default_upload_by_album_cnt,
        a.confirm_default_avatar_click_cnt,
        a.upload_selfie_btn_click_cnt,
        a.selfie_upload_by_album_click_cnt,
        a.selfie_upload_by_camera_click_cnt,
        a.avatar_selfie_check_pass_cnt,
        a.avatar_selfie_check_fail_cnt,
        a.avatar_generate_btn_click_cnt,
        a.avatar_gen_click_cnt,

        b.active_user_d1_cnt AS DAU,

        c.bd_avatar_validated_user_cnt,
        c.bd_avatar_failed_user_cnt,
        c.bd_avatar_discarded_user_cnt,
        c.bd_avatar_refined_user_cnt,
        c.bd_avatar_selected_user_cnt,
        c.bd_avatar_validated_cnt,
        c.bd_avatar_failed_cnt,
        c.bd_avatar_discarded_cnt,
        c.bd_avatar_refined_cnt,
        c.bd_avatar_selected_cnt

    FROM 
        full_event_info a
    FULL JOIN 
        dau_info b ON 
        a.dt = b.dt 
        AND a.platform = b.platform 
        AND a.app_version = b.app_version 
        AND a.country_name = b.country_name 
        AND a.user_login_type = b.user_login_type 
        AND a.user_tenure_type = b.user_tenure_type 
        AND a.user_group = b.user_group
    LEFT JOIN
        bd_avatar_complete_info c
    ON
        a.dt = c.dt
        AND a.platform = c.platform
        AND a.app_version = c.app_version
        AND a.country_name = c.country_name
        AND a.user_login_type = c.user_login_type
        AND a.user_tenure_type = c.user_tenure_type
        AND a.user_group = c.user_group
```

---

**文档生成**: 2026-01-30 13:39:24
**扫描工具**: scan_functions.py
