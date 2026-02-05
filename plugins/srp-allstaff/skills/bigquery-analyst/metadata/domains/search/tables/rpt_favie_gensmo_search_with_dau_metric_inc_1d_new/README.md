# rpt_favie_gensmo_search_with_dau_metric_inc_1d_new

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_new`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: TABLE
**行数**: 33,256,361 行
**大小**: 4.26 GB
**创建时间**: 2025-08-06
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
| user_login_type | STRING | NULLABLE | 用户登录类型（login、guest等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类，如新用户、老用户 |
| user_group | STRING | NULLABLE | 用户分群标签 |
| active_user_d1_cnt | INTEGER | NULLABLE | 日活跃用户数 |
| home_pv_cnt | INTEGER | NULLABLE | 主页页面浏览量 |
| home_user_cnt | INTEGER | NULLABLE | 主页访问用户数 |
| collage_intention_cnt | INTEGER | NULLABLE | 搜索页面浏览量 |
| collage_intention_user_cnt | INTEGER | NULLABLE | 搜索页面访问用户数 |
| search_boot_panel_pv_cnt | INTEGER | NULLABLE | 搜索选择面板页面浏览量 |
| search_boot_panel_generate_click_cnt | INTEGER | NULLABLE | 搜索选择面板确认按钮点击次数 |
| search_boot_panel_user_cnt | INTEGER | NULLABLE | 搜索选择面板访问用户数 |
| collage_gen_action_cnt | INTEGER | NULLABLE | 发起搜索操作次数 |
| collage_gen_action_user_cnt | INTEGER | NULLABLE | 发起搜索操作用户数 |
| collage_gen_action_cnt_2_0 | INTEGER | NULLABLE | 发起搜索操作次数2.0 |
| collage_gen_action_user_cnt_2_0 | INTEGER | NULLABLE | 发起搜索操作用户数2.0 |
| collage_server_complete_task_cnt | INTEGER | NULLABLE | 搜索服务端完成Item数 |
| collage_server_complete_user_cnt | INTEGER | NULLABLE | 搜索服务端完成访问用户数 |
| collage_complete_cnt | INTEGER | NULLABLE | 搜索完成次数 |
| collage_complete_user_cnt | INTEGER | NULLABLE | 搜索完成用户数 |
| collage_channel_click_cnt | INTEGER | NULLABLE | 搜索完成渠道页点击次数 |
| collage_channel_click_user_cnt | INTEGER | NULLABLE | 搜索完成渠道页点击用户数 |
| collage_complete_detail_task_cnt | INTEGER | NULLABLE | 搜索完成详情任务次数 |
| collage_complete_detail_user_cnt | INTEGER | NULLABLE | 搜索完成详情用户数 |
| collage_gen_panel_pv_cnt | INTEGER | NULLABLE | 搜索生成面板浏览量 |
| collage_gen_panel_click_cnt | INTEGER | NULLABLE | 搜索生成面板点击次数 |
| collage_gen_panel_user_cnt | INTEGER | NULLABLE | 搜索生成面板用户数 |
| search_result_product_click_cnt | INTEGER | NULLABLE | 搜索结果商品点击次数 |
| search_result_positive_cnt | INTEGER | NULLABLE | 搜索结果正反馈次数 |
| channel_collage_click_cnt | INTEGER | NULLABLE | 频道拼贴点击次数 |
| channel_screen_cnt | INTEGER | NULLABLE | 频道页面浏览次数 |
| channel_user_cnt | INTEGER | NULLABLE | 频道设备用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_new`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:28
**扫描工具**: scan_metadata_v2.py
