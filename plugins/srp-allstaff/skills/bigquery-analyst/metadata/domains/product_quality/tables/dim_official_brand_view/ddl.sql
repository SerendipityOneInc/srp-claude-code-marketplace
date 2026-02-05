CREATE VIEW `srpproduct-dc37e.favie_dw.dim_official_brand_view`
AS select 
        t1.raw_brand,
        t1.category,
        t1.official_brand,
        t2.parent_official_brand,
        t2.website,
        t1.status
    from srpproduct-dc37e.favie_dw.dim_favie_mapping_raw_brand t1 
    left outer join srpproduct-dc37e.favie_dw.dim_favie_official_brand t2
    on concat(coalesce(trim(t1.category),""),t1.official_brand) = concat(coalesce(trim(t2.category),""),t2.official_brand);