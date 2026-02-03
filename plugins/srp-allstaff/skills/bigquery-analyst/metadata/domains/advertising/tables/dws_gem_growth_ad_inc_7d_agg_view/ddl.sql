CREATE VIEW `srpproduct-dc37e.favie_dw.dws_gem_growth_ad_inc_7d_agg_view`
AS with dt_data as (

select  dt
from 
favie_rpt.rpt_gem_growth_management_dashboard_v4_inc_1d
group by dt
)


SELECT  a.dt
       ,platform
       ,source
       ,ad_category
       ,attribution_method
       ,app_name
       ,CASE
  when source='Apple Search Ads'  and app_name ='Decofy' then 'INHOUSE'
  when source='Apple Search Ads'  and app_name ='Gensmo' then 'NON_INHOUSE'
  WHEN REGEXP_CONTAINS(LOWER(account_name), r'(inhouse|自投)') THEN 'INHOUSE'
  ELSE 'NON_INHOUSE'
END AS is_inhouse
       ,case when attribution_method in ('SKAN','BOTH') then 'SSOT' else 'NON_SSOT' end as is_ssot
       ,case when attribution_method in ('CLASSIC','BOTH') then 'CLASSIC' else 'NON_CLASSIC' end  as is_classic
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name
       ,ad_id
       ,ad_name
       ,SUM(impression)                                                                                       AS impression
       ,SUM(click)                                                                                            AS click
       ,SUM(conversion)                                                                                       AS conversion
       ,SUM(cost)                                                                                             AS cost
       ,SUM(install_cnt)                                                                                      AS install_cnt
       ,SUM(new_user_cnt)                                                                                     AS new_user_cnt
       ,SUM(d0_active_cnt)                                                                                    AS d0_active_cnt
       ,SUM(d1_retention_cnt)                                                                                 AS d1_retention_cnt
       ,SUM(lt7_cnt)                                                                                          AS lt7_cnt
FROM dt_data a
LEFT JOIN favie_rpt.rpt_gem_growth_management_dashboard_v4_inc_1d b

ON b.dt BETWEEN DATE_SUB(a.dt, INTERVAL 6 DAY) AND a.dt

GROUP BY  
        a.dt
       ,platform
       ,source
       ,ad_category
       ,attribution_method
       ,app_name
       ,CASE
  when source='Apple Search Ads'  and app_name ='Decofy' then 'INHOUSE'
  when source='Apple Search Ads'  and app_name ='Gensmo' then 'NON_INHOUSE'
  WHEN REGEXP_CONTAINS(LOWER(account_name), r'(inhouse|自投)') THEN 'INHOUSE'
  ELSE 'NON_INHOUSE'
END
,case when attribution_method in ('SKAN','BOTH') then 'SSOT' else 'NON_SSOT' end 
       ,case when attribution_method in ('CLASSIC','BOTH') then 'CLASSIC' else 'NON_CLASSIC' end  
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name
       ,ad_id
       ,ad_name;