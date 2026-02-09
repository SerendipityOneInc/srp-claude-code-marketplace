# dws_favie_gensmo_refer_event_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_refer_event_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-11-07
**最后更新**: 2025-11-07

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
WITH
  base_data AS (
    SELECT
      dt,
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      device_id,
      event_items,
      app_version,
      platform,
      event_uuid
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d`
    WHERE dt = dt_param
      AND refer_group = 'valid'
      AND event_version = '1.0.0'
  ),
  data_ust AS (
    SELECT
      dt,
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_item.item_type AS item_type,
      app_version,
      platform,
      event_uuid
    FROM base_data t1
    LEFT JOIN UNNEST(event_items) AS event_item
  )
  SELECT
    dt,
    refer,
    ap_name,
    event_name,
    event_method,
    event_action_type,
    item_type,
    app_version,
    platform,
    COUNT(DISTINCT event_uuid) AS event_cnt
  FROM data_ust
  GROUP BY
    dt,
    refer,
    ap_name,
    event_name,
    event_method,
    event_action_type,
    item_type,
    app_version,
    platform
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
