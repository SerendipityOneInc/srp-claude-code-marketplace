# dws_favie_gensmo_video_tryon_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: tryon
**表类型**: TABLE
**行数**: 872,222 行
**大小**: 0.29 GB
**创建时间**: 2025-12-11
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 指标数据日期 |
| platform | STRING | NULLABLE | 平台类型（iOS、Android 等） |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 用户所属国家名称 |
| user_login_type | STRING | NULLABLE | 用户登录类型（匿名、注册等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类（新用户、老用户） |
| user_group | STRING | NULLABLE | 用户分组分类 |
| device_id | STRING | NULLABLE | 设备唯一标识 |
| refer | STRING | NULLABLE | 页面名称 |
| ap_name | STRING | NULLABLE | 交互点名称 |
| event_name | STRING | NULLABLE | 事件名称（select_item、view_item_list 等） |
| event_method | STRING | NULLABLE | 事件触发方式（点击、浏览、摇一摇等） |
| event_action_type | STRING | NULLABLE | 事件行为类型（视频试穿、无头像视频试穿等） |
| event_source | STRING | NULLABLE | refer 与 ap_name 组合的事件来源 |
| video_tryon_mode_type | STRING | NULLABLE | 视频试穿模板类型（视频视频试穿等） |
| video_tryon_trigger_cnt | INTEGER | NULLABLE | 触发视频试穿次数 |
| video_tryon_trigger_device_id | STRING | NULLABLE | 触发视频试穿事件设备ID |
| video_tryon_complete_task_cnt | INTEGER | NULLABLE | 视频试穿成功任务数 |
| video_tryon_complete_device_id | STRING | NULLABLE | 视频试穿成功用户设备ID |
| video_tryon_play_complete_task_cnt | INTEGER | NULLABLE | 视频试穿播放完成任务数 |
| video_tryon_play_complete_device_id | STRING | NULLABLE | 视频试穿播放完成用户设备ID |
| video_tryon_retry_task_cnt | INTEGER | NULLABLE | 视频试穿重试次数 |
| video_tryon_retry_device_id | STRING | NULLABLE | 视频试穿重试用户设备ID |
| video_tryon_switch_mode_task_cnt | INTEGER | NULLABLE | 视频试穿切换模式任务数 |
| video_tryon_switch_mode_device_id | STRING | NULLABLE | 视频试穿切换模式用户设备ID |
| video_tryon_save_task_cnt | INTEGER | NULLABLE | 视频试穿保存任务数 |
| video_tryon_save_device_id | STRING | NULLABLE | 视频试穿保存用户设备ID |
| video_tryon_unsave_task_cnt | INTEGER | NULLABLE | 视频试穿取消保存任务数 |
| video_tryon_unsave_device_id | STRING | NULLABLE | 视频试穿取消保存用户设备ID |
| video_tryon_like_task_cnt | INTEGER | NULLABLE | 视频试穿点赞任务数 |
| video_tryon_like_device_id | STRING | NULLABLE | 视频试穿点赞用户设备ID |
| video_tryon_dislike_task_cnt | INTEGER | NULLABLE | 视频试穿点踩任务数 |
| video_tryon_dislike_device_id | STRING | NULLABLE | 视频试穿点踩用户设备ID |
| video_tryon_download_task_cnt | INTEGER | NULLABLE | 视频试穿下载任务数 |
| video_tryon_download_device_id | STRING | NULLABLE | 视频试穿下载用户设备ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:24
**扫描工具**: scan_metadata_v2.py
