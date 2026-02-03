CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_mapping_raw_brand`
(
  raw_brand STRING OPTIONS(description="爬虫数据中的原始品牌"),
  category STRING OPTIONS(description="官网品牌所属的类目"),
  official_brand STRING OPTIONS(description="官方品牌"),
  status INT64 DEFAULT 1 OPTIONS(description="该映射关系的状态，1是生效；-1是失效")
);