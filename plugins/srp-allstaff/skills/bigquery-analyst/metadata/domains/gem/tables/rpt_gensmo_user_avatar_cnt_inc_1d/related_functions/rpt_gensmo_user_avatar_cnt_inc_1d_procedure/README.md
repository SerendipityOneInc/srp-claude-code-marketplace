# rpt_gensmo_user_avatar_cnt_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-11-14
**最后更新**: 2025-11-14

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
begin
    DELETE FROM favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d
    WHERE dt is not null and dt = dt_param;
    
    INSERT INTO favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d
    (
        dt,
        
        device_id,
        user_group,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        country_name,
        validated_task_cnt,
        failed_task_cnt,
        discarded_task_cnt,
        refined_task_cnt,
        selected_task_cnt,
        new_avatar_cnt,
        valid_avatar_cnt,
        invalid_avatar_cnt,
        validated_task_device_id,
        failed_task_device_id,
        discarded_task_device_id,
        refined_task_device_id,
        selected_task_device_id,
        new_avatar_device_id,
        valid_avatar_device_id,
        invalid_avatar_device_id
    )
    SELECT
        dt,
        
        device_id,
        user_group,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        country_name,
        validated_task_cnt,
        failed_task_cnt,
        discarded_task_cnt,
        refined_task_cnt,
        selected_task_cnt,
        new_avatar_cnt,
        valid_avatar_cnt,
        invalid_avatar_cnt,
        validated_task_device_id,
        failed_task_device_id,
        discarded_task_device_id,
        refined_task_device_id,
        selected_task_device_id,
        new_avatar_device_id,
        valid_avatar_device_id,
        invalid_avatar_device_id
    FROM favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d_function(dt_param) ;

END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
