CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_operation_banner_detail_inc_1d`
(
  dt DATE OPTIONS(description="事件发生日期"),
  item_name STRING OPTIONS(description="banner 关联的内容名称"),
  user_media_source STRING OPTIONS(description="用户媒体来源（根据优先级规则映射得到）"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  user_type STRING OPTIONS(description="用户类型（如新用户/老用户等）"),
  user_tenure_type STRING OPTIONS(description="用户生命周期类型（如新客/留存/流失等）"),
  login_type STRING OPTIONS(description="用户登录方式（last_day_feature.login_type）"),
  platform STRING OPTIONS(description="用户平台（last_day_feature.platform）"),
  app_version STRING OPTIONS(description="用户使用的 app 版本（last_day_feature.app_version）"),
  banner_view_pv INT64 OPTIONS(description="曝光次数（true_view_trigger 且 item_type=hashtag 的事件数）"),
  banner_view_uv INT64 OPTIONS(description="曝光用户数（去重 device_id）"),
  banner_click_pv INT64 OPTIONS(description="点击次数（点击 hashtag banner 进入详情页的事件数）"),
  banner_click_uv INT64 OPTIONS(description="点击用户数（去重 device_id）")
)
PARTITION BY dt;