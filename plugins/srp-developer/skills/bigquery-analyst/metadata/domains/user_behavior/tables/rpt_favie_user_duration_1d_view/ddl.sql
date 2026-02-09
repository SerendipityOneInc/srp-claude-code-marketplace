CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_user_duration_1d_view`
AS SELECT
 u.user_name,
  d.dt,
  max(e.user_id) as user_id ,
  max(d.device_id) AS device_id,
  max(e.user_email) AS user_email,
  max(e.user_name) AS user_account_name,
  sum(last_day_feature.duration) as total_duration ,
  ROUND(SUM(last_day_feature.duration) / 60, 1) AS total_duration_minutes
FROM  `favie_dw.dws_favie_gensmo_user_feature_inc_1d`  d

left join (select last_device_id,max(user_id) as user_id,max(user_email) as user_email,max(user_name) as user_name from  `favie_dw.dim_favie_gensmo_user_account_changelog_1d` group by last_device_id ) e
on e.last_device_id=d.device_id
 
JOIN `favie_dw.dim_favie_user_google_sheet_config_mut_view`  u
  ON  (CAST(e.user_id AS STRING) = cast (u.user_id  AS STRING ) or CAST(e.user_email AS STRING) = u.user_email) or (d.device_id=u.device_id)
  group by u.user_name,
  d.dt;