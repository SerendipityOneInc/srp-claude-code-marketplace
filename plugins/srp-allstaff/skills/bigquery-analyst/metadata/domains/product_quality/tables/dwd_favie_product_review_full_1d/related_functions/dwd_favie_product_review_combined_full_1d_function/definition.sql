SELECT 
        f_spu_id,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT(title, ":", body)), '\n') AS combined_title_body
    FROM 
        srpproduct-dc37e.favie_dw.dwd_favie_product_review_full_1d
        WHERE date(dt) = dt_param
    GROUP BY 
        f_spu_id