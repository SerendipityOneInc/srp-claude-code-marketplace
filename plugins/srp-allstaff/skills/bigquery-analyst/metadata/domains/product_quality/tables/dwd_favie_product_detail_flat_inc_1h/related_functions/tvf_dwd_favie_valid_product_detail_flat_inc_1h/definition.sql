SELECT
* except (rn),
IF(
    EXISTS (
        SELECT 1
        FROM UNNEST(JSON_EXTRACT_ARRAY(f_image_list)) AS image_element
        WHERE
            JSON_EXTRACT_SCALAR(image_element, '$.category') = 'main'
            AND JSON_EXTRACT_SCALAR(image_element, '$.f_link') IS NOT NULL
    ), 
    true, 
    false
) AS has_main_image
FROM (
    -- 先排序
    SELECT 
        -- f_sku_id,
        -- price,
        -- rrp,
        -- inventory,
        -- f_status,
        -- f_meta,
        -- f_image_list,
        -- f_images,
        -- site,
        -- f_updates_at,
        *,
        ROW_NUMBER() OVER (PARTITION BY f_sku_id ORDER BY f_updates_at DESC) AS rn -- 用于去重
    FROM srpproduct-dc37e.favie_dw.dwd_favie_product_detail_flat_inc_1h
    WHERE dt = input_dt
    AND hour = input_hour
) 
-- 保留最新一条记录
WHERE rn = 1
-- 过滤掉删除和归档产生的记录数据 (DATA_DELETE = 10, DATA_ARCHIVE = 11)
AND JSON_EXTRACT_SCALAR(f_meta, '$.data_type') NOT IN ('10', '11')
-- 取主图，然后主图的f_link不为空
AND EXISTS (
    SELECT 1
    FROM UNNEST(JSON_EXTRACT_ARRAY(f_image_list)) AS image_element
    WHERE
    JSON_EXTRACT_SCALAR(image_element, '$.category') = 'main'
    AND JSON_EXTRACT_SCALAR(image_element, '$.f_link') IS NOT NULL
)
-- 商品基础过滤条件
AND f_images IS NOT NULL
AND JSON_EXTRACT_SCALAR(f_images, '$.main_image') IS NOT NULL