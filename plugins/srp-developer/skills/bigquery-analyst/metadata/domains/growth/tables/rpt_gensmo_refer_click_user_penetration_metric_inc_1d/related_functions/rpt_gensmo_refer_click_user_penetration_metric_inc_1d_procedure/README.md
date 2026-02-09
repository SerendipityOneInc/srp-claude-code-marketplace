# rpt_gensmo_refer_click_user_penetration_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-17
**最后更新**: 2025-12-17

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
    DECLARE i INT64 DEFAULT 0;
    DECLARE current_dt DATE;
    
    -- 循环处理n_day天的数据
    WHILE i < n_day DO
        SET current_dt = DATE_SUB(dt_param, INTERVAL i DAY);
        
        -- 删除当前日期的数据
        DELETE FROM favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d
        WHERE dt = current_dt;

        -- 插入当前日期的数据
        INSERT INTO favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d
        (
            dt,
            refer,
            ap_name,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id,
            pv_user_cnt,
            click_user_cnt
        )
        SELECT 
            dt,
            refer,
            ap_name,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id,
            pv_user_cnt,
            click_user_cnt
        FROM favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d_function(current_dt);
        
        CALL favie_dw.record_partition('favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d', current_dt, "");
        SET i = i + 1;
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
