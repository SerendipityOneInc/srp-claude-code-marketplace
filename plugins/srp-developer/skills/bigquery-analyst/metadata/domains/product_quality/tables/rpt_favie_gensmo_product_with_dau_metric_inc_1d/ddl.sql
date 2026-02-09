CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  user_group STRING OPTIONS(description="用户分组分类"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数"),
  product_external_jump_click_cnt INT64 OPTIONS(description="商品外部跳转点击次数"),
  product_external_jump_click_user_cnt INT64 OPTIONS(description="商品外部跳转用户数"),
  product_detail_pv_cnt INT64 OPTIONS(description="商品详情卡片浏览次数"),
  product_detail_user_cnt INT64 OPTIONS(description="商品详情卡片访问用户数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);