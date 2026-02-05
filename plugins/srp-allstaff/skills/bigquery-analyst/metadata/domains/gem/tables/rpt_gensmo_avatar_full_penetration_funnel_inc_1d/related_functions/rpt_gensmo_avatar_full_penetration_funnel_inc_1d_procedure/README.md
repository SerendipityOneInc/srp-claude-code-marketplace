# rpt_gensmo_avatar_full_penetration_funnel_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-11-14
**最后更新**: 2025-11-14

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
    DELETE FROM favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d
    WHERE dt is not null and dt = dt_param;
    
    INSERT INTO favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d
    (
        dt,
        platform,
        app_version,
        country_name,
        user_tenure_type,
        user_login_type,
        user_group,
        create_replica_intention_user_cnt,
        create_replica_action_user_cnt,
        use_default_avatar_btn_user_cnt,
        set_face_btn_click_user_cnt,
        set_body_btn_click_user_cnt,
        set_model_user_cnt,
        default_upload_by_camera_user_cnt,
        default_upload_by_album_user_cnt,
        confirm_default_avatar_user_cnt,
        upload_selfie_btn_user_cnt,
        selfie_upload_by_album_user_cnt,
        selfie_upload_by_camera_user_cnt,
        avatar_selfie_check_pass_user_cnt,
        avatar_selfie_check_fail_user_cnt,
        avatar_generate_btn_click_user_cnt,
        avatar_gen_click_user_cnt,
        create_replica_intention_pv_cnt,
        create_replica_action_pv_cnt,
        use_default_avatar_btn_click_cnt,
        set_face_btn_click_cnt,
        set_body_btn_click_cnt,
        set_model_click_cnt,
        default_upload_by_camera_cnt,
        default_upload_by_album_cnt,
        confirm_default_avatar_click_cnt,
        upload_selfie_btn_click_cnt,
        selfie_upload_by_album_click_cnt,
        selfie_upload_by_camera_click_cnt,
        avatar_selfie_check_pass_cnt,
        avatar_selfie_check_fail_cnt,
        avatar_generate_btn_click_cnt,
        avatar_gen_click_cnt,
        DAU,
        bd_avatar_validated_user_cnt,
        bd_avatar_failed_user_cnt,
        bd_avatar_discarded_user_cnt,
        bd_avatar_refined_user_cnt,
        bd_avatar_selected_user_cnt,
        bd_avatar_validated_cnt,
        bd_avatar_failed_cnt,
        bd_avatar_discarded_cnt,
        bd_avatar_refined_cnt,
        bd_avatar_selected_cnt
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_tenure_type,
        user_login_type,
        user_group,
        create_replica_intention_user_cnt,
        create_replica_action_user_cnt,
        use_default_avatar_btn_user_cnt,
        set_face_btn_click_user_cnt,
        set_body_btn_click_user_cnt,
        set_model_user_cnt,
        default_upload_by_camera_user_cnt,
        default_upload_by_album_user_cnt,
        confirm_default_avatar_user_cnt,
        upload_selfie_btn_user_cnt,
        selfie_upload_by_album_user_cnt,
        selfie_upload_by_camera_user_cnt,
        avatar_selfie_check_pass_user_cnt,
        avatar_selfie_check_fail_user_cnt,
        avatar_generate_btn_click_user_cnt,
        avatar_gen_click_user_cnt,
        create_replica_intention_pv_cnt,
        create_replica_action_pv_cnt,
        use_default_avatar_btn_click_cnt,
        set_face_btn_click_cnt,
        set_body_btn_click_cnt,
        set_model_click_cnt,
        default_upload_by_camera_cnt,
        default_upload_by_album_cnt,
        confirm_default_avatar_click_cnt,
        upload_selfie_btn_click_cnt,
        selfie_upload_by_album_click_cnt,
        selfie_upload_by_camera_click_cnt,
        avatar_selfie_check_pass_cnt,
        avatar_selfie_check_fail_cnt,
        avatar_generate_btn_click_cnt,
        avatar_gen_click_cnt,
        DAU,
        bd_avatar_validated_user_cnt,
        bd_avatar_failed_user_cnt,
        bd_avatar_discarded_user_cnt,
        bd_avatar_refined_user_cnt,
        bd_avatar_selected_user_cnt,
        bd_avatar_validated_cnt,
        bd_avatar_failed_cnt,
        bd_avatar_discarded_cnt,
        bd_avatar_refined_cnt,
        bd_avatar_selected_cnt
    FROM favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d_function(dt_param) ;

END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
