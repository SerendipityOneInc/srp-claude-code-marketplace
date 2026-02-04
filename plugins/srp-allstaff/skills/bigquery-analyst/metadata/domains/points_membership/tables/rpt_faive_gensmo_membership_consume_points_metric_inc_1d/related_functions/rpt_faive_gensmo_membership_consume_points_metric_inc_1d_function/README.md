# rpt_faive_gensmo_membership_consume_points_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_consume_points_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-31
**最后更新**: 2025-12-31

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
with metric_with_uv as (
    select
      dt,

      --user info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,

      --consume dims
      consume_type,

      --metrics
      sum(consume_points_user_cnt) as consume_points_user_cnt,
      sum(consume_ponits_task_cnt) as consume_ponits_task_cnt,
      sum(consume_ponits_points_amt) as consume_ponits_points_amt
    from favie_dw.dws_faive_gensmo_membership_consume_points_metric_inc_1d
    where dt is not null and dt = dt_param
    group by
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      consume_type
  )

  select
    dt,

    --user info
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,

    --consume dims
    consume_type,

    --metrics
    consume_points_user_cnt,
    consume_ponits_task_cnt,
    consume_ponits_points_amt
  from metric_with_uv
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
