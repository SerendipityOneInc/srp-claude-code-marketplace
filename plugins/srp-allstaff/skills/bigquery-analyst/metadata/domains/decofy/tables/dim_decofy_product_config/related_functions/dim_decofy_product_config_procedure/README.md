# dim_decofy_product_config_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dim_decofy_product_config_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-26
**最后更新**: 2025-09-26

---

## 📝 函数说明



---

## 📋 参数定义

无参数

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    CREATE OR REPLACE TABLE `favie_dw.dim_decofy_product_config` as
    select 
        *
    from favie_dw.dim_decofy_package_price_mapping_view;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
