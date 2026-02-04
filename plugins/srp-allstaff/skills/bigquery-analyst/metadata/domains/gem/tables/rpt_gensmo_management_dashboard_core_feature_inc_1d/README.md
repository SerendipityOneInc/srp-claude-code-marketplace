# rpt_gensmo_management_dashboard_core_feature_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_core_feature_inc_1d`
**层级**: RPT (报表层)
**业务域**: gem
**表类型**: TABLE
**行数**: 241,428 行
**大小**: 0.07 GB
**创建时间**: 2025-07-17
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 事件日期，分区字段 |
| is_new_user | STRING | NULLABLE | 是否为新用户 (new/old) |
| ad_media_source | STRING | NULLABLE | 广告媒体来源 |
| user_country | STRING | NULLABLE | 用户所在国家 |
| last_platform | STRING | NULLABLE | 用户当日使用最多的平台 |
| last_app_version | STRING | NULLABLE | 用户当日使用最多的app版本号 |
| user_type | STRING | NULLABLE | 用户类型 (unregister/register/deregister) |
| total_active_user | INTEGER | NULLABLE | 当日总活跃用户数 |
| total_active_seconds | FLOAT | NULLABLE | 当日总活跃时长 |
| login_uv | INTEGER | NULLABLE | 登录用户数 |
| avatar_start_page_show_uv | INTEGER | NULLABLE | 模特生成页展示独立用户数 |
| avatar_start_page_show_pv | INTEGER | NULLABLE | 模特生成页展示事件数 |
| enter_any_flow_uv | INTEGER | NULLABLE | 进入任一流程（默认或自拍）独立用户数 |
| enter_any_flow_pv | INTEGER | NULLABLE | 进入任一流程（默认或自拍）事件数 |
| complete_any_creation_uv | INTEGER | NULLABLE | 完成任一创建（默认或自拍）独立用户数 |
| complete_any_creation_pv | INTEGER | NULLABLE | 完成任一创建（默认或自拍）事件数 |
| enter_default_flow_uv | INTEGER | NULLABLE | 进入默认流程独立用户数 |
| enter_default_flow_pv | INTEGER | NULLABLE | 进入默认流程事件数 |
| complete_default_creation_uv | INTEGER | NULLABLE | 完成默认创建独立用户数 |
| complete_default_creation_pv | INTEGER | NULLABLE | 完成默认创建事件数 |
| enter_selfie_flow_uv | INTEGER | NULLABLE | 进入自拍流程独立用户数 |
| enter_selfie_flow_pv | INTEGER | NULLABLE | 进入自拍流程事件数 |
| complete_selfie_creation_uv | INTEGER | NULLABLE | 完成自拍创建独立用户数 |
| complete_selfie_creation_pv | INTEGER | NULLABLE | 完成自拍创建事件数 |
| feed_true_view_uv | INTEGER | NULLABLE | Feed 真实曝光独立用户数 |
| feed_true_view_pv | INTEGER | NULLABLE | Feed 真实曝光事件数 |
| feed_interaction_uv | INTEGER | NULLABLE | Feed 交互独立用户数 |
| feed_interaction_pv | INTEGER | NULLABLE | Feed 交互事件数 |
| feed_detail_page_view_uv | INTEGER | NULLABLE | Feed 详情页曝光独立用户数 |
| feed_detail_page_view_pv | INTEGER | NULLABLE | Feed 详情页曝光事件数 |
| search_uv | INTEGER | NULLABLE | 全部搜索独立用户数 |
| search_pv | INTEGER | NULLABLE | 全部搜索事件数 |
| query_text_only_uv | INTEGER | NULLABLE | 文搜独立用户数 |
| query_text_only_pv | INTEGER | NULLABLE | 文搜事件数 |
| query_text_pic_uv | INTEGER | NULLABLE | 图搜独立用户数 |
| query_text_pic_pv | INTEGER | NULLABLE | 图搜事件数 |
| try_on_uv | INTEGER | NULLABLE | 试穿功能独立用户数 |
| try_on_pv | INTEGER | NULLABLE | 试穿功能事件数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_core_feature_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:01
**扫描工具**: scan_metadata_v2.py
