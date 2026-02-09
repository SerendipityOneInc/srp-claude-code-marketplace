# dwd_favie_product_review_combined_full_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d_procedure`
**类型**: PROCEDURE
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
BEGIN
    DELETE FROM `favie_dw.dwd_favie_product_review_combined_full_1d`
    WHERE dt = dt_param;

    INSERT INTO `favie_dw.dwd_favie_product_review_combined_full_1d` (
      dt,
      f_spu_id,
      combined_title_body
    )
    SELECT
      dt_param as dt,
      f_spu_id,
      combined_title_body
    FROM `favie_dw.dwd_favie_product_review_combined_full_1d_function`(dt_param);

    CALL favie_dw.record_partition('favie_dw.dwd_favie_product_review_combined_full_1d', dt_param, "");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
