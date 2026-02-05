# dwd_favie_gem_workflow_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_workflow_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-07
**最后更新**: 2025-10-07

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
SELECT  
    t1.trace_id,
    t1.traceparent,
    t1.task_id,
    t1.raw_query,
    CASE 
      WHEN (t1.raw_query is not null and trim(t1.raw_query) != "") and (t1.image_url is not null and trim(t1.image_url) != "") THEN "text&image" 
      WHEN (t1.raw_query is not null and trim(t1.raw_query) != "") and (t1.image_url is null or trim(t1.image_url) = "") THEN "text" 
      WHEN (t1.raw_query is null or trim(t1.raw_query) = "") and (t1.image_url is not null and trim(t1.image_url) != "") THEN "image" 
      ELSE "unknown" 
    END AS query_modality,
    t1.rewrite_queries,
    t1.image_url,
    t1.image_description,
    cast(t1.image_height as int64) as image_height,
    cast(t1.image_width as int64) as image_width,
    t1.user_image_tag,
    t1.collage_title,
    t1.intention,
    t1.reasoning,
    t1.query_source,
    t1.device_id,
    t2.user_type,
    t2.is_internal_user,
    t2.user_login_type,
    t2.user_tenure_type,
    t2.permanent_geo_address.geo_country_name as country_name,
    t2.last_access_info.app_info.platform as platform,
    coalesce(t1.app_version,t2.last_access_info.app_info.app_version) as app_version,
    t2.last_access_info.appsflyer_id as appsflyer_id,
    t2.ad_source,
    t2.ad_campaign_id,
    t2.ad_group_id,
    t2.ad_id,
    t1.log_timestamp,
    t1.receive_timestamp,
    t1.dt
  FROM (select * from favie_dw.dwd_favie_gem_workflow_inc_1d_view where dt = dt_param) t1 
  left outer join favie_dw.dim_favie_gensmo_user_snapshot_with_ad_function(dt_param,false)  t2
  on coalesce(trim(t1.device_id),"") != "" and t1.device_id = t2.device_id
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
