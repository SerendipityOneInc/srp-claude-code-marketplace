# dws_favie_gensmo_search_by_event_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: search
**表类型**: TABLE
**行数**: 53,123,548 行
**大小**: 20.47 GB
**创建时间**: 2025-09-09
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
| user_login_type | STRING | NULLABLE | 用户登录类型（登陆、未登陆） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类，如新用户、老用户 |
| user_group | STRING | NULLABLE | 用户分群标签 |
| device_id | STRING | NULLABLE | 设备ID |
| refer | STRING | NULLABLE | 事件来源 |
| ap_name | STRING | NULLABLE | 应用名称 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件方法 |
| event_action_type | STRING | NULLABLE | 事件动作类型 |
| event_source | STRING | NULLABLE | 事件来源 |
| cal_pre_refer | STRING | NULLABLE | 计算前事件来源 |
| cal_pre_refer_ap_name | STRING | NULLABLE | 计算前事件应用名称 |
| cal_pre_event_source | STRING | NULLABLE | 计算前事件来源 |
| home_pv_cnt | INTEGER | NULLABLE | 首页页面浏览次数 |
| home_device_id | STRING | NULLABLE | 首页设备ID |
| collage_intention_cnt | INTEGER | NULLABLE | 搜索意图次数 |
| collage_intention_device_id | STRING | NULLABLE | 搜索意图设备ID |
| search_boot_panel_pv_cnt | INTEGER | NULLABLE | 搜索启动面板浏览次数 |
| search_boot_panel_generate_click_cnt | INTEGER | NULLABLE | 搜索启动面板生成点击次数 |
| search_boot_panel_device_id | STRING | NULLABLE | 搜索启动面板设备ID |
| collage_gen_action_cnt | INTEGER | NULLABLE | 搜索生成动作次数 |
| collage_gen_action_device_id | STRING | NULLABLE | 搜索生成动作设备ID |
| collage_gen_action_cnt_2_0 | INTEGER | NULLABLE | 搜索生成动作2.0版本次数 |
| collage_gen_action_device_id_2_0 | STRING | NULLABLE | 搜索生成动作2.0版本设备ID |
| collage_complete_cnt | INTEGER | NULLABLE | 搜索完成次数 |
| collage_complete_device_id | STRING | NULLABLE | 搜索完成设备ID |
| collage_channel_click_cnt | INTEGER | NULLABLE | 搜索频道点击次数 |
| collage_channel_click_device_id | STRING | NULLABLE | 搜索频道点击设备ID |
| collage_complete_detail_task_cnt | INTEGER | NULLABLE | 搜索完成详细任务次数 |
| collage_complete_detail_device_id | STRING | NULLABLE | 搜索完成详细任务设备ID |
| collage_gen_panel_pv_cnt | INTEGER | NULLABLE | 搜索生成面板页面浏览次数 |
| collage_gen_panel_click_cnt | INTEGER | NULLABLE | 搜索生成面板点击次数 |
| collage_gen_panel_device_id | STRING | NULLABLE | 搜索生成面板设备ID |
| model_type | STRING | NULLABLE | 搜索模式 |
| search_result_product_click_cnt | INTEGER | NULLABLE | 搜索结果商品点击次数 |
| search_result_positive_cnt | INTEGER | NULLABLE | 搜索结果正反馈次数 |
| channel_collage_click_cnt | INTEGER | NULLABLE | 频道拼贴点击次数 |
| channel_screen_cnt | INTEGER | NULLABLE | 频道页面浏览次数 |
| channel_device_id | STRING | NULLABLE | 频道设备ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:05
**扫描工具**: scan_metadata_v2.py
