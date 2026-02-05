# dws_gem_operation_feed_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_feed_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-29
**最后更新**: 2025-09-29

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
  -- 删除当日数据，确保幂等
  DELETE FROM `favie_dw.dws_gem_operation_feed_metrics_inc_1d`
  WHERE dt = dt_param;

  -- 插入最新聚合结果
  INSERT INTO `favie_dw.dws_gem_operation_feed_metrics_inc_1d`
  (
    dt,
    refer,
    collage_id,
    collage_title,
    collage_description,
    image_url,
    is_feed,
    production_type,
    collage_type,
    created_user_id,
    user_id,           -- ✅ 新增字段
    user_name,         -- ✅ 新增字段
    user_email,        -- ✅ 新增字段
    user_tenure_type,
    country_name,
    app_version,
    platform,
    login_type,
    feed_view_pv,
    feed_click_pv,
    feed_view_uv,
    feed_click_uv,
    feed_save_cnt,
    feed_like_cnt,
    feed_try_on_cnt,
    product_external_click_cnt,
    product_detail_click_cnt,
    feed_comment_cnt,
    feed_saved_count,
    feed_liked_count,
    feed_shared_count,
    feed_remix
  )
  SELECT
    dt,
    refer,
    collage_id,
    collage_title,
    collage_description,
    image_url,
    is_feed,
    production_type,
    collage_type,
    created_user_id,
    user_id,           -- ✅ 输出 user_id
    user_name,         -- ✅ 输出 user_name
    user_email,        -- ✅ 输出 user_email
    user_tenure_type,
    country_name,
    app_version,
    platform,
    login_type,
    feed_view_pv,
    feed_click_pv,
    feed_view_uv,
    feed_click_uv,
    feed_save_cnt,
    feed_like_cnt,
    feed_try_on_cnt,
    product_external_click_cnt,
    product_detail_click_cnt,
    feed_comment_cnt,
    feed_saved_count,
    feed_liked_count,
    feed_shared_count,
    feed_remix
  FROM `favie_dw.dws_gem_operation_feed_metrics_inc_1d_function`(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
