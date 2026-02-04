WITH rpt_favie_webpage_data AS (
        SELECT
            dt,
            domain,
            md5_id,
            favie_dw.get_spider_update_time(f_meta) AS updates_time,
            TIMESTAMP_SECONDS(safe_cast(create_time as int64)) AS creates_time
        FROM `favie_dw.dwd_favie_webpage_full_1d`
        WHERE dt is not null 
            and date(dt) = dt_param
    ),

    rpt_favie_webpage_cube AS (
        SELECT 
            dt,
            domain,
            count(1) as total_webpage_num,
            count(IF(date(creates_time) > DATE_SUB(dt_param, INTERVAL 7 DAY) and date(creates_time) <= dt_param , md5_id, NULL)) AS weekly_new_webpage_num,
            count(IF(date(creates_time) <= DATE_SUB(dt_param, INTERVAL 7 DAY) and date(updates_time) > DATE_SUB(dt_param, INTERVAL 7 DAY) and date(updates_time) <= dt_param, md5_id, NULL)) AS weekly_update_webpage_num,
        FROM rpt_favie_webpage_data
        GROUP BY dt,domain
    )

    select 
        domain,
        total_webpage_num,
        weekly_new_webpage_num,
        weekly_update_webpage_num,
        dt_param AS dt
    from rpt_favie_webpage_cube