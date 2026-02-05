WITH rpt_favie_product_sku_data AS (
        SELECT
            dt,
            site,
            f_spu_id,
            f_review_id,
            favie_dw.get_spider_update_time(f_meta) AS updates_time,
            TIMESTAMP_SECONDS(safe_cast(f_creates_at as int64)) AS creates_time
        FROM `favie_dw.dwd_favie_product_review_full_1d`
        WHERE dt is not null 
            and date(dt) = dt_param
    ),

    rpt_favie_product_review_cube AS (
        SELECT 
            dt,
            site,
            count(1) as total_review_num,
            count(IF(date(creates_time) > DATE_SUB(dt_param, INTERVAL 7 DAY) and date(creates_time) <= dt_param , f_review_id, NULL)) AS weekly_new_review_num,
            count(IF(date(creates_time) <= DATE_SUB(dt_param, INTERVAL 7 DAY) and date(updates_time) > DATE_SUB(dt_param, INTERVAL 7 DAY) and date(updates_time) <= dt_param, f_review_id, NULL)) AS weekly_update_review_num,
            count(DISTINCT f_spu_id) AS total_spu_num_with_review
        FROM rpt_favie_product_sku_data
        GROUP BY dt,site
    ),

    rpt_favie_product_review_spu_cube_tmp AS (
        SELECT 
            dt,
            site,
            f_spu_id,
            COUNT(f_review_id) AS review_count
        FROM rpt_favie_product_sku_data
        GROUP BY dt, site, f_spu_id
    ),

    rpt_favie_product_review_spu_cube AS (
        SELECT 
            dt,
            site,
            COUNT(IF(review_count >= 10, f_spu_id, NULL)) AS spu_num_with_review_count_ge_10
        FROM rpt_favie_product_review_spu_cube_tmp
        GROUP BY dt, site
    )

    SELECT 
        date(t1.dt) AS dt,
        t1.site AS site,
        t1.total_review_num AS total_review_num,
        t1.weekly_new_review_num AS weekly_new_review_num,
        t1.weekly_update_review_num AS weekly_update_review_num,
        t1.total_spu_num_with_review AS total_spu_num_with_review,
        t2.spu_num_with_review_count_ge_10 AS spu_num_with_review_count_ge_10
    FROM rpt_favie_product_review_cube t1 
    LEFT OUTER JOIN rpt_favie_product_review_spu_cube t2
    ON t1.dt = t2.dt
        AND t1.site = t2.site