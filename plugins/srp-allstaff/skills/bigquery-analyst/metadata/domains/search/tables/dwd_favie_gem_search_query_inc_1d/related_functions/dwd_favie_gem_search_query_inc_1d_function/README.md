# dwd_favie_gem_search_query_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_search_query_inc_1d_function`
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
    t3.task_id,
    t3.raw_query,
    t1.qr_query,
    t2.qp_query,
    t3.rewrite_queries,
  
    coalesce(t3.query_modality,"unknown") as query_modality,
    t3.image_url as query_image_url,
    t3.image_description as query_image_description,
    t3.image_height as query_image_height,
    t3.image_width as query_image_width,
    t3.user_image_tag as query_image_tag,
    t3.intention as query_intention,
    t3.query_source,
    
    t3.collage_title,
    t3.reasoning,
    t3.device_id,
    t3.user_type,
    t3.is_internal_user,
    t3.user_login_type,
    t3.user_tenure_type,
    t3.country_name,
    t3.platform,
    t3.app_version,
    t3.appsflyer_id,
    t3.ad_source,
    t3.ad_campaign_id,
    t3.ad_group_id,
    t3.ad_id,

    SPLIT(t1.qr_results, ',') AS query_results,
    t1.log_timestamp,
    t1.receive_timestamp,
    t1.dt
  FROM (select * from `favie_dw.dwd_favie_ha3_rank_inc_1d_view` where dt = dt_param) t1
  left outer join (select * from `favie_dw.dwd_favie_search_proxy_inc_1d_view` where dt = dt_param) t2
  on t1.trace_id = t2.trace_id
  left outer join  (select * from favie_dw.dwd_favie_gem_workflow_inc_1d where dt = dt_param) t3
  on t1.trace_id = t3.trace_id
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
