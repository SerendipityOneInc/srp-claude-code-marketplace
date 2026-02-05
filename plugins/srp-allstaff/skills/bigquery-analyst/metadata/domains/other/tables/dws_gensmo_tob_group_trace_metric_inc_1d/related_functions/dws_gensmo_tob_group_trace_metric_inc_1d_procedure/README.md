# dws_gensmo_tob_group_trace_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-27
**最后更新**: 2026-01-27

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
  DELETE FROM `favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d`
  WHERE dt = dt_param;

  -- 插入数据
  INSERT INTO `favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d` (
    dt,
    site,
    country,
    impid,
    exp_id,
    vibe_list,
    product_id,
    show_cnt,
    click_cnt,
    unique_click_cnt,
    unique_click_product_cnt
  )
  SELECT
    dt,
    site,
    country,
    impid,
    exp_id,
    vibe_list,
    product_id,
    show_cnt,
    click_cnt,
    unique_click_cnt,
    unique_click_product_cnt
  FROM `favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d_function`(dt_param);

  call favie_dw.record_partition('favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
