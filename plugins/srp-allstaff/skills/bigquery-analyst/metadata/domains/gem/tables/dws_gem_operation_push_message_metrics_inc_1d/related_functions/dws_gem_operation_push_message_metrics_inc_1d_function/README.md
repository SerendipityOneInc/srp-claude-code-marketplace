# dws_gem_operation_push_message_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_push_message_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

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
WITH push_events AS (
    SELECT
      completed_at AS completed_at_ts,
      name AS push_name,
      json_value(JSON_EXTRACT_array(include_aliases,'$.external_id')[OFFSET(0)]) AS user_id_str,
      successful  AS sent,
      converted AS click,
      CAST(JSON_EXTRACT_SCALAR(platform_delivery_stats, '$.android.successful') AS INT64) AS android_successful,
      CAST(JSON_EXTRACT_SCALAR(platform_delivery_stats, '$.ios.successful') AS INT64) AS ios_successful,
    FROM favie_dw.dim_gem_onesignal_push_status_view
    WHERE DATE(completed_at) = dt_param
  ),
  push_detail AS (
    SELECT
      DATE(completed_at_ts) AS dt,
      user_id_str AS user_id,
      push_name,
      sent,
      click,
      -- 根据 platform_delivery_stats 判断平台
      CASE
        WHEN android_successful > 0 THEN 'Android'
        WHEN ios_successful > 0 THEN 'iOS'
        ELSE 'Other'
      END AS platform,
    FROM push_events
  ),

 user_details AS (
  SELECT
    t1.dt,
    t1.user_id,
    t1.push_name,
    t1.platform,
    -- 新老用户判断
    CASE
      WHEN DATE(t2.created_at) = t1.dt THEN 'New User'
      ELSE 'Old User'
    END AS user_type,
    SUM(t1.sent) AS sent_count,
    SUM(t1.click) AS click_count
  FROM push_detail AS t1
  LEFT JOIN `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d` AS t2
    ON CAST(t1.user_id AS STRING) = CAST(t2.user_id AS STRING)
  GROUP BY
    t1.dt,
    t1.user_id,
    t1.push_name,
    t1.platform,
    user_type
)
  SELECT
    dt,
    user_id,
    push_name,
    platform,
    user_type,
    sent_count,
    click_count
  FROM user_details
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
