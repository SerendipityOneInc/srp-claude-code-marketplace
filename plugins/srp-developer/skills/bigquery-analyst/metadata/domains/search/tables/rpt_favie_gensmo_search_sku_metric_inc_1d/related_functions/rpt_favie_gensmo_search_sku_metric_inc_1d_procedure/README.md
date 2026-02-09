# rpt_favie_gensmo_search_sku_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_search_sku_metric_inc_1d_procedure`
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
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN

  DECLARE current_dt DATE;
  DECLARE dt_param_3  DATE;
  DECLARE dt_param_7  DATE;
  DECLARE dt_param_28 DATE;
  SET current_dt = dt_param;

  while n_day>=1 do
    -- declare
    SET dt_param_3 = DATE_SUB(current_dt, INTERVAL 3 DAY);
    SET dt_param_7 = DATE_SUB(current_dt, INTERVAL 7 DAY);
    SET dt_param_28 = DATE_SUB(current_dt, INTERVAL 28 DAY);

    -- delete existing data
    DELETE FROM favie_dw.rpt_favie_gensmo_search_sku_metric_inc_1d
    WHERE dt IS NOT NULL AND dt = current_dt;

    -- insert new data
    INSERT INTO favie_dw.rpt_favie_gensmo_search_sku_metric_inc_1d (
      dt,
      product_site,
      product_shop_site,
      gem_sku_raw_query_uniq_cnt,
      gem_sku_qp_query_uniq_cnt,
      gem_moodboard_sku_cnt,
      gem_moodboard_sku_uniq_cnt,
      gem_moodboard_1d_update_sku_cnt,
      gem_moodboard_1d_update_sku_uniq_cnt,
      gem_moodboard_7d_update_sku_cnt,
      gem_moodboard_7d_update_sku_uniq_cnt,
      gem_moodboard_28d_update_sku_cnt,
      gem_moodboard_28d_update_sku_uniq_cnt,
      gem_moodboard_p5_sku_seconds_amt,
      gem_moodboard_p25_sku_seconds_amt,
      gem_moodboard_p50_sku_seconds_amt,
      gem_moodboard_p75_sku_seconds_amt,
      gem_moodboard_p95_sku_seconds_amt,
      inc_sku_uniq_cnt,
      update_sku_uniq_cnt,
      d7_update_and_inc_sku_uniq_cnt,
      d28_update_and_inc_sku_uniq_cnt,
      sku_uniq_cnt,
      d7_inc_sku_uniq_cnt,
      d28_inc_sku_uniq_cnt,
      gem_moodboard_3d_update_sku_cnt,
      gem_moodboard_3d_update_sku_uniq_cnt,
      d3_update_and_inc_sku_uniq_cnt,
      d3_inc_sku_uniq_cnt
    )
    SELECT
      dt,
      product_site,
      product_shop_site,
      gem_sku_raw_query_uniq_cnt,
      gem_sku_qp_query_uniq_cnt,
      gem_moodboard_sku_cnt,
      gem_moodboard_sku_uniq_cnt,
      gem_moodboard_1d_update_sku_cnt,
      gem_moodboard_1d_update_sku_uniq_cnt,
      gem_moodboard_7d_update_sku_cnt,
      gem_moodboard_7d_update_sku_uniq_cnt,
      gem_moodboard_28d_update_sku_cnt,
      gem_moodboard_28d_update_sku_uniq_cnt,
      gem_moodboard_p5_sku_seconds_amt,
      gem_moodboard_p25_sku_seconds_amt,
      gem_moodboard_p50_sku_seconds_amt,
      gem_moodboard_p75_sku_seconds_amt,
      gem_moodboard_p95_sku_seconds_amt,
      inc_sku_uniq_cnt,
      update_sku_uniq_cnt,
      d7_update_and_inc_sku_uniq_cnt,
      d28_update_and_inc_sku_uniq_cnt,
      sku_uniq_cnt,
      d7_inc_sku_uniq_cnt,
      d28_inc_sku_uniq_cnt,
      gem_moodboard_3d_update_sku_cnt,
      gem_moodboard_3d_update_sku_uniq_cnt,
      d3_update_and_inc_sku_uniq_cnt,
      d3_inc_sku_uniq_cnt
    FROM favie_dw.rpt_favie_gensmo_search_sku_metric_inc_1d_function(current_dt,dt_param_3,dt_param_7,dt_param_28);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
