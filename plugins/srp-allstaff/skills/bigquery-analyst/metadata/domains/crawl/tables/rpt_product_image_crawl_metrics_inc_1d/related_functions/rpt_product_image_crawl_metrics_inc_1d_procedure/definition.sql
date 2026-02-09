BEGIN
      DELETE FROM `favie_rpt.rpt_product_image_crawl_metrics_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_rpt.rpt_product_image_crawl_metrics_inc_1d` (
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        image_category,
        download_image_cnt,
        download_image_sku_cnt
      )
      SELECT
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        image_category,
        download_image_cnt,
        download_image_sku_cnt
      FROM `favie_rpt.rpt_product_image_crawl_metrics_inc_1d_function`(dt_param);
      call favie_dw.record_partition('favie_rpt.rpt_product_image_crawl_metrics_inc_1d', dt_param,"");
END