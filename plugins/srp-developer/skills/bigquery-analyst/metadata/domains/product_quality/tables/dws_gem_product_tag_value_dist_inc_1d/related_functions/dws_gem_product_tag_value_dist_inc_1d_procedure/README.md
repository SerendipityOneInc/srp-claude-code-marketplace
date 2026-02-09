# dws_gem_product_tag_value_dist_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_product_tag_value_dist_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-25
**最后更新**: 2026-01-25

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
    -- 1) 先删掉当天的数据（幂等性）
    DELETE FROM favie_dw.dws_gem_product_tag_value_dist_inc_1d
    WHERE dt = dt_param;

    -- 2) 插入最新数据
    INSERT INTO favie_dw.dws_gem_product_tag_value_dist_inc_1d
    (
      dt,
      site,
      collage_category,
      tag,
      tag_value,
      sku_cnt
    )
    SELECT
      dt,
      site,
      collage_category,
      tag,
      tag_value,
      sku_cnt
    FROM favie_dw.dws_gem_product_tag_value_dist_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
