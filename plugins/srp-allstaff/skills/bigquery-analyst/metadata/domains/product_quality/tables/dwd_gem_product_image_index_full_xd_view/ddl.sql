CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_full_xd_view`
AS with full_image_data as (
        SELECT
            full_xd.dt,
            full_xd.CMD,
            full_xd.record_update_time,
            full_xd.record_create_time,
            full_xd.index_env,
            full_xd.f_sku_id,
            full_xd.f_spu_id,
            full_xd.site,
            full_xd.local_price,
            full_xd.local_currency,
            full_xd.base_price,
            full_xd.base_currency,
            full_xd.discount,
            full_xd.norm_brand,
            full_xd.is_used,
            full_xd.inventory,
            full_xd.f_status,
            full_xd.created_time,
            emb_image,
            full_xd.product_create_time,
            full_xd.product_update_time
        FROM `favie_dw.dwd_gem_product_image_index_full_xd` as full_xd,unnest(emb_images) as emb_image
        WHERE full_xd.dt is not null 
            and full_xd.dt = (select max(date(dt)) from `favie_dw.dwd_gem_product_image_index_full_xd` where dt is not null)
            and full_xd.index_env = 'production'
            and emb_image.CMD = 'add'
            and full_xd.CMD = 'add'
            and emb_image.image_url is not null
            and emb_image is not null
    ),
    hour_deleted_skus as (
        SELECT
            f_sku_id
        FROM
            `favie_dw.dwd_gem_product_image_index_inc_1h`
        WHERE dt is not null 
            and dt > (select max(date(dt)) from `favie_dw.dwd_gem_product_image_index_full_xd` where dt is not null)
            AND CMD = 'delete'
    )

    select 
        t1.CMD,
        CONCAT(t1.f_sku_id, '_',t1.emb_image.image_url) AS target_image_id,
        t1.f_sku_id,
        t1.f_spu_id,
        t1.site,
        t1.emb_image.image_url AS f_url,
        t1.local_price,
        t1.local_currency,
        t1.base_price,
        t1.base_currency,
        t1.discount,
        t1.norm_brand,
        t1.is_used,
        t1.inventory,
        t1.f_status,
        t1.product_create_time,
        t1.product_update_time,
        t1.record_create_time,
        t1.record_update_time,
        t1.dt
    from full_image_data t1 left outer join hour_deleted_skus t2
    on t1.f_sku_id = t2.f_sku_id
    where t1.CMD = 'add' and t2.f_sku_id is null;