# dws_favie_gensmo_feed_bysource_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: feed
**表类型**: TABLE
**行数**: 116,330,254 行
**大小**: 46.76 GB
**创建时间**: 2025-08-20
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
| refer | STRING | NULLABLE | 跳转至当前页面的来源页面或入口 |
| ap_name | STRING | NULLABLE | 交互点名称 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件触发方式（点击、浏览等） |
| event_action_type | STRING | NULLABLE | 事件行为类型 |
| event_source | STRING | NULLABLE | 事件来源组合 |
| item_type | STRING | NULLABLE | 内容项类型 |
| item_intention | STRING | NULLABLE | 内容项意图 |
| feed_source | STRING | NULLABLE | 信息流来源 |
| home_pv_cnt | INTEGER | NULLABLE | 主页浏览次数 |
| home_device_id | STRING | NULLABLE | 主页事件设备ID |
| feed_item_list_pv_cnt | INTEGER | NULLABLE | 信息流列表浏览次数 |
| feed_item_list_device_id | STRING | NULLABLE | 信息流列表事件设备ID |
| feed_item_view_pv_cnt | INTEGER | NULLABLE | 信息流内容浏览次数 |
| feed_item_view_device_id | STRING | NULLABLE | 信息流内容浏览事件设备ID |
| feed_item_click_cnt | INTEGER | NULLABLE | 信息流内容点击次数 |
| feed_item_click_device_id | STRING | NULLABLE | 信息流内容点击事件设备ID |
| feed_detail_click_cnt | INTEGER | NULLABLE | 信息流详情点击次数 |
| feed_item_tryon_click_cnt | INTEGER | NULLABLE | 信息流试穿点击次数 |
| feed_item_remix_click_cnt | INTEGER | NULLABLE | 信息流重混合点击次数 |
| feed_item_save_share_click_cnt | INTEGER | NULLABLE | 信息流保存分享点击次数 |
| feed_item_product_click_cnt | INTEGER | NULLABLE | 信息流商品点击次数 |
| feed_item_detail_pv_cnt | INTEGER | NULLABLE | 信息流详情浏览次数 |
| feed_item_detail_click_device_id | STRING | NULLABLE | 信息流详情点击事件设备ID |
| feed_product_detail_click_cnt | INTEGER | NULLABLE | 信息流商品详情点击次数 |
| feed_product_detail_pv_cnt | INTEGER | NULLABLE | 信息流商品详情浏览次数 |
| feed_product_detail_device_id | STRING | NULLABLE | 信息流商品详情事件设备ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:59
**扫描工具**: scan_metadata_v2.py
