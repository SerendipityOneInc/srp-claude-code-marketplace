with all_delete as (
        SELECT 
            f_sku_id 
        FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_archive_inc_1d`
        WHERE date(dt) = dt_param
        union all 
        select 
            f_sku_id
        from favie_dw.dwd_gem_product_detail_ha3_inc_1h
        where dt = date_add(dt_param, interval 1 day)
            and CMD = 'delete'
    )
    select 
        distinct f_sku_id
    from all_delete