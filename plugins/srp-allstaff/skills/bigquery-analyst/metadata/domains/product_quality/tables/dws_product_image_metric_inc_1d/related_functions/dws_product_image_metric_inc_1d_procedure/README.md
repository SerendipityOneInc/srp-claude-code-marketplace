# dws_product_image_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_product_image_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-04
**最后更新**: 2026-01-04

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
  -- 删除指定日期的数据
  DELETE FROM `favie_dw.dws_product_image_metric_inc_1d`
  WHERE dt = dt_param;

  -- 插入统计结果
  INSERT INTO `favie_dw.dws_product_image_metric_inc_1d` (
    dt,
    site,
    site_tier,
    site_type,
    site_rank,
    site_categories,
    site_parser_type,
    site_country_region,
    image_category,
    image_size_type,
    total_sku_cnt,
    total_spu_cnt,
    image_sku_cnt,
    image_spu_cnt
  )
  SELECT
    dt,
    site,
    site_tier,
    site_type,
    site_rank,
    site_categories,
    site_parser_type,
    site_country_region,
    image_category,
    image_size_type,
    sku_uniq_cnt,
    spu_uniq_cnt,
    image_sku_cnt,
    image_spu_cnt
  FROM favie_dw.dws_product_image_metric_inc_1d_function(dt_param);
  CALL favie_dw.record_partition('favie_dw.dws_product_image_metric_inc_1d', dt_param, "");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
