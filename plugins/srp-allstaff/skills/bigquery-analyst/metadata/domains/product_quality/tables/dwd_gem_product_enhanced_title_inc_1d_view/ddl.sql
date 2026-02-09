CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_enhanced_title_inc_1d_view`
AS SELECT
        dt,
        f_sku_id,
        enhanced_title,
        model_version
    FROM `favie_algo.dwd_gem_product_enhanced_title_inc_1d`;