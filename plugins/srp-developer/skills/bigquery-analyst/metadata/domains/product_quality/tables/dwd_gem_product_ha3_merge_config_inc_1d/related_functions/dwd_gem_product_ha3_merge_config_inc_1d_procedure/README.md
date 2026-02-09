# dwd_gem_product_ha3_merge_config_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_ha3_merge_config_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-12
**最后更新**: 2026-01-12

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| biz_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |
| product_index_config_json | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    MERGE favie_dw.dwd_gem_product_ha3_merge_config_inc_1d AS target
    USING (
        select 
            dt,
            biz_param as biz,
            merge_mode,
            model_config,
            CURRENT_TIMESTAMP() as processed_at
        from favie_dw.dwd_gem_product_ha3_merge_config_inc_1d_function(dt_param, product_index_config_json)
    ) AS source
    ON target.dt = dt_param and target.dt = source.dt AND target.biz = source.biz
    WHEN MATCHED THEN
        UPDATE SET
            merge_mode = source.merge_mode,
            model_config = source.model_config,
            updated_at = source.processed_at
    WHEN NOT MATCHED THEN
        INSERT (dt, biz, merge_mode, model_config, created_at, updated_at)
        VALUES (source.dt, source.biz, source.merge_mode, source.model_config, source.processed_at, source.processed_at);

    -- 调用另一个存储过程来注册分区，这很可能是为了元数据管理或依赖跟踪。
    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_ha3_merge_config_inc_1d', dt_param, "");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
