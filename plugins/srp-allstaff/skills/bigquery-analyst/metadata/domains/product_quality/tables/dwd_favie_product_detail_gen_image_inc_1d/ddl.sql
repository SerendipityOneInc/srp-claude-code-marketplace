CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_gen_image_inc_1d`
(
  f_sku_id STRING OPTIONS(description="商品SKU ID"),
  f_image_list STRING OPTIONS(description="商品图片列表，JSON字符串"),
  f_meta STRING OPTIONS(description="商品元信息，JSON字符串"),
  dt DATE OPTIONS(description="数据日期，格式yyyy-MM-dd")
)
PARTITION BY dt;