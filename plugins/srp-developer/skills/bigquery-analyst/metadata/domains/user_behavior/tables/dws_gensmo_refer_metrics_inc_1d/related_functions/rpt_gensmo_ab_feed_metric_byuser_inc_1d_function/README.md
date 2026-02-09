# rpt_gensmo_ab_feed_metric_byuser_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-09-24
**最后更新**: 2025-09-24

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d` (dws_gensmo_refer_metrics_inc_1d)

---

## 💻 函数定义

```sql
WITH refer_interval AS (
        SELECT
            dt,
            device_id,

            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,

            SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,

            refer,
            ap_name,
            event_name,
            event_method,

            refer_duration_amount
        FROM
            `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d`
        WHERE
            dt = dt_param AND user_group like 'ab%'
    ),

    feed_event_interval_by_user AS (
        SELECT
            dt,
            device_id,

            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            refer,
            ab_project_name,
            ab_router_id,
            ab_router_name,

            SUM(refer_duration_amount) AS user_feed_stay_interval,
        FROM
            refer_interval
        WHERE
            refer IN ('home', 'feed_detail', 'hashtag_page', 'feed')
        GROUP BY
            dt,
            device_id,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            refer,
            ab_project_name,
            ab_router_id,
            ab_router_name
            
    ),

    feed_event_pv_by_user AS (
        SELECT
            dt,
            device_id,

            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,

            refer,

            SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,

            SUM(feed_item_view_pv_cnt) AS user_feed_true_view,--true_view
            SUM(feed_item_click_cnt) AS user_content_consumption, --content_consumption
            SAFE_DIVIDE(SUM(feed_item_click_cnt) , SUM(feed_item_view_pv_cnt)) AS user_ctr
        FROM
            favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d
        WHERE
            dt = dt_param AND user_group like 'ab%'
        GROUP BY
            dt,
            device_id,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ab_project_name,
            ab_router_id,
            ab_router_name,
            refer
    )

    SELECT
        t1.dt,
        t1.device_id,

        t1.user_tenure_type,
        t1.user_login_type,
        t1.country_name,
        t1.platform,
        t1.app_version,
        t2.refer,
        t1.ab_project_name,
        t1.ab_router_id,
        t1.ab_router_name,

        t1.user_feed_stay_interval,

        t2.user_feed_true_view,
        t2.user_content_consumption,
        t2.user_ctr
    FROM
        feed_event_interval_by_user t1
    INNER JOIN
        feed_event_pv_by_user t2
    ON
        t1.dt = t2.dt
        AND t1.device_id = t2.device_id
        AND t1.user_tenure_type = t2.user_tenure_type
        AND t1.user_login_type = t2.user_login_type
        AND t1.country_name = t2.country_name
        AND t1.platform = t2.platform
        AND t1.app_version = t2.app_version
        AND t1.ab_project_name = t2.ab_project_name
        AND t1.ab_router_id = t2.ab_router_id
        AND t1.ab_router_name = t2.ab_router_name
        AND t1.refer = t2.refer
```

---

**文档生成**: 2026-01-30 13:39:19
**扫描工具**: scan_functions.py
