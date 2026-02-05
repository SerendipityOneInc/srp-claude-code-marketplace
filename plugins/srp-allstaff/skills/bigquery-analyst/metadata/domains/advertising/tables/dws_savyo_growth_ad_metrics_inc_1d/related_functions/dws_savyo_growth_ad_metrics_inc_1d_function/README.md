# dws_savyo_growth_ad_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_savyo_growth_ad_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

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
with ad_data as (

    SELECT  
		dt
       ,source
       ,platform
       ,app_name
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name 
       ,ad_id
       ,ad_name
       ,ad_category
       ,account_put_type
       ,account_open_agency
      
       ,MAX(country_code) AS country_code
       ,SUM(impression)   AS impression
       ,SUM(click)        AS click
       ,SUM(conversion)   AS conversion
       ,SUM(cost)         AS cost
FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
WHERE dt = dt_param
AND app_name = 'Savyo'
GROUP BY  dt
       ,source
       ,platform
       ,app_name
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name 
       ,ad_id
       ,ad_name
       ,ad_category
       ,account_put_type
       ,account_open_agency
)


select
dt
,source
,platform
,app_name
,account_id
,account_name
,campaign_id
,campaign_name
,ad_group_id
,ad_group_name
,ad_id
,ad_name
,ad_category
,country_code
,'ON_LINE' as channel
,'BOTH' as attribution_method
,account_put_type
,account_open_agency
,impression
,click
,conversion
,cost
,0 as install_cnt
,0 as new_user_cnt
,0 as d0_active_cnt
,0 as d1_retention_cnt
,0 as lt7_cnt
from ad_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
