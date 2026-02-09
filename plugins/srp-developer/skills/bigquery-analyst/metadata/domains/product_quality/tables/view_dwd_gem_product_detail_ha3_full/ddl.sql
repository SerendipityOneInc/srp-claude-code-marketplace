CREATE VIEW `srpproduct-dc37e.favie_dw.view_dwd_gem_product_detail_ha3_full`
AS SELECT
    -- 除了bucket_index外的所有字段
    * EXCEPT (bucket_index)
FROM
    `favie_dw.dwd_gem_product_detail_ha3_full`
-- 排除尚未就绪的商品
WHERE create_time is not null;