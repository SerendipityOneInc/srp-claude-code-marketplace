# dws_gensmo_refer_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 388,589,443 行
**大小**: 103.20 GB
**创建时间**: 2025-08-19
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
| user_group | STRING | NULLABLE | 用户分组分类 |
| user_login_type | STRING | NULLABLE | 用户登录类型（匿名、注册等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类（新用户、老用户） |
| device_id | STRING | NULLABLE | 设备唯一标识 |
| ap_name | STRING | NULLABLE | 交互点名称 |
| refer | STRING | NULLABLE | 跳转至当前页面的来源页面或入口 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件触发方式（点击、浏览等） |
| event_action_type | STRING | NULLABLE | 事件行为类型 |
| refer_ap_click_cnt | INTEGER | NULLABLE | 来源页面交互点击次数,这里的点击是宽泛的概念，包含event_method in ('click','shake','swipe','screenshot')四种事件 |
| refer_pv_cnt | INTEGER | NULLABLE | 来源页面浏览次数 |
| refer_leave_directly_cnt | INTEGER | NULLABLE | 来源页面直接离开次数,页面展示后没有任何交互事件（'click','shake','swipe','screenshot'）就离开的次数 |
| refer_duration_amount | FLOAT | NULLABLE | 来源页面停留时长，单位：毫秒，报表请转化为秒进行展示 |
| refer_click_device_id | STRING | NULLABLE | 来源页面点击设备ID，如果refer_ap_click_cnt>0则是device_id,否则为null |
| refer_directly_leave_device_id | STRING | NULLABLE | 来源页面直接离开设备ID，如果refer_directly_leave_device_id>0则是device_id,否则为null |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| ad_id | STRING | NULLABLE | 广告ID |
| refer_backend_cnt | INTEGER | NULLABLE | 来源页面非交互点击次数,这里的非交互点击是指event_method not in ('click','shake','swipe','screenshot')的其他事件 |
| refer_backend_device_id | STRING | NULLABLE | 来源页面非交互点击设备ID，如果refer_backend_cnt>0则是device_id,否则为null |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:08
**扫描工具**: scan_metadata_v2.py
