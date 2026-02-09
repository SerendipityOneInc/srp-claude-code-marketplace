# dws_gem_operation_banner_detail_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_banner_detail_inc_1d_procedure`
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
    -- 1) 先删掉前一天的数据
    DELETE FROM favie_dw.dws_gem_operation_banner_detail_inc_1d
    WHERE dt = dt_param;

    -- 2) 插入最新数据
    INSERT INTO favie_dw.dws_gem_operation_banner_detail_inc_1d
    (
      dt,
      item_name,
      user_media_source,
      is_internal_user,
      user_type,
      user_tenure_type,
      login_type,
      platform,
      app_version,
      banner_view_pv,
      banner_view_uv,
      banner_click_pv,
      banner_click_uv
    )
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
      banner_view_pv,
      banner_view_uv,
      banner_click_pv,
      banner_click_uv
    FROM favie_dw.dws_gem_operation_banner_detail_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
