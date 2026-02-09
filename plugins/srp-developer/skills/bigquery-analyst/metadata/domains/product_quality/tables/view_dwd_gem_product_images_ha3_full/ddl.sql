CREATE VIEW `srpproduct-dc37e.favie_dw.view_dwd_gem_product_images_ha3_full`
AS SELECT 
    -- 1. 核心联合主键
    emb.f_sku_id,
    emb.f_url,
    emb.target_image_id,
    
    -- 2. 来自 Base 表的属性 (每小时变化)
    base.f_spu_id,
    base.site,
    COALESCE(base.local_price, -1) AS local_price, 
    COALESCE(base.is_used, 0) AS is_used,
    base.created_time,

    -- 3. 来自 Embedding 表的大字段 (每天变化)
    emb.embedding,

    -- 4. 时间戳计算 (关键！)
    -- 最终行的更新时间，取两者中较新的那个。
    -- 这样，无论是价格变了，还是向量变了，update_time 都会更新。
    GREATEST(
        COALESCE(emb.emb_update_time, TIMESTAMP('1970-01-01')), 
        COALESCE(base.base_update_time, TIMESTAMP('1970-01-01'))
    ) AS update_time,
    
    -- 业务日期通常由数据生成时间决定，这里建议优先取 Base 的日期(因为它是高频的)
    -- 或者直接用当前时间，视具体业务需求定
    -- COALESCE(base.base_update_date, emb.emb_update_date) AS update_date
    GREATEST(base.base_update_date, emb.emb_update_date) AS update_date

FROM `favie_dw.dwd_gem_images_embedding_full_1d` AS emb
JOIN `favie_dw.dwd_gem_product_base_full_1h` AS base
    ON emb.f_sku_id = base.f_sku_id;