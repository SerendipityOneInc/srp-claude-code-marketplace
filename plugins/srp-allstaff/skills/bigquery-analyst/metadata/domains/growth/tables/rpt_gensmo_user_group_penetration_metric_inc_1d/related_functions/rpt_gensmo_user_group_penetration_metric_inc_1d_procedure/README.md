# rpt_gensmo_user_group_penetration_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-16
**最后更新**: 2025-12-16

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
        -- 删除当前日期的数据
        DELETE FROM `favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d`
        WHERE dt = current_dt;
        
        -- 插入新数据
        INSERT INTO `favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d` 
        (
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            group_user_cnt,
            active_user_cnt
        )
        SELECT 
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            group_user_cnt,
            active_user_cnt
        FROM favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d_function(current_dt);
        call favie_dw.record_partition('favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d', current_dt,"");
        -- 日期递减
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
