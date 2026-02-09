BEGIN
    DELETE FROM `favie_dw.dwd_gem_product_image_index_inc_1h`
    WHERE dt = dt_param AND record_hour = hour_param;

    INSERT INTO `favie_dw.dwd_gem_product_image_index_inc_1h` (
        dt,
        CMD,
        record_time,
        record_hour,

        f_sku_id,
        f_spu_id,
        site,
        f_status,

        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        is_used,
        inventory,
        image_urls,
        created_time,
        product_create_time,
        product_update_time
    )
    SELECT
        dt,
        CMD,
        record_time,
        record_hour,

        f_sku_id,
        f_spu_id,
        site,
        f_status,

        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        is_used,
        inventory,
        image_urls,
        created_time,
        product_create_time,
        product_update_time
    FROM favie_dw.dwd_gem_product_image_index_inc_1h_function(
        dt_param,
        hour_param
    );

    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_image_index_inc_1h', dt_param, hour_param);
END