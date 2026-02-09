CREATE VIEW `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_item_products_view`
AS select 
    feed_type,
    task_id,
    moodboard_id,
    moodboard_image_url,
    query,
    reasoning,
    title,
    `description`,
    gender,
    tags,
    score,
    is_feed,
    json_extract_scalar(product,"$.search_engine") as search_engine,
    json_extract_scalar(product,"$.global_id") as f_sku_id,
    product,  
    created_time,
    update_time
from favie_dw.dim_favie_gensmo_feed_item_view 
left outer join unnest(products) as product;