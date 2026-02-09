CREATE VIEW `srpproduct-dc37e.favie_dw.favie_product_detail_clean_brand_view`
AS with product_detail_with_category_and_brand as (
    select 
        f_sku_id,
        site,
        json_extract_scalar(json_extract_array(f_categories)[safe_offset(0)],"$.name") as category_name,
        json_extract_scalar(brand,"$.name") as brand_name
    FROM 
        `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d`
    where dt = '2025-07-21'
    )
    select 
        t1.f_sku_id,
        t1.site,
        t1.brand_name,
        to_json(struct(
            t2.official_brand as name,
            t2.parent_official_brand as parent_name,
            t2.website as link
        )) as f_brand
    from product_detail_with_category_and_brand t1
    left outer join (select * from favie_dw.dim_official_brand_view where status = 1 and coalesce(trim(category),"") != "") t2
    on concat(coalesce(trim(t1.category_name),""),t1.brand_name) = concat(coalesce(trim(t2.category),""),t2.raw_brand)
    where t2.official_brand is not null
    union all 
    select 
        t1.f_sku_id,
        t1.site,
        t1.brand_name,
        to_json(struct(
            t2.official_brand as name,
            t2.parent_official_brand as parent_name,
            t2.website as link
        )) as f_brand
    from product_detail_with_category_and_brand t1
    left outer join (select * from favie_dw.dim_official_brand_view where status = 1 and coalesce(trim(category),"") = "") t2
    on t1.brand_name = t2.raw_brand
    where t2.official_brand is not null;