# rpt_favie_gensmo_tryon_with_dau_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_with_dau_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: tryon
**表类型**: TABLE
**行数**: 1,044,863 行
**大小**: 0.26 GB
**创建时间**: 2025-07-15
**最后更新**: 2025-10-15

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
| home_pv_cnt | INTEGER | NULLABLE | 主页页面浏览量 |
| home_user_cnt | INTEGER | NULLABLE | 主页访问用户数 |
| tryon_intention_cnt | INTEGER | NULLABLE | 试穿页面浏览量 |
| tryon_intention_user_cnt | INTEGER | NULLABLE | 试穿页面访问用户数 |
| tryon_select_panel_pv_cnt | INTEGER | NULLABLE | 试穿选择面板页面浏览量 |
| tryon_select_panel_confirm_click_cnt | INTEGER | NULLABLE | 试穿选择面板确认按钮点击次数 |
| tryon_select_panel_user_cnt | INTEGER | NULLABLE | 试穿选择面板访问用户数 |
| tryon_gen_action_cnt | INTEGER | NULLABLE | 发起试穿操作次数 |
| tryon_gen_action_user_cnt | INTEGER | NULLABLE | 发起试穿操作用户数 |
| tryon_gen_action_cnt_2_0 | INTEGER | NULLABLE | 发起试穿操作次数2.0 |
| tryon_gen_action_user_cnt_2_0 | INTEGER | NULLABLE | 发起试穿操作用户数2.0 |
| tryon_server_complete_task_cnt | INTEGER | NULLABLE | 试穿服务端完成Item数 |
| tryon_server_complete_user_cnt | INTEGER | NULLABLE | 试穿服务端完成访问用户数 |
| tryon_complete_cnt | INTEGER | NULLABLE | 试穿完成次数 |
| tryon_complete_user_cnt | INTEGER | NULLABLE | 试穿完成用户数 |
| tryon_channel_click_cnt | INTEGER | NULLABLE | 试穿完成渠道页点击次数 |
| tryon_channel_click_user_cnt | INTEGER | NULLABLE | 试穿完成渠道页点击用户数 |
| tryon_complete_detail_task_cnt | INTEGER | NULLABLE | 试穿完成详情任务次数 |
| tryon_complete_detail_user_cnt | INTEGER | NULLABLE | 试穿完成详情用户数 |
| tryon_gen_panel_pv_cnt | INTEGER | NULLABLE | 试穿生成面板浏览量 |
| tryon_gen_panel_click_cnt | INTEGER | NULLABLE | 试穿生成面板点击次数 |
| tryon_gen_panel_user_cnt | INTEGER | NULLABLE | 试穿生成面板用户数 |
| tryon_change_scene_intention_cnt | INTEGER | NULLABLE | 试穿生成换场景次数 |
| tryon_change_scene_intention_user_cnt | INTEGER | NULLABLE | 试穿生成换场景访问用户数 |
| tryon_change_scene_gen_cnt | INTEGER | NULLABLE | 试穿生成换场景次数 |
| tryon_change_scene_gen_user_cnt | INTEGER | NULLABLE | 试穿生成换场景访问用户数 |
| tryon_change_scene_browse_cnt | INTEGER | NULLABLE | 试穿生成换场景浏览次数 |
| tryon_change_scene_browse_user_cnt | INTEGER | NULLABLE | 试穿生成换场景浏览用户数 |
| tryon_load_fail_cnt | INTEGER | NULLABLE | 试穿后端数据传输完成后前端渲染失败次数 |
| tryon_load_fail_user_cnt | INTEGER | NULLABLE | 试穿后端数据传输渲染失败用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_with_dau_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:43
**扫描工具**: scan_metadata_v2.py
