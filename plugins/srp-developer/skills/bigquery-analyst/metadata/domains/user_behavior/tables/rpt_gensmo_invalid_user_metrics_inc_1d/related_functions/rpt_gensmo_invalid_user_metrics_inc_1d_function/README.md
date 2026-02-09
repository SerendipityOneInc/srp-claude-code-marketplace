# rpt_gensmo_invalid_user_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-24
**最后更新**: 2025-09-24

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
with valid_device_ids as (
        SELECT 
            distinct  device_id
        FROM `favie_dw.dwd_favie_gensmo_events_inc_1d`
        where dt = dt_param and device_id is not null
        and refer not in ('app','unknown')
    ),
    invalid_device_ids as (
        select 
            distinct device_id
        from `favie_dw.dwd_favie_gensmo_events_inc_1d`
        where dt = dt_param and device_id is not null
        and device_id not in (select device_id from valid_device_ids)
    )
    select  
        dt_param as dt,
        platform,
        app_version,
        geo_country_name,
        event_name,
        event_method,
        count(distinct device_id) as invalid_user_cnt
    from `favie_dw.dwd_favie_gensmo_events_inc_1d`
    where dt = dt_param
    and device_id in (select device_id from invalid_device_ids)
    group by platform, app_version, geo_country_name, event_name, event_method
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
