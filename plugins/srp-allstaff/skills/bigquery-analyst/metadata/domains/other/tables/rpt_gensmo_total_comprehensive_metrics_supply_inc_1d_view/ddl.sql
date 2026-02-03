CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_total_comprehensive_metrics_supply_inc_1d_view`
AS select 
b.dt
,b.dau
,b.new_user_cnt
,b.old_user_cnt
,b.mau
,b.wnu_count
,b.us_user
,b.non_us_user
,b.android_user
,b.ios_user
,b.male_user_cnt
,b.female_user_cnt
,b.search_uv
,b.try_on_uv
,b.search_pv
,b.try_on_pv
,b.login_user_cnt
,b.install_cnt
,b.cost
,b.d1_retention_cnt
,b.d1_to_d7_retention_cnt
,b.w1_retention_cnt
,a.new_user_search_uv
,a.new_user_try_on_uv
,a.new_user_search_pv
,a.new_user_try_on_pv
,a.login_new_user_cnt
,a.login_d1_retention_cnt
,a.login_d1_to_d7_retention_cnt
,a.login_w1_retention_cnt
from srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d a
left join srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d b
on a.dt=b.dt;