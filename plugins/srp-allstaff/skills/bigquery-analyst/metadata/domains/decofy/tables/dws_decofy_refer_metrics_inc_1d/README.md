# dws_decofy_refer_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_decofy_refer_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: decofy
**表类型**: TABLE
**行数**: 1,989,491 行
**大小**: 0.61 GB
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
| user_id | STRING | NULLABLE | 用户ID |
| platform | STRING | NULLABLE | 平台类型（iOS、Android 等） |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 用户所属国家名称 |
| user_group | STRING | NULLABLE | 用户分组分类 |
| user_login_type | STRING | NULLABLE | 用户登录类型（匿名、注册等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类（新用户、老用户） |
| appsflyer_id | STRING | NULLABLE | Appsflyer ID |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_id | STRING | NULLABLE | 广告ID |
| ap_name | STRING | NULLABLE | 交互点名称 |
| refer | STRING | NULLABLE | 跳转至当前页面的来源页面或入口 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件触发方式（点击、浏览等） |
| event_action_type | STRING | NULLABLE | 事件行为类型 |
| refer_ap_click_cnt | INTEGER | NULLABLE | 来源页面交互点击次数 |
| refer_pv_cnt | INTEGER | NULLABLE | 来源页面浏览次数 |
| refer_view_item_list_cnt | INTEGER | NULLABLE | 来源页面查看Item列表次数 |
| refer_true_view_cnt | INTEGER | NULLABLE | 商品详情页查看次数 |
| refer_leave_directly_cnt | INTEGER | NULLABLE | 来源页面直接离开次数 |
| refer_duration_amount | FLOAT | NULLABLE | 来源页面停留时长 |
| refer_click_user_id | STRING | NULLABLE | 来源页面点击用户ID |
| refer_directly_leave_user_id | STRING | NULLABLE | 来源页面直接离开用户ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_decofy_refer_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:18
**扫描工具**: scan_metadata_v2.py
