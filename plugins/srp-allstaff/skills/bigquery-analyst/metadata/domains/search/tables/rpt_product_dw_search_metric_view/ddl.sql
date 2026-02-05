CREATE VIEW `srpproduct-dc37e.favie_dw.rpt_product_dw_search_metric_view`
AS WITH rpt_product_dw_metric AS (
    SELECT 
        product_site AS site_domain,
        site_top_domain,
        site_tier,
        site_type,
        site_categories,
        site_parser_type,
        site_country_region,
        SUM(IF(dt = "2025-02-26", valid_sku_uniq_cnt, 0)) AS valid_sku_uniq_cnt,
        SUM(IF(dt = "2025-02-26", valid_spu_uniq_cnt, 0)) AS valid_spu_uniq_cnt,
        SUM(IF(dt >= "2025-02-20", inc_sku_uniq_cnt, 0)) AS d7_inc_sku_uniq_cnt,
        SUM(IF(dt >= "2025-02-20", inc_spu_uniq_cnt, 0)) AS d7_inc_spu_uniq_cnt,
        SUM(IF(dt >= "2025-02-20", update_sku_uniq_cnt, 0)) AS d7_update_sku_uniq_cnt,
        SUM(IF(dt >= "2025-02-20", update_spu_uniq_cnt, 0)) AS d7_update_spu_uniq_cnt,
        SUM(IF(dt >= "2025-01-29", inc_sku_uniq_cnt, 0)) AS d28_inc_sku_uniq_cnt,
        SUM(IF(dt >= "2025-01-29", inc_spu_uniq_cnt, 0)) AS d28_inc_spu_uniq_cnt,
        SUM(IF(dt >= "2025-01-29", update_sku_uniq_cnt, 0)) AS d28_update_sku_uniq_cnt,
        SUM(IF(dt >= "2025-01-29", update_spu_uniq_cnt, 0)) AS d28_update_spu_uniq_cnt,
        DATE("2025-02-26") AS dt
    FROM favie_dw.dws_favie_product_data_cube_inc_1d
    WHERE dt >= "2025-01-29"
    GROUP BY product_site, site_top_domain, site_tier, site_type, site_categories, site_parser_type, site_country_region
)

SELECT
    t1.site_domain,
    t1.site_top_domain,
    t1.site_tier,
    t1.site_type,
    t1.site_categories,
    t1.site_parser_type,
    t1.site_country_region,    
    t1.valid_sku_uniq_cnt,
    t1.valid_spu_uniq_cnt,
    t1.d7_inc_sku_uniq_cnt,
    t1.d7_inc_spu_uniq_cnt,
    t1.d7_update_sku_uniq_cnt,
    t1.d7_update_spu_uniq_cnt,
    t1.d28_inc_sku_uniq_cnt,
    t1.d28_inc_spu_uniq_cnt,
    t1.d28_update_sku_uniq_cnt,
    t1.d28_update_spu_uniq_cnt,
    t2.gem_ha3_recall_sku_cnt,
    t2.gem_ha3_recall_sku_uniq_cnt,
    t2.valid_gem_ha3_recall_sku_cnt,
    t2.valid_gem_ha3_recall_sku_uniq_cnt,
    t2.gem_search_retrieval_sku_cnt,
    t2.gem_search_retrieval_sku_uniq_cnt,
    t2.gem_moodboard_sku_cnt,
    t2.gem_moodboard_sku_uniq_cnt,
    IFNULL(t2.gem_ha3_recall_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS gem_ha3_recall_utilization_rate,
    IFNULL(t2.valid_gem_ha3_recall_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS valid_gem_ha3_recall_utilization_rate,
    IFNULL(t2.valid_gem_ha3_recall_sku_uniq_cnt / NULLIF((t1.d7_inc_sku_uniq_cnt + t1.d7_update_sku_uniq_cnt), 0), 0) AS d7_valid_gem_ha3_recall_utilization_rate,
    IFNULL(t2.valid_gem_ha3_recall_sku_uniq_cnt / NULLIF((t1.d28_inc_sku_uniq_cnt + t1.d28_update_sku_uniq_cnt), 0), 0) AS d28_valid_gem_ha3_recall_utilization_rate,

    IFNULL(t2.gem_ha3_recall_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS total_sku_utilization_rate,
    IFNULL(t2.gem_search_retrieval_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS total_sku_retrieval_utilization_rate,
    IFNULL(t2.gem_ha3_recall_sku_uniq_cnt / NULLIF((t1.d7_inc_sku_uniq_cnt + t1.d7_update_sku_uniq_cnt), 0), 0) AS d7_sku_utilization_rate,
    IFNULL(t2.gem_ha3_recall_sku_uniq_cnt / NULLIF((t1.d28_inc_sku_uniq_cnt + t1.d28_update_sku_uniq_cnt), 0), 0) AS d28_sku_utilization_rate,
    t1.dt AS dt
FROM rpt_product_dw_metric t1 
LEFT JOIN favie_dw.dws_favie_gem_sku_search_cube_inc_1d t2 ON t1.dt = t2.dt
    AND t1.site_domain = t2.product_site
    AND t1.site_top_domain = t2.site_top_domain
    AND t1.site_tier = t2.site_tier
    AND t1.site_type = t2.site_type
    AND t1.site_categories = t2.site_categories
    AND t1.site_parser_type = t2.site_parser_type
    AND t1.site_country_region = t2.site_country_region;