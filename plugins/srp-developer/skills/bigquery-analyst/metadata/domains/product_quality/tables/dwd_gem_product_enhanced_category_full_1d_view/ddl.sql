CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_enhanced_category_full_1d_view`
AS SELECT
      dt,
      f_sku_id,
      ARRAY_TO_STRING(
        ARRAY(
            SELECT element.element.id 
            FROM UNNEST(enhanced_category.list) AS element
        ), 
        '\x1D'
      ) AS f_category_id,
      ARRAY_TO_STRING(
        ARRAY(
            SELECT element.element.name 
            FROM UNNEST(enhanced_category.list) AS element
        ), 
        '\x1D'
      ) AS f_category_names,
      -- 获取第一个元素的id (数组索引从0开始)
      enhanced_category.list[OFFSET(0)].element.id AS f_level_one_category,
      -- 获取最后一个元素的id
      enhanced_category.list[OFFSET(ARRAY_LENGTH(enhanced_category.list) - 1)].element.id AS f_level_leaf_category,
      model_version
  FROM `favie_algo.dwd_gem_product_enhanced_category_full_1d`
  WHERE  ARRAY_LENGTH(enhanced_category.list) > 0;