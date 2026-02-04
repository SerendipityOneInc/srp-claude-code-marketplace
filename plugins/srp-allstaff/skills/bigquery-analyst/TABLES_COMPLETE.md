# BigQuery 完整表清单

**版本**: v1.0
**生成时间**: 2026-02-04
**维护**: 数据团队 gutingyi

---

## 📊 总览

**总表数**: 611 张

**数据集**:
- `favie_dw` - 数仓层（维度层、明细层、汇总层）
- `favie_rpt` - 报表层

---

## 📋 按业务域分类

### 产品质量 (product_quality) - 113 张表

**favie_dw (75 张)**:

- `ads_favie_product_sample_daily`
- `ads_favie_webpage_sample_daily`
- `dim_favie_mapping_raw_brand`
- `dim_favie_nomalization_brand`
- `dim_favie_official_brand`
- `dim_gensmo_brand_wall_view`
- `dim_genstyle_product_vibes_view`
- `dim_moodboard_view`
- `dim_official_brand_view`
- `dim_test_moodboard_id_view`
- `dwd_favie_gem_moodboards_inc_1d_view`
- `dwd_favie_gensmo_moodboard_product_inc_1d`
- `dwd_favie_media_image_check_result_1d`
- `dwd_favie_media_image_check_result_error_data`
- `dwd_favie_media_image_flat_inc_1h`
- `dwd_favie_media_image_full_1d`
- `dwd_favie_media_image_inc_1d`
- `dwd_favie_product_archive_source_inc_1d`
- `dwd_favie_product_bg_remove_images_detail_full_1d`
- `dwd_favie_product_detail_archive_inc_1d`
- `dwd_favie_product_detail_failure_flat_inc_1h`
- `dwd_favie_product_detail_flat_inc_1h`
- `dwd_favie_product_detail_full_1d`
- `dwd_favie_product_detail_gen_image_inc_1d`
- `dwd_favie_product_detail_inc_1d`
- `dwd_favie_product_historical_attributes_inc_1d`
- `dwd_favie_product_images_detail_full_1d`
- `dwd_favie_product_images_list_full_1d`
- `dwd_favie_product_review_combined_full_1d`
- `dwd_favie_product_review_failure_flat_inc_1h`
- `dwd_favie_product_review_flat_inc_1h`
- `dwd_favie_product_review_full_1d`
- `dwd_favie_webpage_failure_flat_inc_1h`
- `dwd_favie_webpage_flat_inc_1h`
- `dwd_favie_webpage_full_1d`
- `dwd_favie_webpage_reddit_comments_flat_inc_1d`
- `dwd_favie_webpage_reddit_posts_flat_inc_1d`
- `dwd_image_index_swift_write_result_add_1d`
- `dwd_product_index_swift_pre_delete_result_1d`
- `dwd_product_index_swift_write_result_add_1d`
- `dwd_product_index_swift_write_result_add_1h`
- `dwd_product_index_swift_write_result_delete_1d`
- `dwd_product_index_swift_write_result_delete_1h`
- `dwd_product_quality_llm_comparison_result_inc_1h`
- `dwd_product_quality_llm_screenshot_extraction_result_inc_1h`
- `dwd_product_quality_main_image_metadata_inc_1h`
- `dwd_product_quality_result_integration_field_metadata_inc_1h`
- `dwd_product_quality_result_integration_inc_1h`
- `dwd_product_quality_webpage_screenshot_inc_1h`
- `dws_favie_gensmo_product_bysource_metric_inc_1d`
- `dws_favie_product_data_cube_inc_1d`
- `dws_favie_product_data_cube_inc_1d_view`
- `dws_favie_product_detail_sku_metric_full_1d`
- `dws_favie_product_info_full_1d`
- `dws_product_image_metric_full_1d`
- `dws_product_image_metric_inc_1d`
- `favie_dw_product_spu_detail`
- `favie_media_image_bigtable_product_external`
- `favie_nonstandard_product_detail_bigtable_external`
- `favie_nonstandard_product_detail_bigtable_external_view`
- `favie_nonstandard_product_detail_full_1d`
- `favie_product_detail_analysis_bigtable_external`
- `favie_product_detail_analysis_bigtable_external_view`
- `favie_product_detail_base_bigtable_external`
- `favie_product_detail_bigtable_external`
- `favie_product_detail_bigtable_external_flat_view`
- `favie_product_detail_bigtable_external_view`
- `favie_product_detail_bigtable_product_external`
- `favie_product_detail_bigtable_product_external_view`
- `favie_product_detail_clean_brand_view`
- `favie_product_review_bigtable_external`
- `favie_product_review_bigtable_product_external`
- `favie_webpage_bigtable_product_external`
- `favie_webpage_bigtable_product_external_1`
- `product_detail_price_analysis_view`

**favie_rpt (38 张)**:

- `rpt_favie_collage_count_view`
- `rpt_favie_gensmo_product_with_dau_metric_inc_1d`
- `rpt_favie_image_format_distribution_review_full_1d`
- `rpt_favie_image_pixel_distribution_review_full_1d`
- `rpt_favie_media_image_dqc_metrics_site_inc_1h`
- `rpt_favie_media_image_dqc_metrics_size_full_1d`
- `rpt_favie_media_image_dqc_metrics_size_inc_1h`
- `rpt_favie_media_image_metric_full_1d`
- `rpt_favie_media_image_size_distribution_full_1d`
- `rpt_favie_moodboard_tag_full_agg_view`
- `rpt_favie_moodboard_tag_full_view`
- `rpt_favie_product_detail_dqc_metrics_site_full_1d`
- `rpt_favie_product_detail_dqc_metrics_site_inc_1h`
- `rpt_favie_product_detail_dqc_price_abnormal_inc_1h`
- `rpt_favie_product_detail_failure_base_metrics_inc_1h`
- `rpt_favie_product_detail_failure_base_metrics_inc_1h_view`
- `rpt_favie_product_detail_metric_full_1d`
- `rpt_favie_product_detail_metric_inc_1h`
- `rpt_favie_product_detail_quality_metrics_change_full_1d`
- `rpt_favie_product_detail_quality_source_update_inc_1d`
- `rpt_favie_product_quality_sku_full_1d`
- `rpt_favie_product_review_dqc_metrics_site_inc_1h`
- `rpt_favie_product_review_metric_full_1d`
- `rpt_favie_product_review_metric_full_1w`
- `rpt_favie_product_review_metric_inc_1h`
- `rpt_favie_product_sample_1d`
- `rpt_favie_webpage_comment_metric_full_1w`
- `rpt_favie_webpage_failure_base_metrics_inc_1h`
- `rpt_favie_webpage_failure_base_metrics_inc_1h_view`
- `rpt_favie_webpage_metric_full_1d`
- `rpt_favie_webpage_metric_full_1w`
- `rpt_favie_webpage_metric_inc_1h`
- `rpt_favie_webpage_sample_1d`
- `rpt_gensmo_ab_product_metrics_inc_1d_view`
- `rpt_images_quality_pixel_distribution_full_1d`
- `rpt_images_quality_pixel_distribution_full_1d_view`
- `rpt_images_quality_pixel_full_1d`
- `rpt_webpage_quality_source_update_inc_1d`

---

### 广告营销 (advertising) - 81 张表

**favie_dw (76 张)**:

- `dim_ad_all_app_creative_full_1d`
- `dim_ad_all_app_creative_tiktok_inc_1d`
- `dim_ad_all_app_creative_tiktok_inc_1d_view`
- `dim_ad_all_source_creative_multiple_full_1d_view`
- `dim_ad_all_source_creative_unique_full_1d_view`
- `dim_ad_all_source_history_creative_tag_full_view`
- `dim_ad_all_source_kol_full_1d_view`
- `dim_ad_all_source_manual_creative_tag_202512_view`
- `dim_ad_all_source_manual_creative_tag_before_202512_view`
- `dim_ad_google_creative_multiple_full_1d_view`
- `dim_ad_google_creative_youtube_video_info_full`
- `dim_ad_google_creative_youtube_video_info_full_initial_view`
- `dim_ad_google_creative_youtube_video_info_full_view`
- `dim_ad_kol_external_post_id_google_sheet_full_1d_view`
- `dim_ad_meta_creative_multiple_full_1d_view`
- `dim_ad_meta_creative_v2_full_1d_view`
- `dim_ad_tiktok_creative_full_1d_view`
- `dim_ad_tiktok_creative_multiple_full_1d_view`
- `dim_all_app_ad_full_1d_view`
- `dim_all_app_ad_full_inc_1d_view`
- `dim_all_app_appsflyer_ad_info_mapping_full_1d`
- `dim_all_app_appsflyer_all_reachout_info_mapping_full_1d`
- `dim_favie_appsflyer_installs_view`
- `dim_favie_appsflyer_user_ad_source_full_1d`
- `dim_gem_appsflyer_ad_info_mapping_full_1d`
- `dim_gem_appsflyer_appsflyer_history_inc_1d_view`
- `dim_gem_appsflyer_history_inc_1d`
- `dim_gem_appsflyer_inc_1d_view`
- `dw_ad_all_source_creative_multiple_full_1d_view`
- `dwd_ad_tiktok_creative_full_1d_view`
- `dwd_all_app_appsflyer_webhook_including_non_ad_inc_1d_view`
- `dwd_all_app_appsflyer_webhook_only_install_1d_view`
- `dwd_all_app_appsflyer_webhook_v2_inc_1d_view`
- `dwd_all_app_total_appsflyer_webhook_inc_1d_view`
- `dwd_gem_appsflyer_installs_full_view`
- `dwd_gem_appsflyer_webhook_inc_1d_view`
- `dwd_gem_growth_ad_google_fivetran_by_ad_id_inc_1d_view`
- `dwd_gem_growth_ad_tiktok_fivetran_ad_geo_inc_1d_view`
- `dwd_gem_skan_appsflyer_webhook_inc_1d_view`
- `dwd_gem_total_appsflyer_webhook_inc_1d_view`
- `dwd_gem_total_appsflyer_webhook_including_non_ad_inc_1d_view`
- `dwd_gem_total_appsflyer_webhook_only_install_inc_1d_view`
- `dwd_gem_total_appsflyer_webhook_v2_inc_1d_view`
- `dwd_growth_ad_all_source_creative_inc_1d_view`
- `dwd_growth_ad_all_source_creative_with_supply_inc_1d_view`
- `dwd_growth_ad_all_source_creative_with_tag_inc_1d_view`
- `dwd_growth_ad_asa_fivetran_by_ad_id_inc_1d_view`
- `dwd_growth_ad_google_all_creative_fivetran_inc_1d_view`
- `dwd_growth_ad_google_creative_fivetran_inc_1d_view`
- `dwd_growth_ad_google_fivetran_by_ad_id_inc_1d_view`
- `dwd_growth_ad_google_fivetran_creative_id_inc_1d_view`
- `dwd_growth_ad_meta_all_creative_fivetran_inc_1d_view`
- `dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view`
- `dwd_growth_ad_meta_fivetran_creative_id_inc_1d_view`
- `dwd_growth_ad_meta_fivetran_tiktok_by_ad_id_inc_1d_view`
- `dwd_growth_ad_meta_image_fivetran_inc_1d_view`
- `dwd_growth_ad_meta_video_fivetran_inc_1d_view`
- `dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view`
- `dwd_growth_ad_tiktok_all_creative_fivetran_inc_1d_view`
- `dwd_growth_ad_tiktok_fivetran_ad_id_inc_1d_view`
- `dwd_growth_ad_tiktok_fivetran_campaign_geo_inc_1d_view`
- `dwd_growth_ad_tiktok_fivetran_image_inc_view`
- `dwd_growth_ad_tiktok_image_fivetran_inc_1d_view`
- `dwd_growth_ad_tiktok_image_fivetran_inc_view`
- `dwd_growth_ad_tiktok_video_fivetran_inc_1d_view`
- `dwd_growth_ad_total_by_source_inc_1d_view`
- `dws_gem_growth_ad_inc_7d_agg_view`
- `dws_gem_growth_ad_skan_and_classic_metrics_inc_1d`
- `dws_gem_growth_ads_insights_country_full_view`
- `dws_gem_growth_ads_insights_full_view`
- `dws_gem_growth_ads_insights_platform_and_device_full_view`
- `dws_gem_growth_ads_insights_region_full_view`
- `dws_gem_growth_creative_ad_skan_classic_inc_1d`
- `dws_gem_user_feature_with_ad_info_inc_1d`
- `dws_savyo_growth_ad_metrics_inc_1d`
- `tmp_dim_ad_all_source_history_creative_tag_full_view`

**favie_rpt (5 张)**:

- `rpt_all_app_growth_management_dashboard_inc_1d_view`
- `rpt_gem_growth_ad_kol_inc_1d_view`
- `rpt_gem_growth_management_dashboard_inc_1d`
- `rpt_gem_growth_management_dashboard_v2_inc_1d`
- `rpt_gem_growth_management_dashboard_v4_inc_1d`

---

### Gem产品 (gem) - 75 张表

**favie_dw (69 张)**:

- `ads_gem_image_bg_remove_statistics_1d`
- `ads_gem_image_outfit_emb_index_statistics_1d`
- `ads_gem_image_tagging_statistics_1d`
- `ads_gem_product_item_profile_statistics_1d`
- `ads_gem_product_title_seo_statistics_1d`
- `dim_gem_account_view`
- `dim_gem_bot_account_view`
- `dim_gem_comment_view`
- `dim_gem_dupe_account_view`
- `dim_gem_moodboard_view`
- `dim_gem_onesignal_push_status_view`
- `dim_gem_register_model_view`
- `dim_gem_task_response_view`
- `dim_gem_unregister_account_view`
- `dim_gem_unregister_account_view_v2`
- `dim_gem_user_ab_config_view`
- `dim_gem_user_preference_view`
- `dim_gem_user_view`
- `dwd_gem_base_user_behavior_inc_1d_view`
- `dwd_gem_images_bg_remove_result_full_1d`
- `dwd_gem_images_embedding_full_1d`
- `dwd_gem_images_embedding_result_full_1d`
- `dwd_gem_images_for_bg_remove_inc_1d`
- `dwd_gem_images_for_outfit_emb_index_full_1d`
- `dwd_gem_images_for_outfit_emb_index_inc_1d`
- `dwd_gem_images_for_relative_tag_inc_1d`
- `dwd_gem_images_for_tagging_inc_1d`
- `dwd_gem_images_index_full_1d`
- `dwd_gem_images_outfit_emb_index_result_full_1d`
- `dwd_gem_images_relative_scores_full_1d`
- `dwd_gem_images_relative_tagging_result_full_1d`
- `dwd_gem_images_tagging_result_full_1d`
- `dwd_gem_images_title_relative_scores_full_1d`
- `dwd_gem_product_base_full_1h`
- `dwd_gem_product_collage_category_full_1d_view`
- `dwd_gem_product_collage_category_inc_1d_view`
- `dwd_gem_product_display_score_full_1d_view`
- `dwd_gem_product_display_score_inc_1d_view`
- `dwd_gem_product_enhanced_category_full_1d_view`
- `dwd_gem_product_enhanced_category_inc_1d_view`
- `dwd_gem_product_enhanced_title_full_1d_view`
- `dwd_gem_product_enhanced_title_inc_1d_view`
- `dwd_gem_product_for_item_profile_inc_1d`
- `dwd_gem_product_for_structured_full_1d`
- `dwd_gem_product_image_index_full_xd`
- `dwd_gem_product_image_index_full_xd_view`
- `dwd_gem_product_image_index_inc_1h`
- `dwd_gem_product_image_score_full_1d_view`
- `dwd_gem_product_images_full_1d`
- `dwd_gem_product_images_inc_1d`
- `dwd_gem_product_index_merge_config_inc_1d`
- `dwd_gem_product_item_profile_full_1d_view`
- `dwd_gem_product_item_profile_inc_1d_view`
- `dwd_gem_product_structured_extraction_demographic_full_1d`
- `dwd_gem_product_structured_normalized_full_1d_view`
- `dwd_gem_product_structured_normalized_inc_1d_view`
- `dwd_gem_product_tags_inc_1d_view`
- `dwd_gem_user_behavior_wide_inc_1d_view`
- `dws_gem_operation_banner_detail_inc_1d`
- `dws_gem_operation_hashtag_message_metrics_inc_1d`
- `dws_gem_operation_poster_retention_inc_1d`
- `dws_gem_operation_push_message_metrics_inc_1d`
- `dws_gem_product_tag_value_dist_inc_1d`
- `dws_gem_user_last_access_full_1d`
- `tmp_dwd_gem_images_index_keys_full_1d`
- `tmp_dwd_gem_images_index_keys_inc_1d`
- `tmp_dwd_gem_images_index_keys_inc_1h`
- `tmp_dwd_gem_product_base_keys_inc_1d`
- `tmp_dwd_gem_product_base_keys_inc_1h`

**favie_rpt (6 张)**:

- `rpt_gem_product_collage_category_statistics_1d`
- `rpt_gem_product_enhanced_category_statistics_1d`
- `rpt_gem_product_enhanced_title_statistics_1d`
- `rpt_gem_product_rank_embedding_statistics_1d`
- `rpt_gem_product_structured_extraction_statistics_1d`
- `rpt_gem_user_dimension_metrics_inc_1d`

---

### Decofy (已归档) (decofy) - 66 张表

⚠️ **已归档**: 此应用已归档，相关报表基本不使用，仅在用户明确提及时查询

**favie_dw (36 张)**:

- `dim_decofy_creation_view`
- `dim_decofy_package_price_mapping`
- `dim_decofy_package_price_mapping_view`
- `dim_decofy_product_config`
- `dim_decofy_product_view`
- `dim_decofy_subscription_notification_view`
- `dim_decofy_subscriptions_view`
- `dim_decofy_user_ab_config_view`
- `dim_decofy_user_vote_metric_view`
- `dim_decofy_users_view`
- `dim_favie_decofy_user_account_changelog_1d`
- `dim_favie_decofy_user_account_scd2_1d`
- `dwd_decofy_appsflyer_webhook_inc_1d_view`
- `dwd_decofy_skan_appsflyer_webhook_inc_1d_view`
- `dwd_decofy_total_appsflyer_webhook_inc_1d_view`
- `dwd_decofy_total_appsflyer_webhook_including_non_ad_inc_1d_view`
- `dwd_decofy_total_appsflyer_webhook_only_install_inc_1d_view`
- `dwd_decofy_total_appsflyer_webhook_v2_inc_1d_view`
- `dwd_decofy_user_subscription_view`
- `dwd_favie_decofy_ab_active_users_inc_1d`
- `dwd_favie_decofy_events_inc_1d`
- `dwd_favie_decofy_subscription_notification_full_1d`
- `dwd_favie_decofy_subscription_order_full_1d`
- `dwd_favie_decofy_subscription_order_inc_1d_view`
- `dwd_favie_decofy_subscription_process_inc_1d`
- `dws_decofy_membership_full_1d`
- `dws_decofy_refer_general_metrics_inc_1d`
- `dws_decofy_refer_metrics_inc_1d`
- `dws_decofy_subscribe_pay_metric_inc_1d`
- `dws_decofy_subscribe_process_metric_inc_1d`
- `dws_decofy_subscribe_renewal_metric_inc_1d`
- `dws_decofy_subscribe_renewal_nd_metric_inc_1d`
- `dws_decofy_user_group_inc_1d`
- `dws_favie_decofy_subscription_order_with_ad_info_full_1d_view`
- `dws_favie_decofy_user_feature_inc_1d`
- `dws_favie_decofy_user_subscription_feature_full_1d`

**favie_rpt (30 张)**:

- `rpt_decofy_action_user_penetration_rate_view`
- `rpt_decofy_ad_nd_cost_metric_inc_1d`
- `rpt_decofy_create_metric_view`
- `rpt_decofy_growth_management_dashboard_v2_inc_1d`
- `rpt_decofy_growth_management_dashboard_v3_inc_1d`
- `rpt_decofy_growth_management_dashboard_v4_inc_1d`
- `rpt_decofy_onboarding_metric_view`
- `rpt_decofy_refer_click_user_penetration_rate_view`
- `rpt_decofy_refer_pv_user_penetration_rate_view`
- `rpt_decofy_subscribe_7day_moving_metric_inc_1d_view`
- `rpt_decofy_subscribe_lt_metric_view`
- `rpt_decofy_subscribe_ltv_metric_view`
- `rpt_decofy_subscribe_notification_metric_inc_1d`
- `rpt_decofy_subscribe_process_user_metric_inc_1d`
- `rpt_decofy_subscribe_renewal_30d_metric_inc_1d`
- `rpt_decofy_subscribe_renewal_ltv_metric_inc_1d`
- `rpt_decofy_subscribe_renewal_metric_inc_1d`
- `rpt_decofy_subscribe_roas_metric_view`
- `rpt_decofy_subscription_membership_metrics_inc_1d`
- `rpt_decofy_subscription_metric_view`
- `rpt_decofy_subscription_order_metrics_inc_1d`
- `rpt_decofy_subscription_renewal_conversion_rate_view`
- `rpt_decofy_subscription_revenue_view`
- `rpt_decofy_subscription_user_penetration_rate_view`
- `rpt_decofy_user_active_metrics_inc_1d`
- `rpt_decofy_user_active_metrics_inc_1w`
- `rpt_decofy_user_group_penetration_rate_view`
- `rpt_decofy_user_ltn_metrics_inc_1d`
- `rpt_decofy_user_retention_metrics_inc_1d`
- `rpt_decofy_user_retention_metrics_inc_1w`

---

### 搜索推荐 (search) - 58 张表

**favie_dw (44 张)**:

- `ads_gem_ha3_sync_statistics_1d`
- `dim_gem_ha3_exclude_site`
- `dwd_favie_gem_product_search_inc_1d`
- `dwd_favie_gem_product_search_inc_1d_view`
- `dwd_favie_gem_search_inc_1d_view`
- `dwd_favie_gem_search_query_inc_1d`
- `dwd_favie_ha3_rank_inc_1d_view`
- `dwd_favie_search_proxy_inc_1d_view`
- `dwd_gem_images_ha3_sync_commands_by_emb_inc_1d`
- `dwd_gem_images_ha3_sync_commands_by_product_inc_1d`
- `dwd_gem_images_ha3_sync_commands_by_products_inc_1h`
- `dwd_gem_images_ha3_sync_commands_full_1d`
- `dwd_gem_images_ha3_sync_commands_inc_1h`
- `dwd_gem_images_search_index_full_1d`
- `dwd_gem_product_detail_ha3_flag_inc_1d`
- `dwd_gem_product_detail_ha3_full`
- `dwd_gem_product_detail_ha3_full_xd`
- `dwd_gem_product_detail_ha3_full_xw`
- `dwd_gem_product_detail_ha3_full_xw_view`
- `dwd_gem_product_detail_ha3_inc_1h`
- `dwd_gem_product_ha3_index_flag_inc_1d`
- `dwd_gem_product_ha3_merge_config_inc_1d`
- `dwd_search_images_outfit_emb_index_full_1d`
- `dwd_search_images_outfit_emb_index_inc_1d`
- `dwd_search_product_image_bg_remove_flat_full_1d`
- `dwd_search_product_image_bg_remove_flat_inc_1d`
- `dwd_search_product_image_tagging_flat_full_1d`
- `dwd_search_product_image_tagging_flat_inc_1d`
- `dws_favie_gem_search_query_cube_inc_1d`
- `dws_favie_gem_search_query_metric_inc_1d`
- `dws_favie_gem_search_sku_cube_inc_1d`
- `dws_favie_gem_sku_search_cube_inc_1d`
- `dws_favie_gem_sku_search_cube_inc_1d_view`
- `dws_favie_gem_sku_search_cute_inc_1d_view`
- `dws_favie_gem_sku_top_search_cube_inc_1d`
- `dws_favie_gem_user_search_cube_inc_1d`
- `dws_favie_gensmo_search_by_event_metric_inc_1d`
- `dws_favie_gensmo_search_query_metric_inc_1d`
- `dws_gem_operation_pre_search_message_metrics_inc_1d`
- `rpt_favie_gem_search_sku_metric_inc_1d`
- `rpt_favie_gensmo_search_sku_metric_inc_1d`
- `rpt_product_dw_search_metric_view`
- `view_dwd_gem_product_detail_ha3_full`
- `view_dwd_gem_product_images_ha3_full`

**favie_rpt (14 张)**:

- `rpt_favie_gensmo_search_by_event_metric_inc_1d`
- `rpt_favie_gensmo_search_by_server_metric_inc_1d`
- `rpt_favie_gensmo_search_sku_metric_inc_1d_view`
- `rpt_favie_gensmo_search_with_dau_metric_inc_1d_new`
- `rpt_gem_search_item_merge_inc_1d`
- `rpt_gensmo_ab_search_metrics_inc_1d_view`
- `rpt_gensmo_ab_search_pro_metrics_inc_1d_view`
- `rpt_gensmo_analysis_search_1d`
- `rpt_gensmo_analysis_search_country_1d_view`
- `rpt_gensmo_user_search_metrics_inc_1d`
- `rpt_product_dw_search_metric_inc_1d`
- `rpt_product_dw_search_metric_inc_1d_view`
- `rpt_product_dw_search_metric_view`
- `rpt_product_dw_search_utilization_inc_1d_view`

---

### Feed流 (feed) - 53 张表

**favie_dw (38 张)**:

- `dim_dwd_gem_feed_tags_full_1d_view`
- `dim_favie_gensmo_feed_item_products_view`
- `dim_favie_gensmo_feed_item_view`
- `dim_favie_gensmo_feed_tag_multi_result_view`
- `dim_favie_gensmo_feed_tag_result_json_view`
- `dim_favie_gensmo_feed_tag_result_view`
- `dim_favie_gensmo_feed_test_multi_result`
- `dim_favie_gensmo_feed_test_only_style_result`
- `dim_favie_gensmo_feed_test_result`
- `dim_feed_collage_full_view`
- `dim_feed_tag_compare_data_view`
- `dim_feed_tag_compare_result_view`
- `dim_feed_tag_test_data`
- `dim_feed_tag_test_data_google_sheet`
- `dim_feed_tag_test_data_view`
- `dim_gem_feed_tags_full_1d_view`
- `dim_moodboard_feed_tasks_view`
- `dwd_gem_feed_moodboard_tag_full_1d_view`
- `dwd_gem_feed_moodboard_tag_inc_1hour_view`
- `dwd_gem_feed_tag_check_view`
- `dwd_gem_feed_tags_full_1d_view`
- `dwd_gem_feed_tags_full_view`
- `dwd_gem_feed_tags_interface_full_view`
- `dwd_gem_feed_tags_report_full_view`
- `dwd_gem_feed_tags_request_inc_1d`
- `dwd_gem_feed_tags_source_full_view`
- `dwd_gem_operation_feed_full`
- `dwd_gensmo_batch_feed_tag_full_1d`
- `dwd_gensmo_batch_feed_tag_inc_1d`
- `dwd_gensmo_feed_tag_full_1d`
- `dwd_gensmo_feed_tag_inc_1d`
- `dwd_gensmo_manual_feed_tag_inc_1d`
- `dwd_gensmo_realtime_feed_tag_full_1d`
- `dwd_gensmo_realtime_feed_tag_full_1d_view`
- `dwd_gensmo_realtime_feed_tag_inc_1d`
- `dws_favie_gensmo_feed_bysource_metric_inc_1d`
- `dws_gem_operation_feed_metrics_inc_1d`
- `dws_gem_operation_feed_user_metrics_inc_1d`

**favie_rpt (15 张)**:

- `faive_feed_tags_operation_metric_view`
- `rpt_faive_feed_tags_operation_metric_view`
- `rpt_faive_feed_tags_total_operation_metric_view`
- `rpt_favie_feed_operation_30d`
- `rpt_favie_feed_operation_mertic_with_tag_info_view`
- `rpt_favie_feed_user_operation_30days_inc_1d_view`
- `rpt_favie_feed_user_operation_inc_1d`
- `rpt_favie_gensmo_feed_with_dau_metric_inc_1d`
- `rpt_feed_collage_full_view`
- `rpt_gem_feed_tags_fail_metric_inc_1d_view`
- `rpt_gem_feed_tags_full_1d_view`
- `rpt_gensmo_ab_feed_metric_byuser_inc_1d`
- `rpt_gensmo_ab_feed_metric_inc_1d`
- `rpt_gensmo_feed_metrcis_rename_ap_screen_view`
- `rpt_gensmo_feed_metrics_report_view`

---

### 用户行为 (user_behavior) - 48 张表

**favie_dw (12 张)**:

- `dwd_favie_gensmo_events_ab_infos_inc_1d`
- `dwd_favie_gensmo_events_inc_1d`
- `dwd_favie_gensmo_events_items_inc_1d`
- `dwd_favie_gensmo_user_recap_inc_1d`
- `dws_favie_gensmo_refer_event_metric_inc_1d`
- `dws_favie_gensmo_user_1d7s_inc_1d`
- `dws_favie_gensmo_user_feature_30d_view`
- `dws_favie_gensmo_user_feature_inc_1d`
- `dws_favie_gensmo_user_feature_inc_1d_bak`
- `dws_favie_gensmo_user_feature_inc_1d_view`
- `dws_gensmo_refer_event_metrics_inc_1d`
- `dws_gensmo_user_avatar_duration_inc_1d`

**favie_rpt (36 张)**:

- `rpt_favie_event_operation_30d`
- `rpt_favie_gensmo_events_field_fill_rate_view`
- `rpt_favie_gensmo_events_version_distribute_view`
- `rpt_favie_user_duration_1d_view`
- `rpt_genmso_user_recap_frequency_rank`
- `rpt_genmso_user_recap_frequency_rank_inc_1d_view`
- `rpt_gensmo_ab_active_metrics_inc_1d_view`
- `rpt_gensmo_ab_active_metrics_inc_1w_view`
- `rpt_gensmo_ab_retention_inc_1d_view`
- `rpt_gensmo_ab_retention_inc_1w_view`
- `rpt_gensmo_ab_user_duration_inc_1d_view`
- `rpt_gensmo_ab_user_dx_retention_inc_1d_view`
- `rpt_gensmo_ab_user_ltn_inc_1d_view`
- `rpt_gensmo_action_penetration_view`
- `rpt_gensmo_action_user_penetration_metric_inc_1d`
- `rpt_gensmo_avatar_full_penetration_funnel_inc_1d`
- `rpt_gensmo_management_dashboard_retention_full_1d`
- `rpt_gensmo_management_dashboard_retention_view`
- `rpt_gensmo_refer_click_user_penetration_metric_inc_1d`
- `rpt_gensmo_refer_event_metrics_inc_1d`
- `rpt_gensmo_refer_pv_user_penetration_metric_inc_1d`
- `rpt_gensmo_user_action_ltn_metrics_inc_1d`
- `rpt_gensmo_user_active_metrics_inc_1d`
- `rpt_gensmo_user_active_metrics_inc_1d_view`
- `rpt_gensmo_user_active_metrics_inc_1w`
- `rpt_gensmo_user_group_penetration_metric_inc_1d`
- `rpt_gensmo_user_ltn_metrics_inc_1d`
- `rpt_gensmo_user_retention_metrics_inc_1d`
- `rpt_gensmo_user_retention_metrics_inc_1w`
- `rpt_gensmo_user_x_action_retention_metrics_inc_1d`
- `rpt_gensmo_user_x_action_retention_metrics_inc_1d_view`
- `rpt_gensmo_user_x_active_metrics_inc_1d`
- `rpt_gensmo_user_x_retention_metrics_inc_1d`
- `rpt_gensmo_user_x_retention_metrics_inc_1d_view`
- `rpt_user_event_cnt_view`
- `rpt_user_event_field_fill_cnt_monitor_view`

---

### 其他 (other) - 46 张表

**favie_dw (18 张)**:

- `dim_agent_task_debug_info_view`
- `dim_favie_user_google_sheet_config_mut_view`
- `dim_gensmo_top_feature_config_view`
- `dim_gensmo_user_full_view`
- `dim_starquest_internal_user_view`
- `dwd_favie_city_weather_inc_1d`
- `dwd_favie_gem_workflow_inc_1d`
- `dwd_favie_gem_workflow_inc_1d_view`
- `dwd_favie_trace_log_inc_1d`
- `dwd_kafka_write_checkpoint_inc_1d`
- `dws_gensmo_refer_general_metrics_inc_1d`
- `dws_gensmo_refer_metrics_inc_1d`
- `dws_gensmo_user_activity_profile_inc_1d`
- `dws_gensmo_user_forward_tracking_inc_1d`
- `dws_gensmo_user_group_inc_1d`
- `favie_dwd_logging_favie_rank_inc_1d_view`
- `rpt_favie_gensmo_avatar_refine_detail_inc_1d_view`
- `tmp_daily_title_and_link_changes_detail_for_label_studio_analysis`

**favie_rpt (28 张)**:

- `rpt_favie_detail_quality_link_repetition_full_1d`
- `rpt_favie_gensmo_ab_home_metrics_inc_1d_view`
- `rpt_favie_gensmo_channel_metric_inc_1d`
- `rpt_favie_gensmo_channel_metric_inc_1d_view`
- `rpt_favie_gensmo_channel_metric_with_dau_inc_1d`
- `rpt_favie_gensmo_creator_details_metric_view`
- `rpt_favie_gensmo_save_metric_inc_1d`
- `rpt_favie_gensmo_save_with_dau_metric_inc_1d`
- `rpt_favie_gensmo_session_behavior_1d`
- `rpt_gensmo_avatar_funnel_7d_avg_inc_1d`
- `rpt_gensmo_avatar_task_insight_inc_1d_view`
- `rpt_gensmo_daily_comprehensive_metrics_inc_1d`
- `rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d`
- `rpt_gensmo_invalid_user_metrics_inc_1d`
- `rpt_gensmo_management_dashboard_core_feature_inc_1d`
- `rpt_gensmo_management_dashboard_uv_full_1d`
- `rpt_gensmo_management_dashboard_uv_view`
- `rpt_gensmo_refer_click_through_rate_view`
- `rpt_gensmo_refer_dimension_metrics_inc_1d`
- `rpt_gensmo_source_breakdown_analysis_in_avatar_generation_view`
- `rpt_gensmo_total_comprehensive_metrics_supply_inc_1d_view`
- `rpt_gensmo_user_action_lt7_metrics_inc_1d_view`
- `rpt_gensmo_user_avatar_cnt_inc_1d`
- `rpt_gensmo_user_lt7_metrics_inc_1d_view`
- `rpt_normalize_field_enum_distribution_1d`
- `rpt_normalize_mapping_coverage_1d`
- `rpt_normalize_non_mapping_field_stats_1d`
- `rpt_normalize_uncovered_values_1d`

---

### 试穿生成 (tryon) - 24 张表

**favie_dw (13 张)**:

- `dim_gem_user_replica_view`
- `dim_replica_task_view`
- `dim_try_on_change_background_task_view`
- `dim_try_on_task_view`
- `dim_try_on_user_task_view`
- `dwd_gensmo_user_try_on_urls_and_vibe_detail_view`
- `dws_favie_gensmo_tryon_by_event_metric_inc_1d`
- `dws_favie_gensmo_tryon_by_item_metric_inc_1d`
- `dws_favie_gensmo_tryon_metric_inc_1d`
- `dws_favie_gensmo_video_tryon_metric_inc_1d`
- `dws_gensmo_user_tryon_duration_inc_1d`
- `rpt_favie_gensmo_replica_chain_view`
- `rpt_favie_gensmo_tryon_with_avatar_metric_view`

**favie_rpt (11 张)**:

- `rpt_favie_gensmo_tryon_bysource_metric_inc_1d`
- `rpt_favie_gensmo_tryon_feedback_ab_metrics_inc_1d_view`
- `rpt_favie_gensmo_tryon_gen_bysource_metric_view`
- `rpt_favie_gensmo_tryon_metric_inc_1d`
- `rpt_favie_gensmo_tryon_model_metric_inc_1d`
- `rpt_favie_gensmo_tryon_overview_ab_metrics_inc_1d_view`
- `rpt_favie_gensmo_tryon_with_dau_metric_inc_1d`
- `rpt_favie_gensmo_video_tryon_metric_inc_1d`
- `rpt_gensmo_ab_tryon_metrics_inc_1d_view`
- `rpt_gensmo_try_on_metrics_inc_1d`
- `rpt_gensmo_user_try_on_urls_and_vibe_detail_view`

---

### 用户画像 (user_profile) - 10 张表

**favie_dw (10 张)**:

- `dim_favie_gensmo_user_account_changelog_1d`
- `dim_favie_gensmo_user_account_changelog_1d_backup`
- `dim_favie_gensmo_user_account_changelog_1d_view`
- `dim_favie_gensmo_user_account_full_1d`
- `dim_favie_gensmo_user_ids_map_inc_1d`
- `dim_favie_gensmo_user_scd2_1d`
- `dim_gensmo_user_account_view`
- `dim_user_preference_view`
- `dim_user_votes_view`
- `dwd_favie_gensmo_user_ids_map_inc_1d`

---

### 积分会员 (points_membership) - 10 张表

**favie_dw (7 张)**:

- `dim_gem_membership_view`
- `dwd_favie_gensmo_membership_consume_point_inc_1d`
- `dwd_favie_gensmo_membership_earn_point_inc_1d`
- `dwd_favie_gensmo_membership_process_node_inc_1d`
- `dws_faive_gensmo_membership_consume_points_metric_inc_1d`
- `dws_faive_gensmo_membership_earn_points_metric_inc_1d`
- `dws_faive_gensmo_membership_points_metric_inc_1d`

**favie_rpt (3 张)**:

- `rpt_faive_gensmo_membership_consume_points_metric_inc_1d`
- `rpt_faive_gensmo_membership_earn_points_metric_inc_1d`
- `rpt_faive_gensmo_membership_points_metric_inc_1d`

---

### 爬虫采集 (crawl) - 10 张表

**favie_dw (9 张)**:

- `dwd_favie_product_detail_crawl_task_15min`
- `dwd_favie_product_detail_crawl_task_1d`
- `dwd_favie_product_detail_image_crawl_task_1d`
- `dwd_favie_product_spider_status_inc_1d`
- `dwd_product_image_crawl_error_sample_inc_1d`
- `dwd_product_image_crawl_inc_1d`
- `dwd_product_image_crawl_sample_view`
- `dwd_product_quality_spider_detail_sampling_inc_1h`
- `rpt_favie_crawl_daily_host_metrics_inc_1d`

**favie_rpt (1 张)**:

- `rpt_product_image_crawl_metrics_inc_1d`

---

### 系统配置 (system) - 9 张表

**favie_dw (9 张)**:

- `dim_bigquery_job_info_full_view`
- `dim_country_region`
- `dim_country_region_google_sheet`
- `dim_site_mut`
- `dim_site_mut_google_sheet`
- `dim_site_mut_view`
- `dim_view_materialize_config`
- `dim_world_region`
- `partition_record_table`

---

### 聊天对话 (chat) - 5 张表

**favie_dw (5 张)**:

- `dim_chat_session_messages_view`
- `dim_chat_sessions_view`
- `dwd_favie_gensmo_chat_session_messages_inc_1d`
- `dws_favie_gensmo_chat_session_messages_metric_inc_1d`
- `dws_favie_gensmo_chat_session_messages_metric_inc_1d_view`

---

### 内容社区 (content) - 3 张表

**favie_dw (2 张)**:

- `dws_gensmo_tob_content_trace_metric_inc_1d`
- `dws_gensmo_tob_group_trace_metric_inc_1d`

**favie_rpt (1 张)**:

- `rpt_favie_gensmo_content_details_metric_view`

---
