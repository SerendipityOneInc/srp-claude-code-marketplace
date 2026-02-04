# rpt_images_quality_pixel_distribution_full_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_distribution_full_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-16
**最后更新**: 2025-12-16

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
  DELETE FROM `favie_rpt.rpt_images_quality_pixel_distribution_full_1d`
  WHERE dt = dt_param;

  -- 插入数据
  INSERT INTO `favie_rpt.rpt_images_quality_pixel_distribution_full_1d` (
    product_f_creates_at,
    site,
    total_sku_cnt,
    total_spu_cnt,
    tiny_image_sku_cnt,
    small_image_sku_cnt,
    medium_image_sku_cnt,
    large_image_sku_cnt,
    size_2k_image_sku_cnt,
    size_4k_image_sku_cnt,
    size_8k_image_sku_cnt,
    tiny_main_image_sku_cnt,
    small_main_image_sku_cnt,
    medium_main_image_sku_cnt,
    large_main_image_sku_cnt,
    size_2k_main_image_sku_cnt,
    size_4k_main_image_sku_cnt,
    size_8k_main_image_sku_cnt,
    tiny_image_spu_cnt,
    small_image_spu_cnt,
    medium_image_spu_cnt,
    large_image_spu_cnt,
    size_2k_image_spu_cnt,
    size_4k_image_spu_cnt,
    size_8k_image_spu_cnt,
    tiny_main_image_spu_cnt,
    small_main_image_spu_cnt,
    medium_main_image_spu_cnt,
    large_main_image_spu_cnt,
    size_2k_main_image_spu_cnt,
    size_4k_main_image_spu_cnt,
    size_8k_main_image_spu_cnt,
    dt
  )
  SELECT
    product_f_creates_at,
    site,
    total_sku_cnt,
    total_spu_cnt,
    tiny_image_sku_cnt,
    small_image_sku_cnt,
    medium_image_sku_cnt,
    large_image_sku_cnt,
    size_2k_image_sku_cnt,
    size_4k_image_sku_cnt,
    size_8k_image_sku_cnt,
    tiny_main_image_sku_cnt,
    small_main_image_sku_cnt,
    medium_main_image_sku_cnt,
    large_main_image_sku_cnt,
    size_2k_main_image_sku_cnt,
    size_4k_main_image_sku_cnt,
    size_8k_main_image_sku_cnt,
    tiny_image_spu_cnt,
    small_image_spu_cnt,
    medium_image_spu_cnt,
    large_image_spu_cnt,
    size_2k_image_spu_cnt,
    size_4k_image_spu_cnt,
    size_8k_image_spu_cnt,
    tiny_main_image_spu_cnt,
    small_main_image_spu_cnt,
    medium_main_image_spu_cnt,
    large_main_image_spu_cnt,
    size_2k_main_image_spu_cnt,
    size_4k_main_image_spu_cnt,
    size_8k_main_image_spu_cnt,
    dt_param AS dt
  FROM `favie_rpt.rpt_images_quality_pixel_distribution_full_1d_function`(dt_param);
  call favie_dw.record_partition('favie_rpt.rpt_images_quality_pixel_distribution_full_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
