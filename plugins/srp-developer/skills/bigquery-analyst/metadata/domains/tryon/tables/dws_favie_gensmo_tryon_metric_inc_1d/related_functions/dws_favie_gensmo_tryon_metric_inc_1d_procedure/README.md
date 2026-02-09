# dws_favie_gensmo_tryon_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-11-17
**最后更新**: 2025-11-17

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
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_dw.dws_favie_gensmo_tryon_metric_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_tryon_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,
        tryon_task_model_type,
        tryon_trigger_cnt,
        tryon_trigger_device_id,
        tryon_request_cnt,
        tryon_request_device_id,
        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_device_id,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_device_id,
        tryon_load_succeed_task_cnt,
        tryon_load_succeed_device_id,
        tryon_load_fail_task_cnt,
        tryon_load_fail_device_id,
        tryon_view_detail_task_cnt,
        tryon_view_detail_device_id,
        tryon_retry_cnt,
        tryon_retry_device_id,
        tryon_save_task_cnt,
        tryon_save_device_id,
        tryon_unsave_task_cnt,
        tryon_unsave_device_id,
        tryon_like_task_cnt,
        tryon_like_device_id,
        tryon_dislike_task_cnt,
        tryon_dislike_device_id,
        tryon_download_task_cnt,
        tryon_download_device_id,
        tryon_share_task_cnt,
        tryon_share_device_id,
        tryon_post_task_cnt,
        tryon_post_device_id,
        tryon_view_product_task_cnt,
        tryon_view_product_device_id,
        use_default_avatar
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,
        tryon_task_model_type,
        tryon_trigger_cnt,
        tryon_trigger_device_id,
        tryon_request_cnt,
        tryon_request_device_id,
        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_device_id,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_device_id,
        tryon_load_succeed_task_cnt,
        tryon_load_succeed_device_id,
        tryon_load_fail_task_cnt,
        tryon_load_fail_device_id,
        tryon_view_detail_task_cnt,
        tryon_view_detail_device_id,
        tryon_retry_cnt,
        tryon_retry_device_id,
        tryon_save_task_cnt,
        tryon_save_device_id,
        tryon_unsave_task_cnt,
        tryon_unsave_device_id,
        tryon_like_task_cnt,
        tryon_like_device_id,
        tryon_dislike_task_cnt,
        tryon_dislike_device_id,
        tryon_download_task_cnt,
        tryon_download_device_id,
        tryon_share_task_cnt,
        tryon_share_device_id,
        tryon_post_task_cnt,
        tryon_post_device_id,
        tryon_view_product_task_cnt,
        tryon_view_product_device_id,
        use_default_avatar
    FROM favie_dw.dws_favie_gensmo_tryon_metric_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
