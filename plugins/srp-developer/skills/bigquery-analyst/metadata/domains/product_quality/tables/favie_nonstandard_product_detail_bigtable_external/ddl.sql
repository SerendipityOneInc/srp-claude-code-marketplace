CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.favie_nonstandard_product_detail_bigtable_external`
OPTIONS(
  format="BIGTABLE",
  uris=["https://googleapis.com/bigtable/projects/srpproduct-dc37e/instances/favie-product-merge-db/tables/favie_nonstandard_product_detail_table"]
);