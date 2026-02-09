CREATE TABLE `srpproduct-dc37e.favie_dw.dim_decofy_product_config`
(
  product_id STRING,
  simple_product_id STRING,
  period INT64,
  price_usd INT64,
  is_include_trial INT64,
  first_order_price_usd INT64,
  default_first_order_renewal_rate FLOAT64,
  default_second_order_renewal_rate FLOAT64,
  default_third_more_order_renewal_rate FLOAT64
);