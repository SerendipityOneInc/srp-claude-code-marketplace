BEGIN
    DELETE FROM `favie_dw.dwd_gem_product_detail_ha3_inc_1h`
    WHERE dt = dt_param AND record_hour = hour_param;

    INSERT INTO `favie_dw.dwd_gem_product_detail_ha3_inc_1h` (
        CMD,
        f_sku_id,
        site,
        sku_id,
        spu_id,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        inventory,
        product_created_at,
        product_updated_at,
        record_time,
        record_hour,
        dt
    )
    SELECT
        CMD,
        f_sku_id,
        site,
        sku_id,
        spu_id,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        inventory,
        product_created_at,
        product_updated_at,
        record_time,
        record_hour,
        dt
    FROM favie_dw.dwd_gem_product_detail_ha3_inc_1h_function(dt_param, hour_param);

    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_detail_ha3_inc_1h', dt_param, hour_param);
END