# rpt_favie_product_review_metric_full_1w_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_full_1w_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-19
**最后更新**: 2026-01-19

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
  declare weekly_end DATE DEFAULT date_add(dt_param, INTERVAL 6 DAY);
  DELETE FROM `favie_rpt.rpt_favie_product_review_metric_full_1w`
  WHERE dt = weekly_end;

  -- 插入数据
  INSERT INTO `favie_rpt.rpt_favie_product_review_metric_full_1w` (
    site,
    total_review_num,
    weekly_new_review_num,
    weekly_update_review_num,
    total_spu_num_with_review,
    spu_num_with_review_count_ge_10,
    dt
  )
  SELECT
    site,
    total_review_num,
    weekly_new_review_num,
    weekly_update_review_num,
    total_spu_num_with_review,
    spu_num_with_review_count_ge_10,
    dt
  FROM `favie_rpt.rpt_favie_product_review_metric_full_1w_function`(weekly_end);
  call favie_dw.record_partition('favie_rpt.rpt_favie_product_review_metric_full_1w', weekly_end,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
