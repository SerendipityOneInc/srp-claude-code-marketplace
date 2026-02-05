# rpt_gensmo_avatar_full_penetration_funnel_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 4,590,431 行
**大小**: 0.34 GB
**创建时间**: 2025-11-14
**最后更新**: 2025-12-25

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期 |
| platform | STRING | NULLABLE | 用户平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 用户国家 |
| user_tenure_type | STRING | NULLABLE | 用户使用时长 |
| user_login_type | STRING | NULLABLE | 用户登录方式 |
| user_group | STRING | NULLABLE | 用户分组 |
| create_replica_intention_user_cnt | INTEGER | NULLABLE | 创建头像意图用户数 |
| create_replica_action_user_cnt | INTEGER | NULLABLE | 创建头像行为用户数 |
| use_default_avatar_btn_user_cnt | INTEGER | NULLABLE | 使用默认头像按钮用户数 |
| set_face_btn_click_user_cnt | INTEGER | NULLABLE | 设置脸部按钮点击用户数 |
| set_body_btn_click_user_cnt | INTEGER | NULLABLE | 设置身体按钮点击用户数 |
| set_model_user_cnt | INTEGER | NULLABLE | 设置模型用户数 |
| default_upload_by_camera_user_cnt | INTEGER | NULLABLE | 通过相机上传默认头像用户数 |
| default_upload_by_album_user_cnt | INTEGER | NULLABLE | 通过相册上传默认头像用户数 |
| confirm_default_avatar_user_cnt | INTEGER | NULLABLE | 确认默认头像用户数 |
| upload_selfie_btn_user_cnt | INTEGER | NULLABLE | 上传自拍按钮用户数 |
| selfie_upload_by_album_user_cnt | INTEGER | NULLABLE | 通过相册上传自拍用户数 |
| selfie_upload_by_camera_user_cnt | INTEGER | NULLABLE | 通过相机上传自拍用户数 |
| avatar_selfie_check_pass_user_cnt | INTEGER | NULLABLE | 头像自拍检查通过用户数 |
| avatar_selfie_check_fail_user_cnt | INTEGER | NULLABLE | 头像自拍检查失败用户数 |
| avatar_generate_btn_click_user_cnt | INTEGER | NULLABLE | 头像生成按钮点击用户数 |
| avatar_gen_click_user_cnt | INTEGER | NULLABLE | 头像生成点击用户数 |
| create_replica_intention_pv_cnt | INTEGER | NULLABLE | 创建头像意图PV数 |
| create_replica_action_pv_cnt | INTEGER | NULLABLE | 创建头像行为PV数 |
| use_default_avatar_btn_click_cnt | INTEGER | NULLABLE | 使用默认头像按钮点击数 |
| set_face_btn_click_cnt | INTEGER | NULLABLE | 设置脸部按钮点击数 |
| set_body_btn_click_cnt | INTEGER | NULLABLE | 设置身体按钮点击数 |
| set_model_click_cnt | INTEGER | NULLABLE | 设置模型按钮点击数 |
| default_upload_by_camera_cnt | INTEGER | NULLABLE | 通过相机上传默认头像数 |
| default_upload_by_album_cnt | INTEGER | NULLABLE | 通过相册上传默认头像数 |
| confirm_default_avatar_click_cnt | INTEGER | NULLABLE | 确认默认头像点击数 |
| upload_selfie_btn_click_cnt | INTEGER | NULLABLE | 上传自拍按钮点击数 |
| selfie_upload_by_album_click_cnt | INTEGER | NULLABLE | 通过相册上传自拍点击数 |
| selfie_upload_by_camera_click_cnt | INTEGER | NULLABLE | 通过相机上传自拍点击数 |
| avatar_selfie_check_pass_cnt | INTEGER | NULLABLE | 头像自拍检查通过点击数 |
| avatar_selfie_check_fail_cnt | INTEGER | NULLABLE | 头像自拍检查失败点击数 |
| avatar_generate_btn_click_cnt | INTEGER | NULLABLE | 头像生成按钮点击数 |
| avatar_gen_click_cnt | INTEGER | NULLABLE | 头像生成点击数 |
| DAU | INTEGER | NULLABLE | 日活跃用户数 |
| bd_avatar_validated_user_cnt | INTEGER | NULLABLE | 上传照片但未创建 avatar 用户数 |
| bd_avatar_failed_user_cnt | INTEGER | NULLABLE | 头像生成失败用户数 |
| bd_avatar_discarded_user_cnt | INTEGER | NULLABLE | 头像生成成功但未采用用户数 |
| bd_avatar_refined_user_cnt | INTEGER | NULLABLE | 头像生成成功且用户refine用户数 |
| bd_avatar_selected_user_cnt | INTEGER | NULLABLE | 头像生成成功且采用用户数 |
| bd_avatar_validated_cnt | INTEGER | NULLABLE | 上传照片但未创建 avatar 次数 |
| bd_avatar_failed_cnt | INTEGER | NULLABLE | 头像生成失败次数 |
| bd_avatar_discarded_cnt | INTEGER | NULLABLE | 头像生成成功但未采用次数 |
| bd_avatar_refined_cnt | INTEGER | NULLABLE | 头像生成成功且用户refine次数 |
| bd_avatar_selected_cnt | INTEGER | NULLABLE | 头像生成成功且采用次数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:46
**扫描工具**: scan_metadata_v2.py
