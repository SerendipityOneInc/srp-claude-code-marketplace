# dws_favie_gensmo_user_feature_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-24
**最后更新**: 2025-09-24

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    --   DECLARE n_day int64 default 2;
      DECLARE current_dt DATE;
      DECLARE start_dt DATE;
      
      -- 计算开始日期（从最早的日期开始正向处理）
      set start_dt = DATE_SUB(dt_param, INTERVAL n_day - 1 DAY);
      set current_dt = start_dt;

      WHILE current_dt <= dt_param DO
        delete from favie_dw.dws_favie_gensmo_user_feature_inc_1d
        where dt = current_dt;

        insert into favie_dw.dws_favie_gensmo_user_feature_inc_1d(
            dt,

            device_id,
            first_device_id,
            appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,

            last_day_feature,
            last_30_days_feature,
            last_access_at
        )
        select 
            dt,
            device_id,
            first_device_id,
            appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,
            last_day_feature,
            last_30_days_feature,
            last_access_at
        from favie_dw.dws_favie_gensmo_user_feature_inc_1d_function(current_dt);

        -- 正向递增日期
        SET current_dt = DATE_ADD(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
