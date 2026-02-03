# dws_favie_gensmo_tryon_by_item_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: tryon
**表类型**: TABLE
**行数**: 8,923,747 行
**大小**: 3.24 GB
**创建时间**: 2025-08-20
**最后更新**: 2025-10-15

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
| task_model | STRING | NULLABLE | 任务模型类型，来源于 dim_try_on_task_view.gen_type |
| task_type | STRING | NULLABLE | 任务类型，来源于 dim_try_on_task_view.type |
| tryon_server_complete_item_cnt | INTEGER | NULLABLE | 试穿服务端完成Item数 |
| tryon_server_complete_user_cnt | INTEGER | NULLABLE | 试穿服务端完成访问用户数 |
| tryon_complete_item_cnt | INTEGER | NULLABLE | 试穿完成Item数 |
| tryon_complete_user_cnt | INTEGER | NULLABLE | 试穿完成用户数 |
| tryon_complete_list_item_cnt | INTEGER | NULLABLE | 试穿完成列表浏览Item数 |
| tryon_complete_list_user_cnt | INTEGER | NULLABLE | 试穿完成列表访问用户数 |
| tryon_complete_list_item_cnt_2_0 | INTEGER | NULLABLE | 试穿完成列表浏览Item数2.0 |
| tryon_complete_list_user_cnt_2_0 | INTEGER | NULLABLE | 试穿完成列表访问用户数2.0 |
| tryon_complete_detail_item_cnt | INTEGER | NULLABLE | 试穿完成页面详情浏览Item数 |
| tryon_complete_detail_user_cnt | INTEGER | NULLABLE | 试穿完成页面详情浏览用户数 |
| tryon_change_scene_intention_item_cnt | INTEGER | NULLABLE | 试穿生成换场景Item数 |
| tryon_change_scene_intention_user_cnt | INTEGER | NULLABLE | 试穿生成换场景访问用户数 |
| tryon_change_scene_gen_item_cnt | INTEGER | NULLABLE | 试穿生成换场景Item数 |
| tryon_change_scene_gen_user_cnt | INTEGER | NULLABLE | 试穿生成换场景访问用户数 |
| tryon_change_scene_browse_item_cnt | INTEGER | NULLABLE | 试穿生成换场景Item浏览数 |
| tryon_change_scene_browse_user_cnt | INTEGER | NULLABLE | 试穿生成换场景浏览用户数 |
| tryon_retry_item_cnt | INTEGER | NULLABLE | 试穿重试Item数 |
| tryon_retry_user_cnt | INTEGER | NULLABLE | 试穿重试访问用户数 |
| tryon_save_item_cnt | INTEGER | NULLABLE | 试穿保存Item数 |
| tryon_save_user_cnt | INTEGER | NULLABLE | 试穿保存访问用户数 |
| tryon_unsave_item_cnt | INTEGER | NULLABLE | 试穿取消保存Item数 |
| tryon_unsave_user_cnt | INTEGER | NULLABLE | 试穿取消保存访问用户数 |
| tryon_download_item_cnt | INTEGER | NULLABLE | 试穿下载Item数 |
| tryon_download_user_cnt | INTEGER | NULLABLE | 试穿下载访问用户数 |
| tryon_like_item_cnt | INTEGER | NULLABLE | 试穿点赞Item数 |
| tryon_like_user_cnt | INTEGER | NULLABLE | 试穿点赞访问用户数 |
| tryon_cancel_like_item_cnt | INTEGER | NULLABLE | 试穿取消点赞Item数 |
| tryon_cancel_like_user_cnt | INTEGER | NULLABLE | 试穿取消点赞访问用户数 |
| tryon_share_item_cnt | INTEGER | NULLABLE | 试穿分享Item数 |
| tryon_share_user_cnt | INTEGER | NULLABLE | 试穿分享访问用户数 |
| tryon_post_item_cnt | INTEGER | NULLABLE | 试穿发布Item数 |
| tryon_post_user_cnt | INTEGER | NULLABLE | 试穿发布访问用户数 |
| tryon_dislike_item_cnt | INTEGER | NULLABLE | 试穿点踩Item数 |
| tryon_dislike_user_cnt | INTEGER | NULLABLE | 试穿点踩访问用户数 |
| tryon_cancel_dislike_item_cnt | INTEGER | NULLABLE | 试穿取消点踩Item数 |
| tryon_cancel_dislike_user_cnt | INTEGER | NULLABLE | 试穿取消点踩访问用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:10
**扫描工具**: scan_metadata_v2.py
