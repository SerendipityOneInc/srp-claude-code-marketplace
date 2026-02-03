# rpt_gensmo_ab_feed_metric_byuser_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-04
**最后更新**: 2025-09-04

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
    DELETE FROM `favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d`
    WHERE dt IS NOT NULL AND dt = dt_param;

    INSERT INTO `favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d`(
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        refer,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        user_feed_stay_interval,
        user_feed_true_view,
        user_content_consumption,
        user_ctr
    )
    SELECT
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        refer,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        user_feed_stay_interval,
        user_feed_true_view,
        user_content_consumption,
        user_ctr
    FROM `favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d_function`(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
