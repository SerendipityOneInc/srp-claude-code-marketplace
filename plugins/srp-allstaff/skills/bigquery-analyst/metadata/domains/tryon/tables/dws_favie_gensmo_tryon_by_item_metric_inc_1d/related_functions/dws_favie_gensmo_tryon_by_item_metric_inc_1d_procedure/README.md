# dws_favie_gensmo_tryon_by_item_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-09
**最后更新**: 2025-10-09

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
begin
    DELETE FROM favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        task_model,
        task_type,

        tryon_server_complete_item_cnt,
        tryon_server_complete_user_cnt,

        tryon_complete_item_cnt,
        tryon_complete_user_cnt,
        tryon_complete_list_item_cnt,
        tryon_complete_list_user_cnt,
        tryon_complete_list_item_cnt_2_0,
        tryon_complete_list_user_cnt_2_0,
        tryon_complete_detail_item_cnt,
        tryon_complete_detail_user_cnt,

        tryon_change_scene_intention_item_cnt,
        tryon_change_scene_intention_user_cnt,
        tryon_change_scene_gen_item_cnt,
        tryon_change_scene_gen_user_cnt,
        tryon_change_scene_browse_item_cnt,
        tryon_change_scene_browse_user_cnt,

        tryon_retry_item_cnt,
        tryon_retry_user_cnt,

        tryon_save_item_cnt,
        tryon_save_user_cnt,
        tryon_unsave_item_cnt,
        tryon_unsave_user_cnt,

        tryon_download_item_cnt,
        tryon_download_user_cnt,

        tryon_like_item_cnt,
        tryon_like_user_cnt,
        tryon_cancel_like_item_cnt,
        tryon_cancel_like_user_cnt,

        tryon_share_item_cnt,
        tryon_share_user_cnt,

        tryon_post_item_cnt,
        tryon_post_user_cnt,

        tryon_dislike_item_cnt,
        tryon_dislike_user_cnt,
        tryon_cancel_dislike_item_cnt,
        tryon_cancel_dislike_user_cnt
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

        task_model,
        task_type,

        tryon_server_complete_item_cnt,
        tryon_server_complete_user_cnt,

        tryon_complete_item_cnt,
        tryon_complete_user_cnt,
        tryon_complete_list_item_cnt,
        tryon_complete_list_user_cnt,
        tryon_complete_list_item_cnt_2_0,
        tryon_complete_list_user_cnt_2_0,
        tryon_complete_detail_item_cnt,
        tryon_complete_detail_user_cnt,

        tryon_change_scene_intention_item_cnt,
        tryon_change_scene_intention_user_cnt,
        tryon_change_scene_gen_item_cnt,
        tryon_change_scene_gen_user_cnt,
        tryon_change_scene_browse_item_cnt,
        tryon_change_scene_browse_user_cnt,

        tryon_retry_item_cnt,
        tryon_retry_user_cnt,

        tryon_save_item_cnt,
        tryon_save_user_cnt,
        tryon_unsave_item_cnt,
        tryon_unsave_user_cnt,

        tryon_download_item_cnt,
        tryon_download_user_cnt,

        tryon_like_item_cnt,
        tryon_like_user_cnt,
        tryon_cancel_like_item_cnt,
        tryon_cancel_like_user_cnt,

        tryon_share_item_cnt,
        tryon_share_user_cnt,

        tryon_post_item_cnt,
        tryon_post_user_cnt,

        tryon_dislike_item_cnt,
        tryon_dislike_user_cnt,
        tryon_cancel_dislike_item_cnt,
        tryon_cancel_dislike_user_cnt
    FROM favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
