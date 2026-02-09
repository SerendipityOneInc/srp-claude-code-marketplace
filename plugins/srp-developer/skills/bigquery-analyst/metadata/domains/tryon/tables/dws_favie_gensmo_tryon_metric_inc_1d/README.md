# dws_favie_gensmo_tryon_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: tryon
**表类型**: TABLE
**行数**: 10,558,186 行
**大小**: 3.95 GB
**创建时间**: 2025-10-15
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
| event_action_type | STRING | NULLABLE | 事件行为类型（试穿、无头像试穿等） |
| event_source | STRING | NULLABLE | refer 与 ap_name 组合的事件来源 |
| tryon_task_model_type | STRING | NULLABLE | 任务模型类型（单品、多品等） |
| tryon_trigger_cnt | INTEGER | NULLABLE | 触发试穿次数 |
| tryon_trigger_device_id | STRING | NULLABLE | 触发试穿事件设备ID |
| tryon_request_cnt | INTEGER | NULLABLE | 发起试穿任务数 |
| tryon_request_device_id | STRING | NULLABLE | 发起试穿用户设备ID |
| tryon_complete_succeed_task_cnt | INTEGER | NULLABLE | 试穿成功任务数 |
| tryon_complete_succeed_device_id | STRING | NULLABLE | 试穿成功用户设备ID |
| tryon_complete_fail_task_cnt | INTEGER | NULLABLE | 试穿失败任务数 |
| tryon_complete_fail_device_id | STRING | NULLABLE | 试穿失败用户设备ID |
| tryon_load_succeed_task_cnt | INTEGER | NULLABLE | 试穿加载成功任务数 |
| tryon_load_succeed_device_id | STRING | NULLABLE | 试穿加载成功用户设备ID |
| tryon_load_fail_task_cnt | INTEGER | NULLABLE | 试穿加载失败任务数 |
| tryon_load_fail_device_id | STRING | NULLABLE | 试穿加载失败用户设备ID |
| tryon_view_detail_task_cnt | INTEGER | NULLABLE | 试穿查看详情任务数 |
| tryon_view_detail_device_id | STRING | NULLABLE | 试穿查看详情用户设备ID |
| tryon_retry_cnt | INTEGER | NULLABLE | 试穿重试次数 |
| tryon_retry_device_id | STRING | NULLABLE | 试穿重试用户设备ID |
| tryon_save_task_cnt | INTEGER | NULLABLE | 试穿保存任务数 |
| tryon_save_device_id | STRING | NULLABLE | 试穿保存用户设备ID |
| tryon_unsave_task_cnt | INTEGER | NULLABLE | 试穿取消保存任务数 |
| tryon_unsave_device_id | STRING | NULLABLE | 试穿取消保存用户设备ID |
| tryon_like_task_cnt | INTEGER | NULLABLE | 试穿点赞任务数 |
| tryon_like_device_id | STRING | NULLABLE | 试穿点赞用户设备ID |
| tryon_dislike_task_cnt | INTEGER | NULLABLE | 试穿点踩任务数 |
| tryon_dislike_device_id | STRING | NULLABLE | 试穿点踩用户设备ID |
| tryon_download_task_cnt | INTEGER | NULLABLE | 试穿下载任务数 |
| tryon_download_device_id | STRING | NULLABLE | 试穿下载用户设备ID |
| tryon_share_task_cnt | INTEGER | NULLABLE | 试穿分享任务数 |
| tryon_share_device_id | STRING | NULLABLE | 试穿分享用户设备ID |
| tryon_post_task_cnt | INTEGER | NULLABLE | 试穿发布任务数 |
| tryon_post_device_id | STRING | NULLABLE | 试穿发布用户设备ID |
| tryon_view_product_task_cnt | INTEGER | NULLABLE | 试穿查看商品任务数 |
| tryon_view_product_device_id | STRING | NULLABLE | 试穿查看商品用户设备ID |
| use_default_avatar | BOOLEAN | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:12
**扫描工具**: scan_metadata_v2.py
