BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;
  WHILE n_day >= 1 DO
    DELETE FROM favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d
    WHERE dt = current_dt;
    INSERT INTO favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d
    (
        dt,
        country_name,
        platform,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        order_source,
        membership_tenure_type,
        subscription_active_user_cnt,
        subscription_renewal_user_cnt,
        subscription_should_expires_user_cnt
    )
    SELECT
        dt,
        country_name,
        platform,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        order_source,
        membership_tenure_type,
        subscription_active_user_cnt,
        subscription_renewal_user_cnt,
        subscription_should_expires_user_cnt
    FROM favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END