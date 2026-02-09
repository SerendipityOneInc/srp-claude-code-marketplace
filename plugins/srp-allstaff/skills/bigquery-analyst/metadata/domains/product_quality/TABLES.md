# 产品质量 - 表清单

**业务域**: product_quality
**表数量**: 124 张
**最后更新**: 2026-01-30

---

## 📊 表分层统计

- **DIM**: 7 张表
- **DWD**: 59 张表
- **DWS**: 8 张表
- **RPT**: 27 张表
- **OTHER**: 23 张表

---

## 维度层 (DIM)

| 表名 | 说明 |
|------|------|
| `dim_favie_gensmo_feed_item_products_view` | --- |
| `dim_favie_mapping_raw_brand` | --- |
| `dim_favie_nomalization_brand` | --- |
| `dim_favie_official_brand` | --- |
| `dim_gensmo_brand_wall_view` | --- |
| `dim_genstyle_product_vibes_view` | --- |
| `dim_official_brand_view` | --- |

---

## 明细层 (DWD)

| 表名 | 说明 |
|------|------|
| `dwd_favie_gensmo_moodboard_product_inc_1d` | --- |
| `dwd_favie_product_archive_source_inc_1d` | --- |
| `dwd_favie_product_bg_remove_images_detail_full_1d` | --- |
| `dwd_favie_product_detail_archive_inc_1d` | --- |
| `dwd_favie_product_detail_failure_flat_inc_1h` | --- |
| `dwd_favie_product_detail_flat_inc_1h` | --- |
| `dwd_favie_product_detail_full_1d` | --- |
| `dwd_favie_product_detail_gen_image_inc_1d` | --- |
| `dwd_favie_product_detail_inc_1d` | --- |
| `dwd_favie_product_historical_attributes_inc_1d` | --- |
| `dwd_favie_product_images_detail_full_1d` | --- |
| `dwd_favie_product_images_list_full_1d` | --- |
| `dwd_favie_product_review_combined_full_1d` | --- |
| `dwd_favie_product_review_failure_flat_inc_1h` | --- |
| `dwd_favie_product_review_flat_inc_1h` | --- |
| `dwd_favie_product_review_full_1d` | --- |
| `dwd_favie_product_spider_status_inc_1d` | --- |
| `dwd_gem_images_ha3_sync_commands_by_product_inc_1d` | --- |
| `dwd_gem_images_ha3_sync_commands_by_products_inc_1h` | --- |
| `dwd_gem_product_base_full_1h` | --- |
| `dwd_gem_product_collage_category_full_1d_view` | --- |
| `dwd_gem_product_collage_category_inc_1d_view` | --- |
| `dwd_gem_product_detail_ha3_flag_inc_1d` | --- |
| `dwd_gem_product_detail_ha3_full` | --- |
| `dwd_gem_product_detail_ha3_full_xd` | --- |
| `dwd_gem_product_detail_ha3_full_xw` | --- |
| `dwd_gem_product_detail_ha3_full_xw_view` | --- |
| `dwd_gem_product_detail_ha3_inc_1h` | --- |
| `dwd_gem_product_display_score_full_1d_view` | --- |
| `dwd_gem_product_display_score_inc_1d_view` | --- |
| `dwd_gem_product_enhanced_category_full_1d_view` | --- |
| `dwd_gem_product_enhanced_category_inc_1d_view` | --- |
| `dwd_gem_product_enhanced_title_full_1d_view` | --- |
| `dwd_gem_product_enhanced_title_inc_1d_view` | --- |
| `dwd_gem_product_for_item_profile_inc_1d` | --- |
| `dwd_gem_product_for_structured_full_1d` | --- |
| `dwd_gem_product_ha3_index_flag_inc_1d` | --- |
| `dwd_gem_product_ha3_merge_config_inc_1d` | --- |
| `dwd_gem_product_image_index_full_xd` | --- |
| `dwd_gem_product_image_index_full_xd_view` | --- |
| `dwd_gem_product_image_index_inc_1h` | --- |
| `dwd_gem_product_image_score_full_1d_view` | --- |
| `dwd_gem_product_images_full_1d` | --- |
| `dwd_gem_product_images_inc_1d` | --- |
| `dwd_gem_product_index_merge_config_inc_1d` | --- |
| `dwd_gem_product_item_profile_full_1d_view` | --- |
| `dwd_gem_product_item_profile_inc_1d_view` | --- |
| `dwd_gem_product_structured_extraction_demographic_full_1d` | --- |
| `dwd_gem_product_structured_normalized_full_1d_view` | --- |
| `dwd_gem_product_structured_normalized_inc_1d_view` | --- |
| `dwd_gem_product_tags_inc_1d_view` | --- |
| `dwd_product_index_swift_pre_delete_result_1d` | --- |
| `dwd_product_index_swift_write_result_delete_1d` | --- |
| `dwd_product_index_swift_write_result_delete_1h` | --- |
| `dwd_product_quality_llm_comparison_result_inc_1h` | --- |
| `dwd_product_quality_llm_screenshot_extraction_result_inc_1h` | --- |
| `dwd_product_quality_result_integration_inc_1h` | --- |
| `dwd_product_quality_spider_detail_sampling_inc_1h` | --- |
| `dwd_product_quality_webpage_screenshot_inc_1h` | --- |

---

## 汇总层 (DWS)

| 表名 | 说明 |
|------|------|
| `dws_favie_gensmo_product_bysource_metric_inc_1d` | --- |
| `dws_favie_product_data_cube_inc_1d` | --- |
| `dws_favie_product_data_cube_inc_1d_view` | --- |
| `dws_favie_product_detail_sku_metric_full_1d` | --- |
| `dws_favie_product_info_full_1d` | --- |
| `dws_gem_product_tag_value_dist_inc_1d` | --- |
| `dws_product_image_metric_full_1d` | --- |
| `dws_product_image_metric_inc_1d` | --- |

---

## 报表层 (RPT)

| 表名 | 说明 |
|------|------|
| `rpt_favie_detail_quality_link_repetition_full_1d` | --- |
| `rpt_favie_gensmo_product_with_dau_metric_inc_1d` | --- |
| `rpt_favie_product_detail_dqc_metrics_site_full_1d` | --- |
| `rpt_favie_product_detail_dqc_metrics_site_inc_1h` | --- |
| `rpt_favie_product_detail_dqc_price_abnormal_inc_1h` | --- |
| `rpt_favie_product_detail_failure_base_metrics_inc_1h` | --- |
| `rpt_favie_product_detail_failure_base_metrics_inc_1h_view` | --- |
| `rpt_favie_product_detail_metric_full_1d` | --- |
| `rpt_favie_product_detail_metric_inc_1h` | --- |
| `rpt_favie_product_detail_quality_metrics_change_full_1d` | --- |
| `rpt_favie_product_detail_quality_source_update_inc_1d` | --- |
| `rpt_favie_product_quality_sku_full_1d` | --- |
| `rpt_favie_product_review_dqc_metrics_site_inc_1h` | --- |
| `rpt_favie_product_review_metric_full_1d` | --- |
| `rpt_favie_product_review_metric_full_1w` | --- |
| `rpt_favie_product_review_metric_inc_1h` | --- |
| `rpt_favie_product_sample_1d` | --- |
| `rpt_gem_product_collage_category_statistics_1d` | --- |
| `rpt_gem_product_enhanced_category_statistics_1d` | --- |
| `rpt_gem_product_enhanced_title_statistics_1d` | --- |
| `rpt_gem_product_rank_embedding_statistics_1d` | --- |
| `rpt_gem_product_structured_extraction_statistics_1d` | --- |
| `rpt_gensmo_ab_product_metrics_inc_1d_view` | --- |
| `rpt_images_quality_pixel_distribution_full_1d` | --- |
| `rpt_images_quality_pixel_distribution_full_1d_view` | --- |
| `rpt_images_quality_pixel_full_1d` | --- |
| `rpt_webpage_quality_source_update_inc_1d` | --- |

---

## 其他

| 表名 | 说明 |
|------|------|
| `favie_dw_product_spu_detail` | --- |
| `favie_media_image_bigtable_product_external` | --- |
| `favie_nonstandard_product_detail_bigtable_external` | --- |
| `favie_nonstandard_product_detail_bigtable_external_view` | --- |
| `favie_nonstandard_product_detail_full_1d` | --- |
| `favie_product_detail_analysis_bigtable_external` | --- |
| `favie_product_detail_analysis_bigtable_external_view` | --- |
| `favie_product_detail_base_bigtable_external` | --- |
| `favie_product_detail_bigtable_external` | --- |
| `favie_product_detail_bigtable_external_flat_view` | --- |
| `favie_product_detail_bigtable_external_view` | --- |
| `favie_product_detail_bigtable_product_external` | --- |
| `favie_product_detail_bigtable_product_external_view` | --- |
| `favie_product_detail_clean_brand_view` | --- |
| `favie_product_review_bigtable_external` | --- |
| `favie_product_review_bigtable_product_external` | --- |
| `favie_webpage_bigtable_product_external` | --- |
| `favie_webpage_bigtable_product_external_1` | --- |
| `product_detail_price_analysis_view` | --- |
| `tmp_dwd_gem_product_base_keys_inc_1d` | --- |
| `tmp_dwd_gem_product_base_keys_inc_1h` | --- |
| `view_dwd_gem_product_detail_ha3_full` | --- |
| `view_dwd_gem_product_images_ha3_full` | --- |

---


**生成时间**: 2026-01-30 15:33:23
**自动生成**: 本文档由脚本自动生成
