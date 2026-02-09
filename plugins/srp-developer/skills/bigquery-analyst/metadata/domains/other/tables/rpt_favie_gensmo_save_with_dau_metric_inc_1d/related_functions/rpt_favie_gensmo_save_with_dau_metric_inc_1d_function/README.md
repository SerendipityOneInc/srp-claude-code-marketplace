# rpt_favie_gensmo_save_with_dau_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_save_with_dau_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-06-25
**最后更新**: 2025-06-25

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
WITH user_dau AS (
    SELECT 
      dt,
      country_name,
      platform,
      app_version,
      user_login_type,
      user_tenure_type,
      user_group,
      active_user_d1_cnt
    FROM srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d
    WHERE dt = dt_param
  ),

  metric_with_uv AS (
    SELECT 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,

      -- total metrics
      SUM(total_save_click_cnt) AS total_save_click_cnt,
      COUNT(DISTINCT total_save_click_device_id) AS total_save_click_user_cnt,

      -- feed detail
      COUNT(DISTINCT feed_detail_device_id) AS feed_detail_user_cnt,
      SUM(feed_detail_save_click_cnt) AS feed_detail_save_click_cnt,
      COUNT(DISTINCT feed_detail_save_click_device_id) AS feed_detail_save_click_user_cnt,
      SUM(feed_item_similar_save_click_cnt) AS feed_item_similar_save_click_cnt,
      COUNT(DISTINCT feed_item_similar_save_click_device_id) AS feed_item_similar_save_click_user_cnt,
      SUM(feed_item_tryon_save_click_cnt) AS feed_item_tryon_save_click_cnt,
      COUNT(DISTINCT feed_item_tryon_save_click_device_id) AS feed_item_tryon_save_click_user_cnt,
      SUM(feed_item_general_save_click_cnt) AS feed_item_general_save_click_cnt,
      COUNT(DISTINCT feed_item_general_save_click_device_id) AS feed_item_general_save_click_user_cnt,
      SUM(feed_item_product_save_click_cnt) AS feed_item_product_save_click_cnt,
      COUNT(DISTINCT feed_item_product_save_click_device_id) AS feed_item_product_save_click_user_cnt,
      SUM(feed_item_styling_save_click_cnt) AS feed_item_styling_save_click_cnt,
      COUNT(DISTINCT feed_item_styling_save_click_device_id) AS feed_item_styling_save_click_user_cnt,

      -- try on gen
      COUNT(DISTINCT tryon_gen_device_id) AS tryon_gen_user_cnt,
      SUM(tryon_gen_save_click_cnt) AS tryon_gen_save_click_cnt,
      COUNT(DISTINCT tryon_gen_save_click_device_id) AS tryon_gen_save_click_user_cnt,

      -- product detail
      SUM(product_detail_save_click_cnt) AS product_detail_save_click_cnt,
      COUNT(DISTINCT product_detail_save_click_device_id) AS product_detail_save_click_user_cnt,

      -- product detail from search
      SUM(product_detail_from_search_save_click_cnt) AS product_detail_from_search_save_click_cnt,
      COUNT(DISTINCT product_detail_from_search_save_click_device_id) AS product_detail_from_search_save_click_user_cnt,

      -- full screen pic
      SUM(full_screen_pic_save_click_cnt) AS full_screen_pic_save_click_cnt,
      COUNT(DISTINCT full_screen_pic_save_click_device_id) AS full_screen_pic_save_click_user_cnt,

      -- collage gen
      COUNT(DISTINCT collage_gen_device_id) AS collage_gen_user_cnt,
      SUM(collage_gen_save_click_cnt) AS collage_gen_save_click_cnt,
      COUNT(DISTINCT collage_gen_save_click_device_id) AS collage_gen_save_click_user_cnt

    FROM favie_rpt.rpt_favie_gensmo_save_metric_inc_1d 
    WHERE dt = dt_param
    GROUP BY 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group
  ),

  metric_with_dau AS (
    SELECT 
      COALESCE(t1.dt,t2.dt) as dt,
      COALESCE(t1.platform,t2.platform) as platform,
      COALESCE(t1.app_version,t2.app_version) as app_version,
      COALESCE(t1.country_name,t2.country_name) as country_name,
      COALESCE(t1.user_login_type,t2.user_login_type) as user_login_type,
      COALESCE(t1.user_tenure_type,t2.user_tenure_type) as user_tenure_type,
      coalesce(t1.user_group,t2.user_group) as user_group,

      -- app metrics
      t2.active_user_d1_cnt,

      -- total
      t1.total_save_click_cnt,
      t1.total_save_click_user_cnt,

      -- feed detail
      t1.feed_detail_user_cnt,
      t1.feed_detail_save_click_cnt,
      t1.feed_detail_save_click_user_cnt,
      t1.feed_item_similar_save_click_cnt,
      t1.feed_item_similar_save_click_user_cnt,
      t1.feed_item_tryon_save_click_cnt,
      t1.feed_item_tryon_save_click_user_cnt,
      t1.feed_item_general_save_click_cnt,
      t1.feed_item_general_save_click_user_cnt,
      t1.feed_item_product_save_click_cnt,
      t1.feed_item_product_save_click_user_cnt,
      t1.feed_item_styling_save_click_cnt,
      t1.feed_item_styling_save_click_user_cnt,

      -- try on gen
      t1.tryon_gen_user_cnt,
      t1.tryon_gen_save_click_cnt,
      t1.tryon_gen_save_click_user_cnt,

      -- product detail
      t1.product_detail_save_click_cnt,
      t1.product_detail_save_click_user_cnt,

      -- product detail from search
      t1.product_detail_from_search_save_click_cnt,
      t1.product_detail_from_search_save_click_user_cnt,

      -- full screen pic
      t1.full_screen_pic_save_click_cnt,
      t1.full_screen_pic_save_click_user_cnt,

      -- collage gen
      t1.collage_gen_user_cnt,
      t1.collage_gen_save_click_cnt,
      t1.collage_gen_save_click_user_cnt

    FROM metric_with_uv t1
    FULL OUTER JOIN user_dau t2
      ON t1.dt = t2.dt
      AND t1.platform = t2.platform
      AND t1.app_version = t2.app_version
      AND t1.country_name = t2.country_name
      AND t1.user_login_type = t2.user_login_type
      AND t1.user_tenure_type = t2.user_tenure_type
      and t1.user_group = t2.user_group
  )

  SELECT
    dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,

    -- app metrics
    active_user_d1_cnt,

    -- total metrics
    total_save_click_cnt,
    total_save_click_user_cnt,

    -- feed detail
    feed_detail_user_cnt,
    feed_detail_save_click_cnt,
    feed_detail_save_click_user_cnt,
    feed_item_similar_save_click_cnt,
    feed_item_similar_save_click_user_cnt,
    feed_item_tryon_save_click_cnt,
    feed_item_tryon_save_click_user_cnt,
    feed_item_general_save_click_cnt,
    feed_item_general_save_click_user_cnt,
    feed_item_product_save_click_cnt,
    feed_item_product_save_click_user_cnt,
    feed_item_styling_save_click_cnt,
    feed_item_styling_save_click_user_cnt,

    -- try on gen
    tryon_gen_user_cnt,
    tryon_gen_save_click_cnt,
    tryon_gen_save_click_user_cnt,

    -- product detail
    product_detail_save_click_cnt,
    product_detail_save_click_user_cnt,

    -- product detail from search
    product_detail_from_search_save_click_cnt,
    product_detail_from_search_save_click_user_cnt,

    -- full screen pic
    full_screen_pic_save_click_cnt,
    full_screen_pic_save_click_user_cnt,

    -- collage gen
    collage_gen_user_cnt,
    collage_gen_save_click_cnt,
    collage_gen_save_click_user_cnt

  FROM metric_with_dau
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
