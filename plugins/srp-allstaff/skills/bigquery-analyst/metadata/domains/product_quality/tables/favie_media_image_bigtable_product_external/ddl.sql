CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.favie_media_image_bigtable_product_external`
OPTIONS(
  format="BIGTABLE",
  uris=["https://googleapis.com/bigtable/projects/srpproduct-dc37e/instances/favie-product-merge-db/tables/favie_media_image_table"]
);