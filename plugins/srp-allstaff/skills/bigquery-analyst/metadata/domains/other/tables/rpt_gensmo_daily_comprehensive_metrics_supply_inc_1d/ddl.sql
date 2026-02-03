CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d`
(
  dt DATE NOT NULL OPTIONS(description="报告日期"),
  new_user_search_uv INT64 OPTIONS(description="新用户搜索UV"),
  new_user_try_on_uv INT64 OPTIONS(description="新用户试穿UV"),
  new_user_search_pv INT64 OPTIONS(description="新用户搜索PV"),
  new_user_try_on_pv INT64 OPTIONS(description="新用户试穿PV"),
  login_new_user_cnt INT64 OPTIONS(description="登录新用户数"),
  login_d1_retention_cnt INT64 OPTIONS(description="登录用户D1留存数（次日更新）"),
  login_d1_to_d7_retention_cnt INT64 OPTIONS(description="登录用户1D7S留存数（第8天更新）"),
  login_w1_retention_cnt INT64 OPTIONS(description="登录用户W1留存数（第15天更新）"),
  created_at TIMESTAMP OPTIONS(description="创建时间"),
  updated_at TIMESTAMP OPTIONS(description="更新时间")
)
PARTITION BY dt
OPTIONS(
  description="Gensmo每日综合指标补充表，包含新用户行为数据和登录用户留存指标"
);