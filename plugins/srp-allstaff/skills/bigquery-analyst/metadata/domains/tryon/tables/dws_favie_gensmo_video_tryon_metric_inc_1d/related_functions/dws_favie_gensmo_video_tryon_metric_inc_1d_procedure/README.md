# dws_favie_gensmo_video_tryon_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-11
**最后更新**: 2025-12-11

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
    -- 删除指定日期的数据
    DELETE FROM `favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d`
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO `favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d` (
        dt,
        -- 用户信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,
        -- 事件信息
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,
        video_tryon_mode_type,
        -- Video Tryon Trigger
        video_tryon_trigger_cnt,
        video_tryon_trigger_device_id,
        -- Video Tryon Complete
        video_tryon_complete_task_cnt,
        video_tryon_complete_device_id,
        -- Video Tryon Play Complete
        video_tryon_play_complete_task_cnt,
        video_tryon_play_complete_device_id,
        -- Video Tryon Retry
        video_tryon_retry_task_cnt,
        video_tryon_retry_device_id,
        -- Video Tryon Switch Mode
        video_tryon_switch_mode_task_cnt,
        video_tryon_switch_mode_device_id,
        -- Video Tryon Save
        video_tryon_save_task_cnt,
        video_tryon_save_device_id,
        -- Video Tryon Unsave
        video_tryon_unsave_task_cnt,
        video_tryon_unsave_device_id,
        -- Video Tryon Like
        video_tryon_like_task_cnt,
        video_tryon_like_device_id,
        -- Video Tryon Dislike
        video_tryon_dislike_task_cnt,
        video_tryon_dislike_device_id,
        -- Video Tryon Download
        video_tryon_download_task_cnt,
        video_tryon_download_device_id
    )
    SELECT
        dt,

        -- 用户信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        -- 事件信息
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,
        video_tryon_mode_type,

        -- Video Tryon Trigger
        video_tryon_trigger_cnt,
        video_tryon_trigger_device_id,

        -- Video Tryon Complete
        video_tryon_complete_task_cnt,
        video_tryon_complete_device_id,

        -- Video Tryon Play Complete
        video_tryon_play_complete_task_cnt,
        video_tryon_play_complete_device_id,

        -- Video Tryon Retry
        video_tryon_retry_task_cnt,
        video_tryon_retry_device_id,

        -- Video Tryon Switch Mode
        video_tryon_switch_mode_task_cnt,
        video_tryon_switch_mode_device_id,

        -- Video Tryon Save
        video_tryon_save_task_cnt,
        video_tryon_save_device_id,

        -- Video Tryon Unsave
        video_tryon_unsave_task_cnt,
        video_tryon_unsave_device_id,

        -- Video Tryon Like
        video_tryon_like_task_cnt,
        video_tryon_like_device_id,

        -- Video Tryon Dislike
        video_tryon_dislike_task_cnt,
        video_tryon_dislike_device_id,

        -- Video Tryon Download
        video_tryon_download_task_cnt,
        video_tryon_download_device_id
    FROM `favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d_function`(dt_param);
    call favie_dw.record_partition('dws_favie_gensmo_video_tryon_metric_inc_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
