CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_detail_quality_link_repetition_full_1d`
(
  link STRING OPTIONS(description="链接"),
  site STRING OPTIONS(description="站点"),
  shop_site STRING OPTIONS(description="店铺站点"),
  repetition_f_sku_id_cnt INT64 OPTIONS(description="重复商品数"),
  repetition_f_sku_id_list ARRAY<STRING> OPTIONS(description="重复商品列表"),
  dt DATE OPTIONS(description="日期")
)
PARTITION BY dt;