BEGIN
    DELETE FROM `favie_dw.dwd_gem_product_image_index_full_xd`
    WHERE dt = dt_param and index_env = index_env_type;

    INSERT INTO `favie_dw.dwd_gem_product_image_index_full_xd` (
        dt,
        CMD,
        record_update_time,
        record_create_time,
        index_env,

        f_sku_id,
        f_spu_id,
        site,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        norm_brand,
        is_used,
        inventory,
        f_status,
        created_time,
        emb_images,
        product_create_time,
        product_update_time
    )
    SELECT
        dt,
        CMD,
        record_update_time,
        record_create_time,
        index_env_type as index_env,
        f_sku_id,
        f_spu_id,
        site,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        norm_brand,
        is_used,
        inventory,
        f_status,
        created_time,
        emb_images,
        product_create_time,
        product_update_time
    FROM favie_dw.dwd_gem_product_image_index_full_xd_function(
        dt_param,
        emb_model_version
    );

    call favie_dw.dwd_partition_clear_procedure('favie_dw','dwd_gem_product_image_index_full_xd',2);
    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_image_index_full_xd', dt_param, index_env_type);
END