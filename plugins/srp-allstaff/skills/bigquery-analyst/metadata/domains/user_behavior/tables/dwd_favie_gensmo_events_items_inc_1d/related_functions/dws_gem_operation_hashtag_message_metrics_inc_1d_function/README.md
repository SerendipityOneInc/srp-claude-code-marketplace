# dws_gem_operation_hashtag_message_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_hashtag_message_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-11-12
**最后更新**: 2025-11-12

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read` (dws_gensmo_user_group_inc_1d_function_read)
- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d` (dwd_favie_gensmo_events_items_inc_1d)

---

## 💻 函数定义

```sql
WITH filtered AS (
    SELECT
      dt,
      user_id,
      device_id,
      event_item.item_id AS event_item_item_id
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
    WHERE
      dt = dt_param
      AND event_method = 'click'
      AND event_action_type = 'enter_hashtag_detail'
  ),
  agg AS (
    SELECT
      dt,
      user_id,
      device_id,
      event_item_item_id,
      COUNT(1) AS count_hashtag
    FROM filtered
    GROUP BY dt, user_id, device_id, event_item_item_id
  )
  SELECT
    a.dt,
    a.user_id,
    a.device_id,
    a.event_item_item_id AS event_item_item_id,
    a.count_hashtag,
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

**文档生成**: 2026-01-30 13:42:24
**扫描工具**: scan_functions.py
