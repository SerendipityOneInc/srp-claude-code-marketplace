CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_item_profile_inc_1d_view`
AS SELECT
        dt,
        f_sku_id,
        description AS alg_description,
        model_version
    FROM `favie_algo.dwd_gem_product_item_profile_inc_1d`;