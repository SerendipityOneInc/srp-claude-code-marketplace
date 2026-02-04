# dws_faive_gensmo_membership_earn_points_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d_procedure`
**类型**: PROCEDURE
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
BEGIN
    -- 删除指定日期的数据
    DELETE FROM `favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d`
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO `favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d` (
        dt,

        -- user info
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        -- earn dims
        earn_type,
        earn_point_type,
        hit_limit_group,

        -- metrics
        earn_points_user_cnt,
        earn_ponits_task_cnt,
        earn_ponits_points_amt
    )
    SELECT
        dt,

        -- user info
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        -- earn dims
        earn_type,
        earn_point_type,
        hit_limit_group,

        -- metrics
        earn_points_user_cnt,
        earn_ponits_task_cnt,
        earn_ponits_points_amt
    FROM `favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d_function`(dt_param);

    -- 记录分区
    CALL favie_dw.record_partition(
      'dws_faive_gensmo_membership_earn_points_metric_inc_1d',
      dt_param,
      ''
    );
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
