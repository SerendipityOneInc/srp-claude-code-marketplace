# dwd_favie_gem_product_search_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_product_search_inc_1d_procedure`
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
      DELETE FROM `favie_dw.dwd_favie_gem_product_search_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dwd_favie_gem_product_search_inc_1d` (
        trace_id,
        task_id,
        raw_query,
        rewrite_queries,
        qr_query,
        qp_query,
        query_modality,
        search_engine,
        product_sku_id,
        product_site,
        product_shop_site,
        product_title,
        product_brand,
        product_price_currency,
        product_price_value,
        product_price_raw,
        product_link,
        product_image_link,
        product_rating,
        product_ratings_total,
        product_cate_tag,
        product_updates_at,
        product_creates_at,
        se_recall_timestamp,
        gem_search_timestamp,
        moodboard_id,
        moodboard_timestamp,
        query_image_url,
        query_image_description,
        query_image_height,
        query_image_width,
        query_image_tag,
        query_intention,
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
        reasoning,
        dt
      )
      SELECT
        trace_id,
        task_id,
        raw_query,
        rewrite_queries,
        qr_query,
        qp_query,
        query_modality,
        search_engine,
        product_sku_id,
        product_site,
        product_shop_site,
        product_title,
        product_brand,
        product_price_currency,
        product_price_value,
        product_price_raw,
        product_link,
        product_image_link,
        product_rating,
        product_ratings_total,
        product_cate_tag,
        product_updates_at,
        product_creates_at,
        se_recall_timestamp,
        gem_search_timestamp,
        moodboard_id,
        moodboard_timestamp,
        query_image_url,
        query_image_description,
        query_image_height,
        query_image_width,
        query_image_tag,
        query_intention,
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
        reasoning,
        dt
      FROM `favie_dw.dwd_favie_gem_product_search_inc_1d_function`(dt_param);

END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
