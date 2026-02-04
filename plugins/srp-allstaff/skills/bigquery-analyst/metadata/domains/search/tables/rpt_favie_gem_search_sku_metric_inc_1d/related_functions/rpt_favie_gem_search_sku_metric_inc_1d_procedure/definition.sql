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