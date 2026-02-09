# dwd_favie_product_review_combined_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2026-01-07
**最后更新**: 2026-01-07

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
SELECT 
        f_spu_id,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT(title, ":", body)), '\n') AS combined_title_body
    FROM 
        srpproduct-dc37e.favie_dw.dwd_favie_product_review_full_1d
        WHERE date(dt) = dt_param
    GROUP BY 
        f_spu_id
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
