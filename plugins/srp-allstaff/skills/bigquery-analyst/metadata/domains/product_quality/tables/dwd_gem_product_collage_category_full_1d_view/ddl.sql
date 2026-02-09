CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_collage_category_full_1d_view`
AS SELECT
    dt,
    f_sku_id,
    lower(collage_category) as collage_category,
    model_version
  FROM `favie_algo.dwd_gem_product_collage_category_full_1d`;