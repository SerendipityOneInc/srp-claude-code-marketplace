# rpt_gensmo_ab_feed_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: TABLE
**行数**: 1,150,294 行
**大小**: 0.16 GB
**创建时间**: 2025-07-04
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| user_tenure_type | STRING | NULLABLE | 用户新老类型 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| country_name | STRING | NULLABLE | 国家 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| ab_project_name | STRING | NULLABLE | 实验名 |
| ab_router_id | STRING | NULLABLE | 分组id |
| ab_router_name | STRING | NULLABLE | 分组名称 |
| content_consumption_pv_cnt | INTEGER | NULLABLE | 内容消费PV数 |
| feed_stay_interval_total_cnt | FLOAT | NULLABLE | feed_detail和home停留总时长 |
| feed_true_view_pv_cnt | INTEGER | NULLABLE | Feed真实曝光PV数 |
| content_consumption_user_cnt | INTEGER | NULLABLE | 从首页进入feed详情页的用户数 |
| feed_stay_user_cnt | INTEGER | NULLABLE | 停留在feed_detail和home页的用户数 |
| feed_true_view_user_cnt | INTEGER | NULLABLE | feed真实曝光的用户数 |
| refer | STRING | NULLABLE | 来源 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:20
**扫描工具**: scan_metadata_v2.py
