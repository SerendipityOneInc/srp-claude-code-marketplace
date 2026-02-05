CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_onboarding_metric_view`
AS WITH base AS (
        SELECT
            dt,
            user_id,
            IF(refer like '%onboarding%' ,'onboarding', 'enter_app') AS refer_group
        FROM favie_dw.dws_decofy_refer_metrics_inc_1d
        WHERE dt IS NOT NULL
            and refer not like '%popup%' 
            and refer not in ('app', 'subscription')
    ),

    cnts AS (
        SELECT
            dt,
            user_id,
            refer_group,
            COUNT(1) AS refer_cnt
        FROM base
        GROUP BY dt, user_id, refer_group
    ),

    agg AS (
        SELECT
            dt,
            user_id,
            MAX(IF(refer_group = 'onboarding' AND refer_cnt > 0, 1, 0)) AS onboarding_cnt,
            MAX(IF(refer_group = 'enter_app' AND refer_cnt > 0, 1, 0)) AS enter_app_cnt
        FROM cnts
        GROUP BY dt,user_id
    ),

    user_group AS (
      SELECT
          dt,
          user_id,
          user_group,
          country_name,
          platform,
          app_version,
          user_tenure_type,
          ad_source,
          ad_id,
          ad_group_id,
          ad_campaign_id
      FROM favie_dw.dws_decofy_user_group_inc_1d
      where dt is not null
    )

    SELECT
        t1.dt,
        t1.user_id,
        t2.user_tenure_type,
        t2.country_name,
        t2.platform,
        t2.app_version,
        t2.user_group,
        t2.ad_source,
        t2.ad_id,
        t2.ad_group_id,
        t2.ad_campaign_id,
        t1.onboarding_cnt,
        t1.enter_app_cnt
    FROM agg t1 left join user_group t2
        ON t1.onboarding_cnt = 1 and t1.user_id = t2.user_id AND t1.dt = t2.dt
    WHERE t1.onboarding_cnt = 1
    and t2.user_id is not null;