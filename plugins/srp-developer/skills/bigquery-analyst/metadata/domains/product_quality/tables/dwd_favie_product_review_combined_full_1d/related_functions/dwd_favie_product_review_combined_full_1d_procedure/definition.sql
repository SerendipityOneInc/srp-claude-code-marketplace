BEGIN
    DELETE FROM `favie_dw.dwd_favie_product_review_combined_full_1d`
    WHERE dt = dt_param;

    INSERT INTO `favie_dw.dwd_favie_product_review_combined_full_1d` (
      dt,
      f_spu_id,
      combined_title_body
    )
    SELECT
      dt_param as dt,
      f_spu_id,
      combined_title_body
    FROM `favie_dw.dwd_favie_product_review_combined_full_1d_function`(dt_param);

    CALL favie_dw.record_partition('favie_dw.dwd_favie_product_review_combined_full_1d', dt_param, "");
END