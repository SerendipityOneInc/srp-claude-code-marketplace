CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_image_score_full_1d_view`
AS SELECT
        dt,
        f_sku_id,
        score AS image_score,
        model_version
    FROM `favie_algo.dwd_gem_product_image_score_full_1d`;