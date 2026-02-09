# rpt_decofy_subscribe_notification_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_notification_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-10-15
**最后更新**: 2025-10-15

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

- `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_notification_full_1d` (dwd_favie_decofy_subscription_notification_full_1d)
- `srpproduct-dc37e.favie_dw.dws_decofy_user_group_inc_1d` (dws_decofy_user_group_inc_1d)

---

## 💻 函数定义

```sql
WITH notification_base AS (
		SELECT
			dt_param as dt,
            user_id,
            appsflyer_id,
            product_id,
            simple_product_id,
            product_period,
            notification_type,
            subtype,
		FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_notification_full_1d`
		WHERE dt = (select max(dt) from `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_notification_full_1d` where dt is not null)
            AND date(created_at) = dt_param
            AND notification_type IN ('DID_CHANGE_RENEWAL_STATUS','REFUND')
	),

    user_group AS (
        SELECT
            user_id,
            user_group,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        FROM `srpproduct-dc37e.favie_dw.dws_decofy_user_group_inc_1d`
        where dt = dt_param
    ),


    notification_joined AS (
        SELECT
            t1.dt,
            t1.user_id,
            coalesce(t2.country_name, 'Unknown') AS country_name,
            coalesce(t2.platform, 'Unknown') AS platform,
            coalesce(t2.app_version, 'Unknown') AS app_version,
            coalesce(t2.user_group, 'Unknown') AS user_group,


            coalesce(t2.ad_source, 'Unknown') AS ad_source,
            coalesce(t2.ad_campaign_id, 'Unknown') AS ad_campaign_id,
            coalesce(t2.ad_group_id, 'Unknown') AS ad_group_id,
            coalesce(t2.ad_id, 'Unknown') AS ad_id,

            t1.notification_type,
            t1.subtype,

            t1.product_id,
            t1.simple_product_id
        FROM notification_base t1
        LEFT JOIN user_group t2
        ON t1.user_id = t2.user_id
        where t2.user_id is not null
    )

	SELECT
        dt,
        country_name,
        platform,
        app_version,
        user_group,

        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        product_id,
        simple_product_id,

        COUNTIF(
            subtype = 'AUTO_RENEW_DISABLED'
            AND notification_type = 'DID_CHANGE_RENEWAL_STATUS'
            ) AS subscribe_disable_notification_cnt,

        COUNTIF(
            notification_type = 'REFUND'
        ) AS subscribe_refund_notification_cnt
	FROM notification_joined
    group by 
        dt,
        country_name,
        platform,
        app_version,
        user_group,

        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        product_id,
        simple_product_id
```

---

**文档生成**: 2026-01-30 13:38:40
**扫描工具**: scan_functions.py
