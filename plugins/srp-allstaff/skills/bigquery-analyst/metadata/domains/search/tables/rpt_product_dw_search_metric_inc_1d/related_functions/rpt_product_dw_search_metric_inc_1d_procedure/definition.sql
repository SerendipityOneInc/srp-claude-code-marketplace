BEGIN
  DELETE FROM `favie_rpt.rpt_product_dw_search_metric_inc_1d`
  WHERE dt = dt_param;

  -- 插入数据
  INSERT INTO `favie_rpt.rpt_product_dw_search_metric_inc_1d` (
    product_site,
    product_shop_site,
    site_domain,
    site_top_domain,
    site_tier,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,
    valid_sku_uniq_cnt,
    valid_spu_uniq_cnt,
    d7_inc_sku_uniq_cnt,
    d7_inc_spu_uniq_cnt,
    d7_update_sku_uniq_cnt,
    d7_update_spu_uniq_cnt,
    d28_inc_sku_uniq_cnt,
    d28_inc_spu_uniq_cnt,
    d28_update_sku_uniq_cnt,
    d28_update_spu_uniq_cnt,

    gem_search_return_sku_cnt,
    gem_search_return_sku_uniq_cnt,
    gem_search_return_1d_update_sku_cnt,
    gem_search_return_1d_update_sku_uniq_cnt,
    gem_search_return_7d_update_sku_cnt,
    gem_search_return_7d_update_sku_uniq_cnt,
    gem_search_return_28d_update_sku_cnt,
    gem_search_return_28d_update_sku_uniq_cnt,

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

    gem_search_return_utilization_rate,
    d1_gem_search_return_utilization_rate,
    d7_gem_search_return_utilization_rate,
    d28_gem_search_return_utilization_rate,

    gem_moodboard_utilization_rate,
    d1_gem_moodboard_utilization_rate,
    d7_gem_moodboard_utilization_rate,
    d28_gem_moodboard_utilization_rate,
    dt
  )
  SELECT
    product_site,
    product_shop_site,
    site_domain,
    site_top_domain,
    site_tier,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,
    valid_sku_uniq_cnt,
    valid_spu_uniq_cnt,
    d7_inc_sku_uniq_cnt,
    d7_inc_spu_uniq_cnt,
    d7_update_sku_uniq_cnt,
    d7_update_spu_uniq_cnt,
    d28_inc_sku_uniq_cnt,
    d28_inc_spu_uniq_cnt,
    d28_update_sku_uniq_cnt,
    d28_update_spu_uniq_cnt,

    gem_search_return_sku_cnt,
    gem_search_return_sku_uniq_cnt,
    gem_search_return_1d_update_sku_cnt,
    gem_search_return_1d_update_sku_uniq_cnt,
    gem_search_return_7d_update_sku_cnt,
    gem_search_return_7d_update_sku_uniq_cnt,
    gem_search_return_28d_update_sku_cnt,
    gem_search_return_28d_update_sku_uniq_cnt,

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

    gem_search_return_utilization_rate,
    d1_gem_search_return_utilization_rate,
    d7_gem_search_return_utilization_rate,
    d28_gem_search_return_utilization_rate,

    gem_moodboard_utilization_rate,
    d1_gem_moodboard_utilization_rate,
    d7_gem_moodboard_utilization_rate,
    d28_gem_moodboard_utilization_rate,
    dt
  FROM `favie_rpt.rpt_product_dw_search_metric_inc_1d_function`(dt_param,date_sub(dt_param,interval 7 day),date_sub(dt_param,interval 28 day));
END