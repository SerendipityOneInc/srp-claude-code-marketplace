# dwd_favie_decofy_ab_active_users_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_ab_active_users_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-06
**最后更新**: 2025-09-06

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
    DECLARE current_dt DATE;
    SET current_dt = dt_param;
    WHILE n_day >= 1 DO
        -- 删除目标日期的现有数据
        DELETE FROM `favie_dw.dwd_favie_decofy_ab_active_users_inc_1d`
        WHERE dt = current_dt;

        -- 插入新数据
        INSERT INTO `favie_dw.dwd_favie_decofy_ab_active_users_inc_1d`
        (
            dt,
            user_id,
            ab_project,
            ab_router,
            ab_unique_id,
            ab_start_date,
            enter_ab_date
        )
        SELECT 
            dt,
            user_id,
            ab_project,
            ab_router,
            ab_unique_id,
            ab_start_date,
            enter_ab_date
        FROM `favie_dw.dwd_favie_decofy_ab_active_users_inc_1d_function`(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
