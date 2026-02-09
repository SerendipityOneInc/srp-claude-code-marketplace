CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d`
(
  dt DATE NOT NULL,
  dau INT64,
  new_user_cnt INT64,
  old_user_cnt INT64,
  mau INT64,
  wnu_count INT64,
  us_user INT64,
  non_us_user INT64,
  android_user INT64,
  ios_user INT64,
  male_user_cnt INT64,
  female_user_cnt INT64,
  search_uv INT64,
  try_on_uv INT64,
  search_pv INT64,
  try_on_pv INT64,
  login_user_cnt INT64,
  install_cnt INT64,
  cost FLOAT64,
  d1_retention_cnt INT64,
  d1_to_d7_retention_cnt INT64,
  w1_retention_cnt INT64,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
PARTITION BY dt;