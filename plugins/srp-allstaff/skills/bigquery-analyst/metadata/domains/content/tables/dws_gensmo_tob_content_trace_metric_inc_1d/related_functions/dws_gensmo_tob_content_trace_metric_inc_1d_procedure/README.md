# dws_gensmo_tob_content_trace_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-23
**最后更新**: 2025-12-23

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
  DELETE FROM `favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d`
  WHERE dt = dt_param;

  -- 插入数据
  INSERT INTO `favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d` (
    dt,
    site,
    country,
    vibe_id,
    product_id,
    vibe_image_url,
    try_on_image_url,
    product_url,
    product_image_url,
    show_cnt,
    click_cnt
  )
  SELECT
    dt,
    site,
    country,
    vibe_id,
    product_id,
    vibe_image_url,
    try_on_image_url,
    product_url,
    product_image_url,
    show_cnt,
    click_cnt
  FROM `favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d_function`(dt_param);

  call favie_dw.record_partition('favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
