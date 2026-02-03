# dws_favie_gensmo_tryon_by_event_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: tryon
**表类型**: TABLE
**行数**: 26,666,822 行
**大小**: 9.90 GB
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
| refer | STRING | NULLABLE | 页面名称 |
| ap_name | STRING | NULLABLE | 交互点名称 |
| event_name | STRING | NULLABLE | 事件名称（select_item、view_item_list 等） |
| event_method | STRING | NULLABLE | 事件触发方式（点击、浏览、摇一摇等） |
| event_action_type | STRING | NULLABLE | 事件行为类型（试穿、无头像试穿等） |
| event_source | STRING | NULLABLE | refer 与 ap_name 组合的事件来源 |
| cal_pre_refer | STRING | NULLABLE | 前一跳页面 |
| cal_pre_refer_ap_name | STRING | NULLABLE | 前一跳交互点名称 |
| cal_pre_event_source | STRING | NULLABLE | 前一跳事件来源组合 |
| home_pv_cnt | INTEGER | NULLABLE | 主页浏览次数 |
| home_device_id | STRING | NULLABLE | 主页事件设备ID |
| tryon_intention_cnt | INTEGER | NULLABLE | 试穿页面浏览次数 |
| tryon_intention_device_id | STRING | NULLABLE | 试穿事件设备ID |
| tryon_select_panel_pv_cnt | INTEGER | NULLABLE | 试穿选择面板浏览次数 |
| tryon_select_panel_confirm_click_cnt | INTEGER | NULLABLE | 试穿选择面板确认按钮点击次数 |
| tryon_select_panel_device_id | STRING | NULLABLE | 试穿选择面板事件设备ID |
| tryon_gen_action_cnt | INTEGER | NULLABLE | 发起试穿操作次数 |
| tryon_gen_action_device_id | STRING | NULLABLE | 发起试穿事件设备ID |
| tryon_gen_action_cnt_2_0 | INTEGER | NULLABLE | 发起试穿操作次数2.0 |
| tryon_gen_action_device_id_2_0 | STRING | NULLABLE | 发起试穿事件设备ID |
| tryon_complete_cnt | INTEGER | NULLABLE | 试穿完成次数 |
| tryon_complete_device_id | STRING | NULLABLE | 试穿完成事件设备ID |
| tryon_channel_click_cnt | INTEGER | NULLABLE | 试穿频道点击次数 |
| tryon_channel_click_device_id | STRING | NULLABLE | 试穿频道点击事件设备ID |
| tryon_complete_detail_task_cnt | INTEGER | NULLABLE | 试穿详情浏览次数 |
| tryon_complete_detail_device_id | STRING | NULLABLE | 试穿详情事件设备ID |
| tryon_gen_panel_pv_cnt | INTEGER | NULLABLE | 试穿生成面板浏览次数 |
| tryon_gen_panel_click_cnt | INTEGER | NULLABLE | 试穿生成面板点击次数 |
| tryon_gen_panel_device_id | STRING | NULLABLE | 试穿生成面板事件设备ID |
| tryon_change_scene_intention_cnt | INTEGER | NULLABLE | 试穿生成换场景次数 |
| tryon_change_scene_intention_device_id | STRING | NULLABLE | 试穿生成换场景事件设备ID |
| tryon_change_scene_gen_cnt | INTEGER | NULLABLE | 试穿生成换场景次数 |
| tryon_change_scene_gen_device_id | STRING | NULLABLE | 试穿生成换场景事件设备ID |
| tryon_change_scene_browse_cnt | INTEGER | NULLABLE | 试穿生成换场景浏览次数 |
| tryon_change_scene_browse_device_id | STRING | NULLABLE | 试穿生成换场景事件设备ID |
| tryon_load_fail_cnt | INTEGER | NULLABLE | 试穿后端数据传输完成后前端渲染失败次数 |
| tryon_load_fail_device_id | STRING | NULLABLE | 试穿后端数据传输渲染失败用户设备id |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:09
**扫描工具**: scan_metadata_v2.py
