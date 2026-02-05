# 广告投放 - 表清单

**业务域**: advertising
**表数量**: 76 张
**最后更新**: 2026-01-30

---

## 📊 表分层统计

- **DIM**: 23 张表
- **DWD**: 33 张表
- **DWS**: 9 张表
- **RPT**: 1 张表
- **OTHER**: 10 张表

---

## 维度层 (DIM)

| 表名 | 说明 |
|------|------|
| `dim_ad_all_app_creative_full_1d` | --- |
| `dim_ad_all_app_creative_tiktok_inc_1d` | --- |
| `dim_ad_all_app_creative_tiktok_inc_1d_view` | --- |
| `dim_ad_all_source_creative_multiple_full_1d_view` | --- |
| `dim_ad_all_source_creative_unique_full_1d_view` | --- |
| `dim_ad_all_source_history_creative_tag_full_view` | --- |
| `dim_ad_all_source_kol_full_1d_view` | --- |
| `dim_ad_all_source_manual_creative_tag_202512_view` | --- |
| `dim_ad_all_source_manual_creative_tag_before_202512_view` | --- |
| `dim_ad_google_creative_multiple_full_1d_view` | --- |
| `dim_ad_google_creative_youtube_video_info_full` | --- |
| `dim_ad_google_creative_youtube_video_info_full_initial_view` | --- |
| `dim_ad_google_creative_youtube_video_info_full_view` | --- |
| `dim_ad_kol_external_post_id_google_sheet_full_1d_view` | --- |
| `dim_ad_meta_creative_multiple_full_1d_view` | --- |
| `dim_ad_meta_creative_v2_full_1d_view` | --- |
| `dim_ad_tiktok_creative_full_1d_view` | --- |
| `dim_ad_tiktok_creative_multiple_full_1d_view` | --- |
| `dim_all_app_ad_full_1d_view` | --- |
| `dim_all_app_ad_full_inc_1d_view` | --- |
| `dim_all_app_appsflyer_ad_info_mapping_full_1d` | --- |
| `dim_favie_appsflyer_user_ad_source_full_1d` | --- |
| `dim_gem_appsflyer_ad_info_mapping_full_1d` | --- |

---

## 明细层 (DWD)

| 表名 | 说明 |
|------|------|
| `dwd_ad_tiktok_creative_full_1d_view` | --- |
| `dwd_all_app_appsflyer_webhook_including_non_ad_inc_1d_view` | --- |
| `dwd_gem_growth_ad_google_fivetran_by_ad_id_inc_1d_view` | --- |
| `dwd_gem_growth_ad_tiktok_fivetran_ad_geo_inc_1d_view` | --- |
| `dwd_gem_total_appsflyer_webhook_including_non_ad_inc_1d_view` | --- |
| `dwd_growth_ad_all_source_creative_inc_1d_view` | --- |
| `dwd_growth_ad_all_source_creative_with_supply_inc_1d_view` | --- |
| `dwd_growth_ad_all_source_creative_with_tag_inc_1d_view` | --- |
| `dwd_growth_ad_asa_fivetran_by_ad_id_inc_1d_view` | --- |
| `dwd_growth_ad_google_all_creative_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_google_creative_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_google_fivetran_by_ad_id_inc_1d_view` | --- |
| `dwd_growth_ad_google_fivetran_creative_id_inc_1d_view` | --- |
| `dwd_growth_ad_meta_all_creative_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view` | --- |
| `dwd_growth_ad_meta_fivetran_creative_id_inc_1d_view` | --- |
| `dwd_growth_ad_meta_fivetran_tiktok_by_ad_id_inc_1d_view` | --- |
| `dwd_growth_ad_meta_image_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_meta_video_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view` | --- |
| `dwd_growth_ad_tiktok_all_creative_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_tiktok_fivetran_ad_id_inc_1d_view` | --- |
| `dwd_growth_ad_tiktok_fivetran_campaign_geo_inc_1d_view` | --- |
| `dwd_growth_ad_tiktok_fivetran_image_inc_view` | --- |
| `dwd_growth_ad_tiktok_image_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_tiktok_image_fivetran_inc_view` | --- |
| `dwd_growth_ad_tiktok_video_fivetran_inc_1d_view` | --- |
| `dwd_growth_ad_total_by_source_inc_1d_view` | --- |
| `dwd_image_index_swift_write_result_add_1d` | --- |
| `dwd_product_index_swift_write_result_add_1d` | --- |
| `dwd_product_index_swift_write_result_add_1h` | --- |
| `dwd_product_quality_main_image_metadata_inc_1h` | --- |
| `dwd_product_quality_result_integration_field_metadata_inc_1h` | --- |

---

## 汇总层 (DWS)

| 表名 | 说明 |
|------|------|
| `dws_gem_growth_ad_inc_7d_agg_view` | --- |
| `dws_gem_growth_ad_skan_and_classic_metrics_inc_1d` | --- |
| `dws_gem_growth_ads_insights_country_full_view` | --- |
| `dws_gem_growth_ads_insights_full_view` | --- |
| `dws_gem_growth_ads_insights_platform_and_device_full_view` | --- |
| `dws_gem_growth_ads_insights_region_full_view` | --- |
| `dws_gem_growth_creative_ad_skan_classic_inc_1d` | --- |
| `dws_gem_user_feature_with_ad_info_inc_1d` | --- |
| `dws_savyo_growth_ad_metrics_inc_1d` | --- |

---

## 报表层 (RPT)

| 表名 | 说明 |
|------|------|
| `rpt_gem_growth_ad_kol_inc_1d_view` | --- |

---

## 其他

| 表名 | 说明 |
|------|------|
| `ads_favie_product_sample_daily` | --- |
| `ads_favie_webpage_sample_daily` | --- |
| `ads_gem_ha3_sync_statistics_1d` | --- |
| `ads_gem_image_bg_remove_statistics_1d` | --- |
| `ads_gem_image_outfit_emb_index_statistics_1d` | --- |
| `ads_gem_image_tagging_statistics_1d` | --- |
| `ads_gem_product_item_profile_statistics_1d` | --- |
| `ads_gem_product_title_seo_statistics_1d` | --- |
| `dw_ad_all_source_creative_multiple_full_1d_view` | --- |
| `tmp_dim_ad_all_source_history_creative_tag_full_view` | --- |

---


**生成时间**: 2026-01-30 15:33:23
**自动生成**: 本文档由脚本自动生成
