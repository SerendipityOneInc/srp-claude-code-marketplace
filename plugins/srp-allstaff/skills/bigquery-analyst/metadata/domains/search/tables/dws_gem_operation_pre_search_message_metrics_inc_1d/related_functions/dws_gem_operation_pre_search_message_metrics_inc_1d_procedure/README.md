# dws_gem_operation_pre_search_message_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-09-29
**最后更新**: 2025-09-29

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

- `srpdev-7b1d3.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d_function` (dws_gem_operation_pre_search_message_metrics_inc_1d_function)
- `srpdev-7b1d3.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d` (dws_gem_operation_pre_search_message_metrics_inc_1d)

---

## 💻 函数定义

```sql
BEGIN
  -- 1. 先删除当天的数据，确保幂等性
  DELETE FROM `srpdev-7b1d3.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d`
  WHERE dt = dt_param;

  -- 2. 插入最新数据
  INSERT INTO `srpdev-7b1d3.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d` (
    dt,
    user_id,
    device_id,
    event_item_item_type,
    event_item_item_name,
    count_pre_search,
    user_group,
    country_name,
    platform,
    app_version,
    user_login_type,
    user_tenure_type
  )
  SELECT
    dt,
    user_id,
    device_id,
    event_item_item_type,
    event_item_item_name,
    count_pre_search,
    user_group,
    country_name,
    platform,
    app_version,
    user_login_type,
    user_tenure_type
  FROM `srpdev-7b1d3.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d_function`(dt_param);
END
```

---

**文档生成**: 2026-01-30 13:42:27
**扫描工具**: scan_functions.py
