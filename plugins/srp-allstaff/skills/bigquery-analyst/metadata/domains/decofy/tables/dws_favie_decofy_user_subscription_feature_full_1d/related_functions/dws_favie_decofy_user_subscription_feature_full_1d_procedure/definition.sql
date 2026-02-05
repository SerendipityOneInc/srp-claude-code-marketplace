BEGIN

DECLARE i INT64 DEFAULT 0;
DECLARE current_dt DATE;

-- 循环处理n_day天的数据
WHILE i < n_day DO
  SET current_dt = DATE_SUB(target_dt, INTERVAL i DAY);
  
  -- 删除当前日期的数据（如果存在）
  DELETE FROM `favie_dw.dws_favie_decofy_user_subscription_feature_full_1d`
  WHERE dt = current_dt;

  -- 插入当前日期的数据
  INSERT INTO `favie_dw.dws_favie_decofy_user_subscription_feature_full_1d`
  (
    dt,
    --用户基本信息
    user_id,
    country_name,
    platform,
    app_version,

    --用户来源信息
    appsflyer_id,
    ad_source,
    ad_id,
    ad_group_id,
    ad_campaign_id,

    --创建时间
    created_at,

    --订阅信息
    first_subscription_time,
    latest_subscription_time,
    total_subscription_count,

    --付费信息
    first_paid_time,
    latest_paid_time,
    latest_paid_amount,
    latest_paid_currency,
    total_paid_count,
    total_paid_amount,
    total_paid_currency,
    today_is_expires,
    current_paid_package,
    current_paid_expires_time,
    current_package_price,
    current_package_currency,

    --试用信息
    first_trial_time,
    latest_trial_time,
    total_trial_count,
    current_trial_expires_time,

    --删除信息
    first_deleted_time,
    latest_deleted_time,
    total_deleted_count,

    --状态信息
    subscription_status,
    days_to_expire
  )
  SELECT
    dt,
    --用户基本信息
    user_id,
    country_name,
    platform,
    app_version,

    --用户来源信息
    appsflyer_id,
    ad_source,
    ad_id,
    ad_group_id,
    ad_campaign_id,

    --创建时间
    created_at,

    --订阅信息
    first_subscription_time,
    latest_subscription_time,
    total_subscription_count,

    --付费信息
    first_paid_time,
    latest_paid_time,
    latest_paid_amount,
    latest_paid_currency,
    total_paid_count,
    total_paid_amount,
    total_paid_currency,
    today_is_expires,
    current_paid_package,
    current_paid_expires_time,
    current_package_price,
    current_package_currency,

    --试用信息
    first_trial_time,
    latest_trial_time,
    total_trial_count,
    current_trial_expires_time,

    --删除信息
    first_deleted_time,
    latest_deleted_time,
    total_deleted_count,

    --状态信息
    subscription_status,
    days_to_expire
  FROM favie_dw.dws_favie_decofy_user_subscription_feature_full_1d_function(current_dt);
  
  SET i = i + 1;
END WHILE;

END