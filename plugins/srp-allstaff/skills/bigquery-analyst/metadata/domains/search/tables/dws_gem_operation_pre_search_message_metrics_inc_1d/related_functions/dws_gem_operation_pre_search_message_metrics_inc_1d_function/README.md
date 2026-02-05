# dws_gem_operation_pre_search_message_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d_function`
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
WITH src AS (
    SELECT
      dt,
      user_id,
      device_id,
      event_item.item_type AS item_type,
      event_item.item_name AS item_name
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
    WHERE
      dt = dt_param
      AND event_name = 'select_item'
      AND refer = 'search_boot'
      AND event_method = 'click'
      AND event_action_Type = 'collage_gen'
  ),

  -- 2. 聚合时包含 item_type
  agg AS (
    SELECT
      dt,
      ANY_VALUE(user_id) AS user_id,
      device_id,
      item_type,
      item_name,
      COUNT(1) AS count_pre_search
    FROM src
    GROUP BY dt, device_id, item_type, item_name
  )

  -- 3. 最终结果
  SELECT
    a.dt,
    a.user_id,
    a.device_id,
    a.item_type AS event_item_item_type,
    a.item_name AS event_item_item_name,
    a.count_pre_search,
    ug.user_group,
    ug.country_name,
    ug.platform,
    ug.app_version,
    ug.user_login_type,
    ug.user_tenure_type
  FROM agg a
  LEFT JOIN (select * from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)) ug
    ON a.device_id = ug.device_id
    AND ug.dt = dt_param
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
