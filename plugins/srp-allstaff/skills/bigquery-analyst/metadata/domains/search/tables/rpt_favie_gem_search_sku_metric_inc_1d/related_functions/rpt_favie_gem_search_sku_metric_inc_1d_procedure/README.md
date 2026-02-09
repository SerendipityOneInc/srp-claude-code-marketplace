# rpt_favie_gem_search_sku_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.rpt_favie_gem_search_sku_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-21
**最后更新**: 2025-10-21

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

  -- delete existing data
  DELETE FROM favie_dw.rpt_favie_gem_search_sku_metric_inc_1d
  WHERE dt IS NOT NULL AND dt = dt_param;

  -- insert new data
  INSERT INTO favie_dw.rpt_favie_gem_search_sku_metric_inc_1d (
    dt,
    product_site,
    product_shop_site,
    site_domain,
    site_top_domain,
    site_tier,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,
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
    site_rank
  )
  SELECT
    dt,
    product_site,
    product_shop_site,
    site_domain,
    site_top_domain,
    site_tier,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,
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
    site_rank
  FROM favie_dw.rpt_favie_gem_search_sku_metric_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
