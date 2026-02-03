# dim_favie_appsflyer_user_ad_source_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_user_ad_source_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-05
**最后更新**: 2025-10-05

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
WITH all_ad_source AS (
    SELECT
      dt_param as dt,
      dt as created_date,
      appsflyer_id,
      case 
        when lower(trim(source)) in ('default','unknown','') then 'Organic'
        when source is null then 'Organic'
        when lower(source) = 'organic' then 'Organic'
        else source
      end as source,
      channel,
      platform,
      campaign_id,
      campaign_name,
      ad_group_id,
      ad_group_name,
      ad_id,
      ad_name,
      country_code,
      event_name,
      app_name
    FROM `favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view`
    WHERE dt <= dt_param
  )

  SELECT
    dt,
    created_date,
    appsflyer_id,
    source,
    channel,
    platform,
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    ad_id,
    ad_name,
    country_code,
    event_name,
    app_name
  FROM all_ad_source
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
