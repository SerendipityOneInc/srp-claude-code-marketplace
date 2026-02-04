# dwd_favie_gensmo_moodboard_product_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-27
**最后更新**: 2025-10-27

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    DECLARE current_dt DATE;
    SET current_dt = dt_param;

    WHILE n_day>=1 DO

        -- remove old data
        DELETE FROM favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d
        WHERE dt IS NOT NULL AND dt = current_dt;

        -- insert new data
        INSERT INTO favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d(
            moodboard_id,
            moodboard_task_id,
            moodboard_index,
            raw_query,
            moodboard_created_user_id,
            moodboard_user_gender,
            moodboard_created_time,
            moodboard_updated_time,
            moodboard_description,
            moodboard_is_feed,
            moodboard_is_try_on,
            moodboard_hashtags,
            moodboard_image_url,
            user_image_tag,
            user_image_url,
            user_image_description,
            moodboard_liked_count,
            moodboard_saved_count,
            moodboard_shared_count,
            intention,
            reasoning,
            is_onboard,
            moderation_status,
            publisher,
            product_id,
            product_created_time,
            product_updated_time,
            product_brand,
            product_norm_brand,
            product_brand_link,
            product_link,
            product_site,
            product_platform,
            product_title,
            product_collage_category,
            product_tags,
            product_display_image,
            product_main_image,
            qp_query,
            search_engine,
            time_gap,
            dt
        )
        SELECT 
            moodboard_id,
            moodboard_task_id,
            moodboard_index,
            raw_query,
            moodboard_created_user_id,
            moodboard_user_gender,
            moodboard_created_time,
            moodboard_updated_time,
            moodboard_description,
            moodboard_is_feed,
            moodboard_is_try_on,
            moodboard_hashtags,
            moodboard_image_url,
            user_image_tag,
            user_image_url,
            user_image_description,
            moodboard_liked_count,
            moodboard_saved_count,
            moodboard_shared_count,
            intention,
            reasoning,
            is_onboard,
            moderation_status,
            publisher,
            product_id,
            product_created_time,
            product_updated_time,
            product_brand,
            product_norm_brand,
            product_brand_link,
            product_link,
            product_site,
            product_platform,
            product_title,
            product_collage_category,
            product_tags,
            product_display_image,
            product_main_image,
            qp_query,
            search_engine,
            time_gap,
            dt
        FROM favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
