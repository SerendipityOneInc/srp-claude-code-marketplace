# dwd_gem_operation_feed_full_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_operation_feed_full_procedure`
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
    -- 先删除当天的数据，确保幂等性
    DELETE FROM `favie_dw.dwd_gem_operation_feed_full`
    WHERE DATE(created_date) = dt_param;

    -- 插入最新数据
    INSERT INTO `favie_dw.dwd_gem_operation_feed_full`
    (
      collage_id,
      created_date,
      created_at,
      created_user_id,
      collage_title,
      collage_description,
      category,
      image_url,
      publisher,
      is_feed,
      is_onboard,
      moderation_status,
      liked_count,
      saved_count,
      shared_count,
      remix,
      hashtags,
      tag_dt,
      style_one_tags,
      style_two_tags,
      occasion_one_tags,
      occasion_two_tags,
      color_tags,
      weather_tags,
      temperature_tags,
      gender_tags,
      age_tags,
      body_size_tags,
      body_shape_tags,
      height_tags,
      is_UGC,
      is_duplicate_image,
      production_type
    )
    SELECT
      collage_id,
      created_date,
      created_at,
      created_user_id,
      collage_title,
      collage_description,
      category,
      image_url,
      publisher,
      is_feed,
      is_onboard,
      moderation_status,
      liked_count,
      saved_count,
      shared_count,
      remix,
      hashtags,
      tag_dt,
      style_one_tags,
      style_two_tags,
      occasion_one_tags,
      occasion_two_tags,
      color_tags,
      weather_tags,
      temperature_tags,
      gender_tags,
      age_tags,
      body_size_tags,
      body_shape_tags,
      height_tags,
      is_UGC,
      is_duplicate_image,
      production_type
    FROM `favie_dw.dwd_gem_operation_feed_full_function`(dt_param);  -- 对应你的函数视图
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
