# dws_gem_operation_feed_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_feed_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-11-12
**最后更新**: 2025-11-12

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
WITH base AS (
    SELECT
      e.dt,
      e.event_item.item_id AS collage_id,
      e.event_item.item_type  AS item_type,
      f.category AS collage_type,
      f.collage_title,
      f.collage_description,
      f.image_url,
      f.is_feed,
      f.production_type AS production_type,
      e.geo_country_name AS country_name,
      e.refer,
      f.created_user_id AS created_user_id,
      e.user_id,         -- ✅ 新增 user_id
      a.user_name,       -- ✅ 新增 user_name
      a.user_email,      -- ✅ 新增 user_email
      e.event_method,
      e.event_action_type,
      e.device_id,
      e.ap_name,
      u.user_tenure_type,
      f.saved_count,
      f.liked_count,
      f.shared_count,
      f.remix,
      u.last_day_feature.app_version,
      u.last_day_feature.platform,
      u.last_day_feature.login_type
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d` e
    LEFT JOIN `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` u
      ON e.dt = u.dt AND e.device_id = u.device_id
    LEFT JOIN `srpproduct-dc37e.favie_dw.dwd_gem_operation_feed_full` f
      ON e.event_item.item_id = f.collage_id
    LEFT JOIN `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d` a
      ON e.user_id = a.user_id       -- ✅ 仅用 user_id 关联
    WHERE e.dt = dt_param
      AND e.event_item.item_type != 'reco'   -- ✅ 新增过滤条件
)
SELECT
    dt,
    refer,
    collage_id,
    ANY_VALUE(collage_title)        AS collage_title,
    ANY_VALUE(collage_description)  AS collage_description,
    ANY_VALUE(image_url)            AS image_url,  
    ANY_VALUE(is_feed)              AS is_feed,
    ANY_VALUE(collage_type)         AS collage_type,
    ANY_VALUE(created_user_id)      AS created_user_id,
    ANY_VALUE(user_id)              AS user_id,
    ANY_VALUE(user_name)            AS user_name,
    ANY_VALUE(user_email)           AS user_email,
    ap_name,
    production_type,
    user_tenure_type,
    country_name,
    app_version,
    platform,
    login_type,
    -- feed指标
    COUNTIF(event_method = 'true_view_trigger' AND ap_name IN ('ap_feed_list','ap_hashtag_feed_list','ap_feed_list_item' )) AS feed_view_pv,
    COUNTIF(event_method = 'click' AND event_action_type='enter_feed_detail' AND ap_name IN ('ap_feed_list','ap_hashtag_feed_list','ap_feed_list_item','ap_hashtag_feed_list_item')) AS feed_click_pv,
    COUNT(DISTINCT IF(event_method = 'true_view_trigger' AND ap_name IN ('ap_feed_list','ap_hashtag_feed_list','ap_feed_list_item'), device_id, NULL)) AS feed_view_uv,
    COUNT(DISTINCT IF(event_method = 'click' AND event_action_type='enter_feed_detail' AND ap_name IN ('ap_feed_list','ap_hashtag_feed_list','ap_feed_list_item','ap_hashtag_feed_list_item'), device_id, NULL)) AS feed_click_uv,
    COUNTIF(event_action_type = 'save')                                                  AS feed_save_cnt,
    COUNTIF(event_action_type = 'like')                                                  AS feed_like_cnt,
    COUNTIF(event_action_type IN ('try_on','try_on_trigger'))                             AS feed_try_on_cnt,
    COUNTIF(event_action_type='product_external_jump')                                   AS product_external_click_cnt,
    COUNTIF(event_action_type='enter_product_detail')                                    AS product_detail_click_cnt,
    COUNTIF(event_action_type='comment_send')                                            AS feed_comment_cnt,
    MAX(saved_count)  AS feed_saved_count,
    MAX(liked_count)  AS feed_liked_count,
    MAX(shared_count) AS feed_shared_count,
    MAX(remix)        AS feed_remix
FROM base
GROUP BY
    dt, 
    collage_id, 
    country_name,
    production_type,
    user_tenure_type,
    refer,
    ap_name,
    app_version,
    platform,
    login_type
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
