CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_country_1d_view`
AS SELECT 
t.device_id, 
t.raw_query,
t.image_url,
t.dt,
t.trace_id,
u.last_country
FROM (
    SELECT device_id, raw_query, image_url, dt, trace_id
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gem_workflow_inc_1d_view`
) t
LEFT JOIN (
    SELECT device_id, last_country
    FROM (
        SELECT 
            device_id, 
            last_country,
            ROW_NUMBER() OVER (
                PARTITION BY device_id 
                ORDER BY dt DESC
            ) as rn
        FROM `srpproduct-dc37e.favie_dw.dim_gem_user_view`
    ) ranked
    WHERE rn = 1
) u 
ON t.device_id = u.device_id;