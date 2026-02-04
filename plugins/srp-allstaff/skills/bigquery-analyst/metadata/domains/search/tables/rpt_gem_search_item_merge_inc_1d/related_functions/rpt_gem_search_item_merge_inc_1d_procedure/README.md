# rpt_gem_search_item_merge_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_search_item_merge_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-08-27
**最后更新**: 2025-08-27

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
    -- 先删掉当天的数据
    DELETE FROM favie_rpt.rpt_gem_search_item_merge_inc_1d
    WHERE dt = dt_param;

    -- 插入最新数据
    INSERT INTO favie_rpt.rpt_gem_search_item_merge_inc_1d
    (
      dt,
      trace_id,
      search_image,
      collage_number,
      created_time,
      created_date,
      product_main_image_url,
      product_image_info,
      best_view,
      has_person,
      is_bad,
      is_clear_background,
      is_relevant,
      is_nice_collage,
      brand,
      platform,
      link_host,
      intention,
      user_id,
      region,
      product_search_engine,
      route,
      gender,
      device_id,
      f_version,
      cf_ipcountry,
      query,
      f_source,
      search_latency
    )
    SELECT
      dt_param AS dt,
      trace_id,
      search_image,
      collage_number,
      created_time,
      created_date,
      product_main_image_url,
      product_image_info,
      best_view,
      has_person,
      is_bad,
      is_clear_background,
      is_relevant,
      is_nice_collage,
      brand,
      platform,
      link_host,
      intention,
      user_id,
      region,
      product_search_engine,
      route,
      gender,
      device_id,
      f_version,
      cf_ipcountry,
      query,
      f_source,
      search_latency
    FROM favie_rpt.rpt_gem_search_item_merge_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
