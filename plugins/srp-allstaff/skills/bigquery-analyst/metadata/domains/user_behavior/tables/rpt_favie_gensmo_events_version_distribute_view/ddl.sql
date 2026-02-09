CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_events_version_distribute_view`
AS WITH version_distribute AS (
    SELECT 
      dt, 
      event_name, 
      event_version, 
      COUNT(1) AS avie_gensmo_event_cnt
    FROM 
      favie_dw.dwd_favie_gensmo_events_inc_1d
    WHERE 
      dt >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY 
      dt, event_name, event_version
  )
  SELECT 
    dt,
    event_name,
    event_version,
    avie_gensmo_event_cnt
  FROM 
    version_distribute;