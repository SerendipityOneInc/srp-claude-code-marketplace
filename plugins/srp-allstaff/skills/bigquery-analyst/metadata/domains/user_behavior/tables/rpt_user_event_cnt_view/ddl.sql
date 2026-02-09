CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_user_event_cnt_view`
AS SELECT
    dt,
    event_version,
    event_name,
    COUNT(*) AS event_cnt

FROM
    favie_dw.dwd_favie_gensmo_events_inc_1d
WHERE
    dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
GROUP BY    
    dt,
    event_version,
    event_name;