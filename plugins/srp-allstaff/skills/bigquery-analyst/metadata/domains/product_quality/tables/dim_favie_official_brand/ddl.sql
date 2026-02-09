CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_official_brand`
(
  id STRING OPTIONS(description="官方品牌维表的唯一标识符，初始是按estimated_sku_num从大到小排序后的自动编号"),
  official_brand STRING OPTIONS(description="标准化后的官方品牌名称，用于统一管理多个raw_brand"),
  category STRING OPTIONS(description="品牌所属的行业类目，用于区分不同类行业下的同名品牌"),
  website STRING OPTIONS(description="品牌的官方网站URL"),
  description STRING OPTIONS(description="品牌的详细描述信息"),
  estimated_sku_num INT64 OPTIONS(description="初始的该品牌下预估的SKU数量"),
  parent_id STRING OPTIONS(description="父级品牌的ID"),
  parent_official_brand STRING OPTIONS(description="父级品牌的official_brand名称，与parent_id配合使用，提供更直观的层级关系表示")
);