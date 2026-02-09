# favie_product_detail_bigtable_external_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.favie_product_detail_bigtable_external_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-01-02
**最后更新**: 2025-01-02

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| selected_columns | StandardSqlDataType(type_kind=<StandardSqlTypeNames.ARRAY: 'ARRAY'>, ...) | None |
| where_condition | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |
| limit_count | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
--   select selected_columns;
  FOR column_name IN (SELECT * FROM UNNEST(selected_columns)) DO
    select column_name;
  END FOR;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
