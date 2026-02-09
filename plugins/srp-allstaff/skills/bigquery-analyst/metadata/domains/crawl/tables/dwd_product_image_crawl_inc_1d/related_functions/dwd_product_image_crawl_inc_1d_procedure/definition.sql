BEGIN
      DELETE FROM `favie_dw.dwd_product_image_crawl_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dwd_product_image_crawl_inc_1d` (
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        f_sku_id,
        link,
        image_link,
        image_category
      )
      SELECT
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        f_sku_id,
        link,
        image_link,
        image_category
      FROM `favie_dw.dwd_product_image_crawl_inc_1d_function`(dt_param);
      call favie_dw.record_partition('favie_dw.dwd_product_image_crawl_inc_1d', dt_param,"");
END