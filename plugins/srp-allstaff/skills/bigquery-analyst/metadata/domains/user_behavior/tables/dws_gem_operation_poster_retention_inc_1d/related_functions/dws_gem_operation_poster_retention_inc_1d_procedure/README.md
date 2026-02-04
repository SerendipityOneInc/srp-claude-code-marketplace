# dws_gem_operation_poster_retention_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_poster_retention_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-17
**最后更新**: 2025-09-17

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
BEGIN
  -- 1) 删除当天旧分区数据（目标分区是 dt = dt_param - 1）
  DELETE FROM favie_dw.dws_gem_operation_poster_retention_inc_1d
  WHERE dt = dt_param;

  -- 2) 插入当天结果（字段顺序与表结构完全一致）
  INSERT INTO favie_dw.dws_gem_operation_poster_retention_inc_1d (
    dt,
    user_media_source,
    is_internal_user,
    user_type,
    user_tenure_type,
    login_type,
    platform,
    app_version,
    active_users,
    d1_retained_users,
    d7_retained_users,
    lt7,
    active_post_users,
    passive_post_users,
    no_post_users,
    active_post_d1_retained,
    passive_post_d1_retained,
    no_post_d1_retained,
    active_post_d7_retained,
    passive_post_d7_retained,
    no_post_d7_retained,
    active_post_lt7,
    passive_post_lt7,
    no_post_lt7
  )
  SELECT
    dt,
    user_media_source,
    is_internal_user,
    user_type,
    user_tenure_type,
    login_type,
    platform,
    app_version,
    active_users,
    d1_retained_users,
    d7_retained_users,
    lt7,
    active_post_users,
    passive_post_users,
    no_post_users,
    active_post_d1_retained,
    passive_post_d1_retained,
    no_post_d1_retained,
    active_post_d7_retained,
    passive_post_d7_retained,
    no_post_d7_retained,
    active_post_lt7,
    passive_post_lt7,
    no_post_lt7
  FROM favie_dw.dws_gem_operation_poster_retention_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
