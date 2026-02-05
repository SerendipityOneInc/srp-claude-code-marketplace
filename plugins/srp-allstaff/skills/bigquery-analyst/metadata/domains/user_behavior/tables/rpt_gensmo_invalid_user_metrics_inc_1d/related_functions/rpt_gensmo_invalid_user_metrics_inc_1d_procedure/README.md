# rpt_gensmo_invalid_user_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-26
**最后更新**: 2025-09-26

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
    delete from favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d
    where dt = dt_param;
    
    INSERT INTO favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d (
      dt,
      platform,
      app_version,
      geo_country_name,
      event_name,
      event_method,
      invalid_user_cnt
    )
    SELECT
      dt,
      platform,
      app_version,
      geo_country_name,
      event_name,
      event_method,
      invalid_user_cnt
    FROM favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
