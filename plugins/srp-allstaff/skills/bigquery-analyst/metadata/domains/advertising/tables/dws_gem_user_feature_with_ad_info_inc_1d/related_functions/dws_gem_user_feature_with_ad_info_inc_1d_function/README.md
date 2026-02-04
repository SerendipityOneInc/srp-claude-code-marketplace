# dws_gem_user_feature_with_ad_info_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_user_feature_with_ad_info_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2026-01-21
**最后更新**: 2026-01-21

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| start_date | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| end_date | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
SELECT  user_event_dt as dt 
       ,device_id
       ,first_device_id
       ,user_event_appsflyer_id
       ,is_internal_user
       ,user_type
       ,user_tenure_type
       ,created_at
	   ,last_access_at
       ,last_day_feature_geo_continent_name
       ,last_day_feature_geo_sub_continent_name
       ,last_day_feature_geo_country_name
       ,last_day_feature_geo_region_name
       ,last_day_feature_geo_metro_name
       ,last_day_feature_geo_city_name
       ,last_day_feature_access_at
       ,last_day_feature_login_type
       ,last_day_feature_duration
       ,last_day_feature_platform
       ,last_day_feature_app_version
       ,last_day_feature_action_types_with_count
       
       ,af_event_time
       ,af_platform
       ,af_event_name
       ,app_name
       ,source
       ,channel
       ,campaign_name
       ,campaign_id
       ,ad_group_name
       ,ad_group_id
       ,ad_id
       ,ad_name
       ,ROW_NUMBER() OVER (PARTITION BY user_event_dt,device_id ORDER BY  af_event_time ASC) AS af_event_seq
--在这里拿到某一个用户归属于最新的哪一些事件(上一个可能同时归属于三个事件)
FROM
(
	SELECT  user_event_dt
	       ,device_id
	       ,first_device_id
	       ,user_event_appsflyer_id
	       ,is_internal_user
	       ,user_type
	       ,user_tenure_type
	       ,created_at
		   ,last_access_at
	       ,last_day_feature_geo_continent_name
	       ,last_day_feature_geo_sub_continent_name
	       ,last_day_feature_geo_country_name
	       ,last_day_feature_geo_region_name
	       ,last_day_feature_geo_metro_name
	       ,last_day_feature_geo_city_name
	       ,last_day_feature_access_at
	       ,last_day_feature_login_type
	       ,last_day_feature_duration
	       ,last_day_feature_platform
	       ,last_day_feature_app_version
	       ,last_day_feature_action_types_with_count
	       
	       ,af_event_time
	       ,af_platform
	       ,af_event_name
	       ,app_name
	       ,source
	       ,channel
	       ,campaign_name
	       ,campaign_id
	       ,ad_group_name
	       ,ad_group_id
	       ,ad_id
	       ,ad_name
	       ,rank() OVER (PARTITION BY a.user_event_dt,a.user_event_appsflyer_id ORDER BY  date(af_dt) desc  ) AS rk
	FROM
	(
		SELECT  dt                                           AS user_event_dt
		       ,device_id
		       ,first_device_id
		       ,appsflyer_id                                 AS user_event_appsflyer_id
		       ,is_internal_user
		       ,user_type
		       ,user_tenure_type
		       ,created_at
			   ,last_access_at
		       ,last_day_feature.geo_continent_name          AS last_day_feature_geo_continent_name
		       ,last_day_feature.geo_sub_continent_name      AS last_day_feature_geo_sub_continent_name
		       ,last_day_feature.geo_country_name            AS last_day_feature_geo_country_name
		       ,last_day_feature.geo_region_name             AS last_day_feature_geo_region_name
		       ,last_day_feature.geo_metro_name              AS last_day_feature_geo_metro_name
		       ,last_day_feature.geo_city_name               AS last_day_feature_geo_city_name
		       ,last_day_feature.access_at                   AS last_day_feature_access_at
		       ,last_day_feature.login_type                  AS last_day_feature_login_type
		       ,last_day_feature.duration                    AS last_day_feature_duration
		       ,last_day_feature.platform                    AS last_day_feature_platform
		       ,last_day_feature.app_version                 AS last_day_feature_app_version
		       ,last_day_feature.action_types_with_count     AS last_day_feature_action_types_with_count
		       
		FROM `favie_dw.dws_favie_gensmo_user_feature_inc_1d`
		WHERE dt >= start_date and dt <= end_date 
	) a
	LEFT JOIN
	(
		SELECT  dt           AS af_dt
		       ,app_name
		       ,source
		       ,channel
		       ,platform     AS af_platform
		       ,event_name   AS af_event_name
		       ,campaign_name
		       ,campaign_id
		       ,ad_group_name
		       ,ad_group_id
		       ,ad_id
		       ,ad_name
		       ,country_code
		       ,appsflyer_id AS af_appsflyer_id
		       ,event_time AS af_event_time
		FROM `favie_dw.dwd_all_app_total_appsflyer_webhook_inc_1d_view`
		WHERE app_name = 'Gensmo'
		AND channel = 'ON_LINE' 
		AND event_name in ('install','re-engagement','re-attribution')
	)b
	ON a.user_event_appsflyer_id = b.af_appsflyer_id AND a.user_event_dt >= b.af_dt
) t1
WHERE rk = 1
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
