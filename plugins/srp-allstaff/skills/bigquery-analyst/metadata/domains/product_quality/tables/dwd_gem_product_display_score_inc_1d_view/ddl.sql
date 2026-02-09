CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_display_score_inc_1d_view`
AS SELECT
        dt,
        f_sku_id,
        display_score,
        display_image
    FROM `favie_algo.dwd_gem_product_display_score_inc_1d`;