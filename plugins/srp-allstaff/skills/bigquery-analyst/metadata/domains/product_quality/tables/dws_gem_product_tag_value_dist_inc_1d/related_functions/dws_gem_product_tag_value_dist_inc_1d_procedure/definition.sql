BEGIN
    -- 1) 先删掉当天的数据（幂等性）
    DELETE FROM favie_dw.dws_gem_product_tag_value_dist_inc_1d
    WHERE dt = dt_param;

    -- 2) 插入最新数据
    INSERT INTO favie_dw.dws_gem_product_tag_value_dist_inc_1d
    (
      dt,
      site,
      collage_category,
      tag,
      tag_value,
      sku_cnt
    )
    SELECT
      dt,
      site,
      collage_category,
      tag,
      tag_value,
      sku_cnt
    FROM favie_dw.dws_gem_product_tag_value_dist_inc_1d_function(dt_param);
END