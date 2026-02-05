# rpt_decofy_user_ltn_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_user_ltn_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-28
**最后更新**: 2025-10-28

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
begin
    declare dt_param_n date default date_sub(dt_param, interval n-1 day);

    DELETE FROM `favie_rpt.rpt_decofy_user_ltn_metrics_inc_1d`
    WHERE dt is not null and dt = dt_param_n;
  
    INSERT INTO `favie_rpt.rpt_decofy_user_ltn_metrics_inc_1d`(
        dt,
        user_tenure_type,
        user_login_type,
        membership_tenure_type,
        membership_pay_status,
        country_name,
        platform,
        app_version,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        lifetime_days,
        active_days_cnt,
        active_user_cnt
    )
    select 
        dt,
        user_tenure_type,
        user_login_type,
        membership_tenure_type,
        membership_pay_status,
        country_name,
        platform,
        app_version,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        lifetime_days,
        active_days_cnt,
        active_user_cnt
    from favie_rpt.rpt_decofy_user_ltn_metrics_inc_1d_function(dt_param,n);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
