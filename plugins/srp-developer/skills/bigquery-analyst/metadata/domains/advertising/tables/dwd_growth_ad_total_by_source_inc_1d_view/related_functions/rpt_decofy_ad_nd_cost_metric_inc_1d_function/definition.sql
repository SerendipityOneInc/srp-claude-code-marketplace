SELECT
      dt,
      source as ad_source,
      ad_id,
      ad_group_id,
      campaign_id as ad_campaign_id,
      n_day as n_day,
      SUM(cost) as ad_cost
    FROM
      `srpproduct-dc37e.favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
    WHERE dt = dt_param
      AND app_name = 'Decofy'
    group by dt,ad_source,ad_id,ad_group_id,ad_campaign_id,n_day