CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_test_multi_result`
(
  moodboard_tags ARRAY<STRUCT<Candidates ARRAY<STRUCT<Score FLOAT64, Secondary STRING, Primary STRING>>, Category STRING>>,
  products ARRAY<STRUCT<brand STRING, category_path STRING, description STRING, title STRING, f_sku_id STRING>>,
  moodboard_image_url STRING,
  moodboard_id STRING
);