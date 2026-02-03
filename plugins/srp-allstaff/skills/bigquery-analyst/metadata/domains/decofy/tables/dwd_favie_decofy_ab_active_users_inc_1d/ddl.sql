CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_decofy_ab_active_users_inc_1d`
(
  dt DATE OPTIONS(description="数据日期"),
  user_id STRING OPTIONS(description="用户ID"),
  ab_project STRING OPTIONS(description="AB测试项目"),
  ab_router STRING OPTIONS(description="AB测试路由"),
  ab_unique_id STRING OPTIONS(description="AB测试唯一ID"),
  ab_start_date DATE OPTIONS(description="AB测试开始时间"),
  enter_ab_date DATE OPTIONS(description="进入AB测试时间")
)
PARTITION BY dt;