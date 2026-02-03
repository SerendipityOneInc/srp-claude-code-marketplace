# dwd_favie_gensmo_membership_earn_point_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-28
**最后更新**: 2025-12-28

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
    -- 删除指定日期的旧数据
    DELETE FROM `favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d`
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO `favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d` (
        dt,
        user_id,
        device_id,
        earn_id,
        earn_type,
        earn_point_type,
        earn_points,
        earn_time
    )
    SELECT 
        dt,
        user_id,
        device_id,
        earn_id,
        earn_type,
        earn_point_type,
        earn_points,
        earn_time
    FROM `favie_dw.dwd_favie_gensmo_membership_earn_point_full_1d_function`(dt_param);

    -- 如有需要可登记分区
    call favie_dw.record_partition('favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d', dt_param, "");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
