# dwd_favie_gem_workflow_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_workflow_inc_1d_procedure`
**类型**: PROCEDURE
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
BEGIN
      DELETE FROM `favie_dw.dwd_favie_gem_workflow_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dwd_favie_gem_workflow_inc_1d` (
        trace_id,
        traceparent,
        task_id,
        raw_query,
        query_modality,
        rewrite_queries,
        image_url,
        image_description,
        image_height,
        image_width,
        user_image_tag,
        collage_title,
        intention,
        reasoning,
        query_source,
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
        log_timestamp,
        receive_timestamp,
        dt
      )
      SELECT
        trace_id,
        traceparent,
        task_id,
        raw_query,
        query_modality,
        rewrite_queries,
        image_url,
        image_description,
        image_height,
        image_width,
        user_image_tag,
        collage_title,
        intention,
        reasoning,
        query_source,
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
        log_timestamp,
        receive_timestamp,
        dt
      FROM `favie_dw.dwd_favie_gem_workflow_inc_1d_function`(dt_param);

END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
