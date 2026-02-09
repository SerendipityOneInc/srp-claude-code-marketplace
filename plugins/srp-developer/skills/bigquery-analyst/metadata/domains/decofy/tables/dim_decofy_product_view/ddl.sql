CREATE VIEW `srpproduct-dc37e.favie_dw.dim_decofy_product_view`
AS SELECT
  JSON_VALUE(to_json_string(data._id.`$oid`)) AS _id,
  JSON_VALUE(to_json_string(data.image_url.`$binary`)) AS image_url,
  JSON_VALUE(to_json_string(data.link)) AS link,
  JSON_VALUE(to_json_string(data.price)) AS price,
  JSON_VALUE(to_json_string(data.product_id)) AS product_id,
  JSON_VALUE(to_json_string(data.source)) AS source,
  JSON_VALUE(to_json_string(data.source_icon.`$binary`)) AS source_icon,
  JSON_VALUE(to_json_string(data.thumbnail.`$binary`)) AS thumbnail,
  JSON_VALUE(to_json_string(data.title)) AS title
FROM `srpproduct-dc37e.mongo_production.decofy_products`;