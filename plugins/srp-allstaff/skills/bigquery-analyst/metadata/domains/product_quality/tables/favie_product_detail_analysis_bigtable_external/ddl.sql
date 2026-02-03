CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.favie_product_detail_analysis_bigtable_external`
OPTIONS(
  format="BIGTABLE",
  uris=["https://googleapis.com/bigtable/projects/srpproduct-dc37e/instances/favie-data-base-db/tables/favie_product_detail_base_table"]
);