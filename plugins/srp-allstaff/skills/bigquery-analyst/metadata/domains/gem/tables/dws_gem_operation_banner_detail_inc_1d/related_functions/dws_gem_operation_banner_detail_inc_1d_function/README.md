# dws_gem_operation_banner_detail_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_banner_detail_inc_1d_function`
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
      e.event_item.item_name AS item_name,
      e.event_item.item_type AS item_type,
      e.ap_name,
      e.event_method,
      e.device_id,
      e.event_action_type,
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d` e
    WHERE e.dt = dt_param
      AND e.ap_name = 'ap_hashtag_banner_list_item'
      AND e.event_method IN ('click', 'true_view_trigger')
  ),

  labeled AS (
    SELECT
      dt,
      item_name,
      item_type,
      ap_name,
      event_method,
      device_id,
      event_action_type,
    FROM base
  ),

  -- ② 用户特征
  user_feature AS (
    SELECT
      dt,
      device_id,
      appsflyer_id,
      is_internal_user,
      user_type,
      user_tenure_type,
      last_day_feature.login_type AS login_type,
      last_day_feature.platform AS platform,
      last_day_feature.app_version AS app_version
    FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
    WHERE dt = dt_param
  ),

  -- ③ appsflyer 优先级规则
  install_with_rn AS (
    SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY appsflyer_id
        ORDER BY
          CASE WHEN source = 'ON_LINE' THEN 1
               WHEN source = 'OFF_LINE' THEN 2
               ELSE 3 END,
          CASE WHEN media_source NOT IN ('organic', 'None') THEN 1
               WHEN media_source = 'organic' THEN 2
               ELSE 3 END
      ) AS rn
    FROM `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_inc_1d_view`
  ),

  install AS (
    SELECT
      appsflyer_id,
      media_source AS user_media_source
    FROM install_with_rn
    WHERE rn = 1
  ),

  -- ④ 结合用户特征 & 媒体来源
  joined AS (
    SELECT
      l.*,
      uf.appsflyer_id,
      uf.is_internal_user,
      uf.user_type,
      uf.user_tenure_type,
      uf.login_type,
      uf.platform,
      uf.app_version,
      ins.user_media_source
    FROM labeled l
    LEFT JOIN user_feature uf
      ON l.device_id = uf.device_id AND l.dt = uf.dt
    LEFT JOIN install ins
      ON uf.appsflyer_id = ins.appsflyer_id
  )

  -- ⑤ 最终统计
  SELECT
    dt,
    item_name,
    user_media_source,
    is_internal_user,
    user_type,
    user_tenure_type,
    login_type,
    platform,
    app_version,

    COUNTIF(event_method = 'true_view_trigger' AND item_type='hashtag') AS banner_view_pv,
    COUNT(DISTINCT IF(event_method = 'true_view_trigger' AND item_type='hashtag', device_id, NULL)) AS banner_view_uv,

    COUNTIF(event_method = 'click' AND event_action_type = 'enter_hashtag_detail' AND item_type='hashtag') AS banner_click_pv,
    COUNT(DISTINCT IF(event_method = 'click' AND event_action_type = 'enter_hashtag_detail' AND item_type='hashtag', device_id, NULL)) AS banner_click_uv
  FROM joined
  GROUP BY 
    dt, 
    item_name, 
    user_media_source,
    is_internal_user,
    user_type,
    user_tenure_type,
    login_type,
    platform,
    app_version
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
