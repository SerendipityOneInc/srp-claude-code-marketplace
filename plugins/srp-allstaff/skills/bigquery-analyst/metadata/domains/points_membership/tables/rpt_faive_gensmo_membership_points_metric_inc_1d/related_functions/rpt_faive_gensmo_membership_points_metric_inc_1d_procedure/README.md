# rpt_faive_gensmo_membership_points_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-04
**最后更新**: 2026-01-04

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
    DELETE FROM `favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d`
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO `favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d` (
        dt,

        -- user info 用户相关信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,

        -- dau & login
        active_user_1d_cnt,
        login_user_1d_cnt,

        -- points 指标
        earn_points_user_cnt,
        earn_points_task_cnt,
        earn_points_points_amt,

        earn_points_not_checkin_user_cnt,
        earn_points_not_checkin_task_cnt,
        earn_points_not_checkin_points_amt,

        earn_points_transaction_user_cnt,
        earn_points_transaction_task_cnt,
        earn_points_transaction_points_amt,

        consume_points_user_cnt,
        consume_points_task_cnt,
        consume_points_points_amt,

        net_points_change,

        consume_points_ge_task_claimed_user_cnt,
        consume_points_ge_checkin_user_cnt,

        hit_limit_user_cnt,
        points_expired
    )
    SELECT
        dt,

        -- user info 用户相关信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,

        -- dau & login
        active_user_1d_cnt,
        login_user_1d_cnt,

        -- points 指标
        earn_points_user_cnt,
        earn_points_task_cnt,
        earn_points_points_amt,

        earn_points_not_checkin_user_cnt,
        earn_points_not_checkin_task_cnt,
        earn_points_not_checkin_points_amt,

        earn_points_transaction_user_cnt,
        earn_points_transaction_task_cnt,
        earn_points_transaction_points_amt,

        consume_points_user_cnt,
        consume_points_task_cnt,
        consume_points_points_amt,

        net_points_change,

        consume_points_ge_task_claimed_user_cnt,
        consume_points_ge_checkin_user_cnt,

        hit_limit_user_cnt,
        points_expired
    FROM `favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d_function`(dt_param);

    call favie_dw.record_partition('rpt_faive_gensmo_membership_points_metric_inc_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
