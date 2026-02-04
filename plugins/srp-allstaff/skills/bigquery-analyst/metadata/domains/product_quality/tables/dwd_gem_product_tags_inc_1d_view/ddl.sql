CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_tags_inc_1d_view`
AS SELECT
        dt,
        f_sku_id,
        gender_tag,
        lower(brand_tag) as brand_tag,
        skin_tag,
        benefits_tag,
    FROM `favie_algo.gem_product_tags_full_1d`;