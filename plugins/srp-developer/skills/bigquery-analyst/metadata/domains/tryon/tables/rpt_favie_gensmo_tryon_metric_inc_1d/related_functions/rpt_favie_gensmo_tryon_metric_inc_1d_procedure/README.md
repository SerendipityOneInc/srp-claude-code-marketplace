# rpt_favie_gensmo_tryon_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-15
**最后更新**: 2025-10-15

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
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        tryon_trigger_cnt,
        tryon_trigger_user_cnt,
        tryon_request_cnt,
        tryon_request_user_cnt,
        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_user_cnt,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_user_cnt,
        tryon_complete_user_cnt,
        tryon_load_succeed_task_cnt,
        tryon_load_succeed_user_cnt,
        tryon_load_fail_task_cnt,
        tryon_load_fail_user_cnt,
        tryon_view_detail_task_cnt,
        tryon_view_detail_user_cnt
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        tryon_trigger_cnt,
        tryon_trigger_user_cnt,
        tryon_request_cnt,
        tryon_request_user_cnt,
        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_user_cnt,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_user_cnt,
        tryon_complete_user_cnt,
        tryon_load_succeed_task_cnt,
        tryon_load_succeed_user_cnt,
        tryon_load_fail_task_cnt,
        tryon_load_fail_user_cnt,
        tryon_view_detail_task_cnt,
        tryon_view_detail_user_cnt
    FROM favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
