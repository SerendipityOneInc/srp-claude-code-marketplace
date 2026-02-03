# dws_decofy_subscribe_process_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_process_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-23
**最后更新**: 2025-09-23

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH subscription_process_data AS (
        SELECT
            dt,
            user_id,
            process_node,
            trigger_source,
            product_id,
            simple_product_id,
            order_id,
            order_category,
            order_type,
            order_subscription_seq,
            process_time,
            trigger_pay_seq
        FROM favie_dw.dwd_favie_decofy_subscription_process_inc_1d
        WHERE dt = dt_param
        and coalesce(trim(user_id), '') != ''
        and lower(user_id) not in ("unknown","default")
    ),

    subscription_process_metrics AS (
        SELECT
            t1.dt,
            t1.user_id,
            t1.trigger_source,
            t1.product_id,
            t1.simple_product_id,
            t1.order_category,
            t1.order_type,
            COUNTIF(t1.process_node = 'trigger_pay') AS subscribe_trigger_cnt,
            if(COUNTIF(t1.process_node = 'trigger_pay') > 0,user_id,null) AS subscribe_trigger_user_id,
            COUNTIF(t1.order_subscription_seq = 1 AND t1.process_node = 'order') AS subscribe_first_order_cnt,
            if(COUNTIF(t1.order_subscription_seq = 1 AND t1.process_node = 'order') > 0,user_id,null) AS subscribe_first_order_user_id
        FROM subscription_process_data t1
        GROUP BY dt, user_id, trigger_source, product_id, simple_product_id, order_category, order_type
    ),

    user_group AS (
        SELECT
            dt,
            user_id,
            user_group,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        FROM favie_dw.dws_decofy_user_group_inc_1d
        WHERE dt = dt_param
    )

    SELECT
        t1.dt,
        t1.user_id,
        COALESCE(t2.country_name, 'Unknown') AS country_name,
        COALESCE(t2.platform, 'Unknown') AS platform,
        COALESCE(t2.app_version, 'Unknown') AS app_version,
        COALESCE(t2.user_group, 'Unknown') AS user_group,
        COALESCE(t2.ad_source, 'Unknown') AS ad_source,
        COALESCE(t2.ad_id, 'Unknown') AS ad_id,
        COALESCE(t2.ad_group_id, 'Unknown') AS ad_group_id,
        COALESCE(t2.ad_campaign_id, 'Unknown') AS ad_campaign_id,
        COALESCE(t1.product_id, 'Unknown') AS product_id,
        COALESCE(t1.simple_product_id, 'Unknown') AS simple_product_id,
        COALESCE(t1.order_category, 'Unknown') AS order_category,
        COALESCE(t1.order_type, 'Unknown') AS order_type,
        COALESCE(t1.trigger_source, 'Unknown') AS subscribe_trigger_source,
        t1.subscribe_trigger_cnt,
        t1.subscribe_trigger_user_id,
        t1.subscribe_first_order_cnt,
        t1.subscribe_first_order_user_id
    FROM subscription_process_metrics t1
    LEFT JOIN user_group t2
        ON t1.user_id = t2.user_id AND t1.dt = t2.dt
    where t2.user_id is not null
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
