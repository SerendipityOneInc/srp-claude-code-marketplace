# dwd_favie_decofy_events_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_events_inc_1d`
**层级**: DWD (明细层)
**业务域**: decofy
**表类型**: TABLE
**行数**: 1,115,571 行
**大小**: 0.65 GB
**创建时间**: 2025-07-25
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期，表示事件发生的日期 |
| session_id | STRING | NULLABLE | 会话ID，标识用户的一次访问会话 |
| user_id | STRING | NULLABLE | 用户ID，已登录用户的唯一标识符 |
| device_id | STRING | NULLABLE | 设备ID，设备的唯一标识符 |
| refer | STRING | NULLABLE | 来源页面，用户访问当前页面前的页面URL或标识 |
| refer_pv_seq | INTEGER | NULLABLE | 来源页面访问序号，在当前会话中的页面访问顺序 |
| pre_refer | STRING | NULLABLE | 前一个来源页面 |
| cal_pre_refer | STRING | NULLABLE | 计算得出的前一个来源页面 |
| cal_pre_refer_event | RECORD | NULLABLE | 计算得出的前一个来源页面事件信息 |
| cal_next_refer | STRING | NULLABLE | 计算得出的下一个来源页面 |
| cal_refer_last_event | RECORD | NULLABLE | 计算得出的来源页面最后一个事件信息 |
| ap_name | STRING | NULLABLE | 交互点名称 |
| user_pseudo_id | STRING | NULLABLE | 用户伪ID，未登录用户的临时标识符 |
| user_login_type | STRING | NULLABLE | 用户登录类型，如邮箱、手机号、第三方登录等 |
| event_name | STRING | NULLABLE | 事件名称，描述用户执行的具体行为 |
| event_method | STRING | NULLABLE | 事件方法，事件触发的方式或类型 |
| event_action_type | STRING | NULLABLE | 事件动作类型，如点击、浏览、购买等 |
| event_ab_infos | STRING | REPEATED | AB测试信息数组，记录用户参与的AB测试标识 |
| event_items | RECORD | REPEATED | 事件相关的商品信息数组 |
| event_interval | FLOAT | NULLABLE | 事件间隔时间，与上一个事件的时间间隔（秒） |
| event_version | STRING | NULLABLE | 事件版本，用于标识事件数据结构的版本 |
| event_source | STRING | NULLABLE | 事件来源，标识事件的数据来源系统 |
| event_timestamp | TIMESTAMP | NULLABLE | 事件时间戳，事件发生的精确时间 |
| event_uuid | STRING | NULLABLE | 事件唯一标识符，用于事件去重和追踪 |
| geo_continent_name | STRING | NULLABLE | 地理位置-大洲名称 |
| geo_sub_continent_name | STRING | NULLABLE | 地理位置-次大洲名称 |
| geo_region_name | STRING | NULLABLE | 地理位置-地区名称 |
| geo_metro_name | STRING | NULLABLE | 地理位置-都市区名称 |
| geo_country_name | STRING | NULLABLE | 地理位置-国家名称 |
| geo_city_name | STRING | NULLABLE | 地理位置-城市名称 |
| device_category | STRING | NULLABLE | 设备类别，如mobile、desktop、tablet等 |
| device_mobile_brand_name | STRING | NULLABLE | 移动设备品牌名称，如Apple、Samsung等 |
| device_mobile_model_name | STRING | NULLABLE | 移动设备型号名称，如iPhone 13、Galaxy S21等 |
| device_mobile_os_hardware_model | STRING | NULLABLE | 移动设备操作系统硬件型号 |
| device_operating_system | STRING | NULLABLE | 设备操作系统，如iOS、Android、Windows等 |
| device_operating_system_version | STRING | NULLABLE | 设备操作系统版本号 |
| device_vendor_id | STRING | NULLABLE | 设备厂商ID，设备制造商的标识符 |
| device_language | STRING | NULLABLE | 设备语言设置 |
| device_is_limited_ad_tracking | STRING | NULLABLE | 设备是否限制广告追踪，用户隐私设置 |
| platform | STRING | NULLABLE | 平台类型，如iOS、Android、Web等 |
| app_version | STRING | NULLABLE | 应用版本号 |
| web_version | STRING | NULLABLE | 网页版本号 |
| utm_source | STRING | NULLABLE | UTM来源参数，用于营销活动追踪 |
| stream_id | STRING | NULLABLE | 流ID，用于数据流标识 |
| appsflyer_id | STRING | NULLABLE | AppsFlyer追踪ID，用于移动应用归因分析 |
| home_request_seq | INTEGER | NULLABLE | 首页请求序号，用户在会话中的首页请求顺序 |
| home_request_first_event_name | STRING | NULLABLE | 首页请求的第一个事件名称 |
| home_request_first_event_method | STRING | NULLABLE | 首页请求的第一个事件方法 |
| home_request_first_event_action_type | STRING | NULLABLE | 首页请求的第一个事件动作类型 |
| home_request_first_event_ap_name | STRING | NULLABLE | 首页请求的第一个事件应用名称 |
| home_request_first_event_items | RECORD | REPEATED | 首页请求的第一个事件相关商品信息 |
| app_version_seq | INTEGER | NULLABLE | 应用版本序号，用于应用版本排序 |
| web_version_seq | INTEGER | NULLABLE | 网页版本序号，用于网页版本排序 |
| event_version_seq | INTEGER | NULLABLE | 事件版本序号，用于事件版本排序 |
| refer_group | STRING | NULLABLE | 来源分组，用于对有效来源值进行分组归类 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_events_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:26
**扫描工具**: scan_metadata_v2.py
