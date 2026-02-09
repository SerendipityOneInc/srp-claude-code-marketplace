# rpt_gensmo_analysis_search_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-11
**最后更新**: 2025-07-11

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
    DELETE FROM favie_rpt.rpt_gensmo_analysis_search_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_gensmo_analysis_search_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,
        query_input_inspo,
        query_input_type,
        search_type,
        user_count,
        load_finish_count,
        agg_load_finish,
        agg_error_block,
        agg_login_block,
        first_collage_gen_position,
        second_collage_gen_position
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,
        query_input_inspo,
        query_input_type,
        search_type,
        user_count,
        load_finish_count,
        agg_load_finish,
        agg_error_block,
        agg_login_block,
        first_collage_gen_position,
        second_collage_gen_position
    FROM favie_rpt.rpt_gensmo_analysis_search_1d_function(
        dt_param
    );
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
