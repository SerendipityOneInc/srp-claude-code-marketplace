CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
AS SELECT 
    Date(dt) as dt,
    source,
    upper(platform) as platform ,
    app_name,
    coalesce(account_id,upper(source)) as account_id,
    coalesce(account_name,upper(source)) as account_name,
    coalesce(campaign_id,upper(source)) as campaign_id,
    coalesce(campaign_name,upper(source)) as campaign_name,
    coalesce(ad_group_id,upper(source)) as ad_group_id,
    coalesce(ad_group_name,upper(source)) as ad_group_name,
    coalesce(ad_id,upper(source)) as ad_id,
    coalesce(ad_name,upper(source)) as ad_name,
    CASE WHEN country_code = 'None' THEN cast(NULL as string ) ELSE country_code END AS country_code,
    ad_category,
    account_put_type,
    account_open_agency,
    impression,
    click,
    conversion,
    cost,
    
FROM (

    -- ASA (Apple Search Ads)
    SELECT  
        dt
       ,source
       ,platform
       ,app_name
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name
       ,ad_id
       ,ad_name
       ,country_code
       ,'UNKNOWN' as ad_category
       ,CASE 
           WHEN app_name = 'Decofy' THEN 'INHOUSE'
           WHEN app_name = 'Gensmo' THEN 'NON_INHOUSE'
           ELSE 'NON_INHOUSE'
        END as account_put_type
       ,'HUO_BAN_YUN' as account_open_agency
       ,sum(impression) as impression
       ,sum(click) as click
       ,sum(cost) as cost
       ,sum(conversion) as conversion
    FROM `favie_dw.dwd_growth_ad_asa_fivetran_by_ad_id_inc_1d_view`
    GROUP BY 
     dt
       ,source
       ,platform
       ,app_name
       ,account_id
       ,account_name
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       , ad_group_name
       , ad_id
       , ad_name
       ,country_code
       ,CASE 
           WHEN app_name = 'Decofy' THEN 'INHOUSE'
           WHEN app_name = 'Gensmo' THEN 'NON_INHOUSE'
           ELSE 'NON_INHOUSE'
        END
       
       
        

    UNION ALL

    -- Google Ads
    SELECT  
        dt,
        source,
        platform,
        app_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        ad_id,
        ad_name,
        country_code,
        'UNKNOWN' as ad_category,
        CASE 
            WHEN LOWER(account_name) LIKE '%inhouse%' OR LOWER(account_name) LIKE '%自投%' THEN 'INHOUSE'
            ELSE 'NON_INHOUSE'
        END as account_put_type,
        CASE 
            WHEN LOWER(account_name) LIKE '%yla%' THEN 'YING_LIANG'
            ELSE 'YI_DIAN'
        END as account_open_agency,
        SUM(impression) AS impression,
        SUM(click) AS click,
        SUM(cost) AS cost,
        SUM(conversion) AS conversion
    FROM `favie_dw.dwd_growth_ad_google_fivetran_by_ad_id_inc_1d_view`
    GROUP BY 
        dt,
        source,
        platform,
        app_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        ad_id,
        ad_name,
        country_code,
        CASE 
            WHEN LOWER(account_name) LIKE '%inhouse%' OR LOWER(account_name) LIKE '%自投%' THEN 'INHOUSE'
            ELSE 'NON_INHOUSE'
        END,
        CASE 
            WHEN LOWER(account_name) LIKE '%yla%' THEN 'YING_LIANG'
            ELSE 'YI_DIAN'
        END

    UNION ALL

    -- Meta Ads
    SELECT  
        dt,
        source,
        platform,
        app_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        ad_id,
        ad_name,
        country_code,
        ad_category,
        CASE 
            WHEN LOWER(account_name) LIKE '%inhouse%' OR LOWER(account_name) LIKE '%自投%' THEN 'INHOUSE'
            ELSE 'NON_INHOUSE'
        END as account_put_type,
        CASE 
            WHEN LOWER(account_name) LIKE '%yla%' THEN 'YING_LIANG'
            ELSE 'YI_DIAN'
        END as account_open_agency,
        SUM(impression) AS impression,
        SUM(click) AS click,
        SUM(cost) AS cost,
        SUM(conversion) AS conversion
    FROM `favie_dw.dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view`
    GROUP BY 
        dt,
        source,
        platform,
        app_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        ad_id,
        ad_name,
        country_code,
        ad_category,
        CASE 
            WHEN LOWER(account_name) LIKE '%inhouse%' OR LOWER(account_name) LIKE '%自投%' THEN 'INHOUSE'
            ELSE 'NON_INHOUSE'
        END,
        CASE 
            WHEN LOWER(account_name) LIKE '%yla%' THEN 'YING_LIANG'
            ELSE 'YI_DIAN'
        END

    UNION ALL

    -- TikTok Ads
    SELECT  
        dt,
        source,
        platform,
        app_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        ad_id,
        ad_name,
        country_code,
        ad_category,
        CASE 
            WHEN LOWER(account_name) LIKE '%inhouse%' OR LOWER(account_name) LIKE '%自投%' THEN 'INHOUSE'
            ELSE 'NON_INHOUSE'
        END as account_put_type,
        CASE 
            WHEN LOWER(account_name) LIKE '%yla%' THEN 'YING_LIANG'
            ELSE 'YI_DIAN'
        END as account_open_agency,
        SUM(impression) AS impression,
        SUM(click) AS click,
        SUM(cost) AS cost,
        SUM(conversion) AS conversion
    FROM `favie_dw.dwd_growth_ad_tiktok_fivetran_ad_id_inc_1d_view`
    GROUP BY 
        dt,
        source,
        platform,
        app_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        ad_id,
        ad_name,
        country_code,
        ad_category,
        CASE 
            WHEN LOWER(account_name) LIKE '%inhouse%' OR LOWER(account_name) LIKE '%自投%' THEN 'INHOUSE'
            ELSE 'NON_INHOUSE'
        END,
        CASE 
            WHEN LOWER(account_name) LIKE '%yla%' THEN 'YING_LIANG'
            ELSE 'YI_DIAN'
        END
    union all 

    SELECT  
        dt,
        source,
        platform,
        app_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        ad_id,
        ad_name,
        country_code,
        ad_category,
         account_put_type,
         account_open_agency,
        impression,
         click,
         cost,
        conversion
    FROM `favie_dw.dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view`

) a;