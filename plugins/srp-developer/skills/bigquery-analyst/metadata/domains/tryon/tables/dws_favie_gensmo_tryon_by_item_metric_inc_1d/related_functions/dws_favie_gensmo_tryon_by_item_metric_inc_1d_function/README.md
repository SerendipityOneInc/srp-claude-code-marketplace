# dws_favie_gensmo_tryon_by_item_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-11-08
**最后更新**: 2025-11-08

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
WITH user_info_with_group AS (
    SELECT 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
    FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)
  )

  SELECT
    dt_param AS dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    device_id,
    'body' AS task_model,
    'try_on' AS task_type,
    0 AS tryon_server_complete_item_cnt,
    0 AS tryon_server_complete_user_cnt,
    0 AS tryon_complete_item_cnt,
    0 AS tryon_complete_user_cnt,
    0 AS tryon_save_item_cnt,
    0 AS tryon_save_user_cnt,
    0 AS tryon_like_item_cnt,
    0 AS tryon_like_user_cnt,
    0 AS tryon_post_item_cnt,
    0 AS tryon_post_user_cnt
  FROM user_info_with_group
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
