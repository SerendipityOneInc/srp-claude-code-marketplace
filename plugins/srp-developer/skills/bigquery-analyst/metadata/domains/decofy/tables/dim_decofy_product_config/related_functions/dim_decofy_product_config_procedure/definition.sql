BEGIN
    CREATE OR REPLACE TABLE `favie_dw.dim_decofy_product_config` as
    select 
        *
    from favie_dw.dim_decofy_package_price_mapping_view;
END