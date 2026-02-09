# dws_favie_gem_search_query_cube_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_search_query_cube_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-08
**最后更新**: 2025-10-08

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
with favie_gem_search_query as (
    select
        trace_id, 

        raw_query,
        qr_query,
        qp_query,
        query_modality,
        query_source,

        query_intention as query_intention_level1,
        query_intention as query_intention_level2,
        ARRAY_LENGTH(TEXT_ANALYZE(raw_query)) as raw_query_word_amt,
        ARRAY_LENGTH(TEXT_ANALYZE(qr_query)) as qr_query_word_amt,
        ARRAY_LENGTH(TEXT_ANALYZE(qp_query)) as qp_query_word_amt,

        device_id,
        user_type,
        is_internal_user,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,
        appsflyer_id, 
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,

        dt
    from favie_dw.dwd_favie_gem_search_query_inc_1d
    where dt = dt_param 
      and raw_query is not null   
  )

  select 
    raw_query,
    qr_query,
    qp_query,
    query_modality,
    query_source,

    query_intention_level1,
    query_intention_level2,
    raw_query_word_amt,
    qr_query_word_amt,
    qp_query_word_amt,

    user_type,
    user_login_type,
    user_tenure_type,
    country_name,
    platform,
    app_version,
    ad_source,
    ad_campaign_id,
    ad_group_id,
    ad_id,
      
    count(distinct trace_id) as query_cnt,
    count(distinct device_id) as query_user_uniq_cnt,
    dt
  from favie_gem_search_query
  group by dt,
    raw_query,
    qr_query,
    qp_query,
    query_modality,
    query_source,

    query_intention_level1,
    query_intention_level2,
    raw_query_word_amt,
    qr_query_word_amt,
    qp_query_word_amt,

    user_type,
    user_login_type,
    user_tenure_type,
    country_name,
    platform,
    app_version,
    ad_source,
    ad_campaign_id,
    ad_group_id,
    ad_id
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
