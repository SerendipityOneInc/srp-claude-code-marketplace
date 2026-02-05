CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.favie_webpage_bigtable_product_external_1`
OPTIONS(
  format="BIGTABLE",
  uris=["https://googleapis.com/bigtable/projects/srpproduct-dc37e/instances/favie-product-merge-db/tables/favie_webpage_table"]
);