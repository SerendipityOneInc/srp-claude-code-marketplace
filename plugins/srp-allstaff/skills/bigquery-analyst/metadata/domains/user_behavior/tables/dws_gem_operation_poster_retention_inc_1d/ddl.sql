CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_operation_poster_retention_inc_1d`
(
  dt DATE OPTIONS(description="分组日期（dt）"),
  user_media_source STRING OPTIONS(description="用户媒体来源"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  user_type STRING OPTIONS(description="用户类型：new_user / old_user"),
  user_tenure_type STRING OPTIONS(description="用户任期类型（如新用户/老用户分层）"),
  login_type STRING OPTIONS(description="用户登录类型"),
  platform STRING OPTIONS(description="平台，如 iOS/Android"),
  app_version STRING OPTIONS(description="用户的应用版本"),
  active_users INT64 OPTIONS(description="活跃用户数"),
  d1_retained_users INT64 OPTIONS(description="D1留存用户数（去重）"),
  d7_retained_users INT64 OPTIONS(description="D7留存用户数（去重）"),
  lt7 INT64 OPTIONS(description="1~7天累计回访次数"),
  active_post_users INT64 OPTIONS(description="主动发帖用户数"),
  passive_post_users INT64 OPTIONS(description="被动发帖用户数"),
  no_post_users INT64 OPTIONS(description="未发帖用户数"),
  active_post_d1_retained INT64 OPTIONS(description="主动发帖D1留存用户数"),
  passive_post_d1_retained INT64 OPTIONS(description="被动发帖D1留存用户数"),
  no_post_d1_retained INT64 OPTIONS(description="未发帖D1留存用户数"),
  active_post_d7_retained INT64 OPTIONS(description="主动发帖D7留存用户数"),
  passive_post_d7_retained INT64 OPTIONS(description="被动发帖D7留存用户数"),
  no_post_d7_retained INT64 OPTIONS(description="未发帖D7留存用户数"),
  active_post_lt7 INT64 OPTIONS(description="主动发帖LT7"),
  passive_post_lt7 INT64 OPTIONS(description="被动发帖LT7"),
  no_post_lt7 INT64 OPTIONS(description="未发帖LT7")
)
PARTITION BY dt;