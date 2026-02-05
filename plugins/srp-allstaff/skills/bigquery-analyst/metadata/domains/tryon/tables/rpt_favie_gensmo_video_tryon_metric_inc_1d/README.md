# rpt_favie_gensmo_video_tryon_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_video_tryon_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: tryon
**表类型**: TABLE
**行数**: 4,414,710 行
**大小**: 0.34 GB
**创建时间**: 2025-12-11
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区字段，格式YYYY-MM-DD |
| platform | STRING | NULLABLE | 用户平台，如 iOS、Android、Web |
| app_version | STRING | NULLABLE | 应用版本号 |
| country_name | STRING | NULLABLE | 国家或地区名称 |
| user_login_type | STRING | NULLABLE | 用户登录类型，如手机号、微信授权等 |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类，如新用户、老用户 |
| user_group | STRING | NULLABLE | 用户分群标签 |
| active_user_d1_cnt | INTEGER | NULLABLE | 日活跃用户数 |
| video_tryon_trigger_cnt | INTEGER | NULLABLE | 视频试穿触发次数 |
| video_tryon_trigger_user_cnt | INTEGER | NULLABLE | 视频试穿触发用户数 |
| video_tryon_complete_task_cnt | INTEGER | NULLABLE | 视频试穿完成任务数 |
| video_tryon_complete_user_cnt | INTEGER | NULLABLE | 视频试穿完成用户数 |
| video_tryon_play_complete_task_cnt | INTEGER | NULLABLE | 视频试穿播放完成任务数 |
| video_tryon_play_complete_user_cnt | INTEGER | NULLABLE | 视频试穿播放完成用户数 |
| video_tryon_retry_task_cnt | INTEGER | NULLABLE | 视频试穿重试次数 |
| video_tryon_retry_user_cnt | INTEGER | NULLABLE | 视频试穿重试用户数 |
| video_tryon_switch_mode_task_cnt | INTEGER | NULLABLE | 视频试穿切换模式任务数 |
| video_tryon_switch_mode_user_cnt | INTEGER | NULLABLE | 视频试穿切换模式用户数 |
| video_tryon_save_task_cnt | INTEGER | NULLABLE | 视频试穿保存任务数 |
| video_tryon_save_user_cnt | INTEGER | NULLABLE | 视频试穿保存用户数 |
| video_tryon_unsave_task_cnt | INTEGER | NULLABLE | 视频试穿取消保存任务数 |
| video_tryon_unsave_user_cnt | INTEGER | NULLABLE | 视频试穿取消保存用户数 |
| video_tryon_like_task_cnt | INTEGER | NULLABLE | 视频试穿点赞任务数 |
| video_tryon_like_user_cnt | INTEGER | NULLABLE | 视频试穿点赞用户数 |
| video_tryon_dislike_task_cnt | INTEGER | NULLABLE | 视频试穿点踩任务数 |
| video_tryon_dislike_user_cnt | INTEGER | NULLABLE | 视频试穿点踩用户数 |
| video_tryon_download_task_cnt | INTEGER | NULLABLE | 视频试穿下载任务数 |
| video_tryon_download_user_cnt | INTEGER | NULLABLE | 视频试穿下载用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_video_tryon_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:45
**扫描工具**: scan_metadata_v2.py
