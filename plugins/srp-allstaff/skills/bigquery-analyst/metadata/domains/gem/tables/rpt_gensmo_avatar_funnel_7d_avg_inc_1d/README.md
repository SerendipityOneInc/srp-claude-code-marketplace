# rpt_gensmo_avatar_funnel_7d_avg_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_avatar_funnel_7d_avg_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 2,012,754 行
**大小**: 0.58 GB
**创建时间**: 2025-11-14
**最后更新**: 2025-12-25

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| period_end_date | DATE | NULLABLE | 周期结束日期 |
| period_start_date | DATE | NULLABLE | 周期开始日期 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 国家 |
| user_tenure_type | STRING | NULLABLE | 用户使用时长类型 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| user_group | STRING | NULLABLE | 用户组 |
| create_replica_intention_user_cnt_7d_sum | INTEGER | NULLABLE | 创建头像意图用户数（7天累计） |
| create_replica_action_user_cnt_7d_sum | INTEGER | NULLABLE | 创建头像行为用户数（7天累计） |
| use_default_avatar_btn_user_cnt_7d_sum | INTEGER | NULLABLE | 使用默认头像按钮用户数（7天累计） |
| set_face_btn_click_user_cnt_7d_sum | INTEGER | NULLABLE | 设置头像面部按钮点击用户数（7天累计） |
| set_body_btn_click_user_cnt_7d_sum | INTEGER | NULLABLE | 设置头像身体按钮点击用户数（7天累计） |
| set_model_user_cnt_7d_sum | INTEGER | NULLABLE | 设置头像模型用户数（7天累计） |
| default_upload_by_camera_user_cnt_7d_sum | INTEGER | NULLABLE | 通过相机上传默认头像用户数（7天累计） |
| default_upload_by_album_user_cnt_7d_sum | INTEGER | NULLABLE | 通过相册上传默认头像用户数（7天累计） |
| confirm_default_avatar_user_cnt_7d_sum | INTEGER | NULLABLE | 确认默认头像用户数（7天累计） |
| upload_selfie_btn_user_cnt_7d_sum | INTEGER | NULLABLE | 上传自拍按钮用户数（7天累计） |
| selfie_upload_by_album_user_cnt_7d_sum | INTEGER | NULLABLE | 通过相册上传自拍用户数（7天累计） |
| selfie_upload_by_camera_user_cnt_7d_sum | INTEGER | NULLABLE | 通过相机上传自拍用户数（7天累计） |
| avatar_selfie_check_pass_user_cnt_7d_sum | INTEGER | NULLABLE | 头像自拍审核通过用户数（7天累计） |
| avatar_selfie_check_fail_user_cnt_7d_sum | INTEGER | NULLABLE | 头像自拍审核未通过用户数（7天累计） |
| avatar_generate_btn_click_user_cnt_7d_sum | INTEGER | NULLABLE | 头像生成按钮点击用户数（7天累计） |
| avatar_gen_click_user_cnt_7d_sum | INTEGER | NULLABLE | 头像生成点击用户数（7天累计） |
| create_replica_intention_pv_cnt_7d_sum | INTEGER | NULLABLE | 创建头像意图PV数（7天累计） |
| create_replica_action_pv_cnt_7d_sum | INTEGER | NULLABLE | 创建头像行为PV数（7天累计） |
| use_default_avatar_btn_click_cnt_7d_sum | INTEGER | NULLABLE | 使用默认头像按钮点击数（7天累计） |
| set_face_btn_click_cnt_7d_sum | INTEGER | NULLABLE | 设置头像面部按钮点击数（7天累计） |
| set_body_btn_click_cnt_7d_sum | INTEGER | NULLABLE | 设置头像身体按钮点击数（7天累计） |
| set_model_click_cnt_7d_sum | INTEGER | NULLABLE | 设置头像模型点击数（7天累计） |
| default_upload_by_camera_cnt_7d_sum | INTEGER | NULLABLE | 通过相机上传默认头像数（7天累计） |
| default_upload_by_album_cnt_7d_sum | INTEGER | NULLABLE | 通过相册上传默认头像数（7天累计） |
| confirm_default_avatar_click_cnt_7d_sum | INTEGER | NULLABLE | 确认默认头像点击数（7天累计） |
| upload_selfie_btn_click_cnt_7d_sum | INTEGER | NULLABLE | 上传自拍按钮点击数（7天累计） |
| selfie_upload_by_album_click_cnt_7d_sum | INTEGER | NULLABLE | 通过相册上传自拍点击数（7天累计） |
| selfie_upload_by_camera_click_cnt_7d_sum | INTEGER | NULLABLE | 通过相机上传自拍点击数（7天累计） |
| avatar_selfie_check_pass_cnt_7d_sum | INTEGER | NULLABLE | 头像自拍审核通过点击数（7天累计） |
| avatar_selfie_check_fail_cnt_7d_sum | INTEGER | NULLABLE | 头像自拍审核未通过点击数（7天累计） |
| avatar_generate_btn_click_cnt_7d_sum | INTEGER | NULLABLE | 头像生成按钮点击数（7天累计） |
| avatar_gen_click_cnt_7d_sum | INTEGER | NULLABLE | 头像生成点击数（7天累计） |
| DAU_7d_sum | INTEGER | NULLABLE | 日活跃用户数（7天累计） |
| bd_avatar_validated_cnt_7d_sum | INTEGER | NULLABLE | 上传照片但未创建 avatar 次数（7天累计） |
| bd_avatar_validated_user_cnt_7d_sum | INTEGER | NULLABLE | 上传照片但未创建 avatar 用户数（7天累计） |
| bd_avatar_failed_cnt_7d_sum | INTEGER | NULLABLE | 头像生成失败次数（7天累计） |
| bd_avatar_failed_user_cnt_7d_sum | INTEGER | NULLABLE | 头像生成失败用户数（7天累计） |
| bd_avatar_discarded_cnt_7d_sum | INTEGER | NULLABLE | 头像生成成功但未选择次数（7天累计） |
| bd_avatar_discarded_user_cnt_7d_sum | INTEGER | NULLABLE | 头像生成成功但未选择用户数（7天累计） |
| bd_avatar_refined_cnt_7d_sum | INTEGER | NULLABLE | 头像生成成功且用户refine次数（7天累计） |
| bd_avatar_refined_user_cnt_7d_sum | INTEGER | NULLABLE | 头像生成成功且用户refine用户数（7天累计） |
| bd_avatar_selected_cnt_7d_sum | INTEGER | NULLABLE | 头像生成成功且选取次数（7天累计） |
| bd_avatar_selected_user_cnt_7d_sum | INTEGER | NULLABLE | 头像生成成功且选取用户数（7天累计） |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_avatar_funnel_7d_avg_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:48
**扫描工具**: scan_metadata_v2.py
