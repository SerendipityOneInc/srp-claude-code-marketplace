# rpt_favie_gensmo_product_with_dau_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-15
**最后更新**: 2025-07-15

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
    DELETE FROM favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入目标日期数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        product_external_jump_click_cnt,
        product_external_jump_click_user_cnt,
        product_detail_pv_cnt,
        product_detail_user_cnt
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
        product_external_jump_click_cnt,
        product_external_jump_click_user_cnt,
        product_detail_pv_cnt,
        product_detail_user_cnt
    FROM favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d_function(
        dt_param
    );                    
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
