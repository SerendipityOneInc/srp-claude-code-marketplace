WITH membership_base AS (
        SELECT
            dt,
            user_id,
            appsflyer_id,
            order_source,
            membership_tenure_type,
            
            first_subscribe_at,
            latest_subscribe_at,
            latest_subscribe_seq,

            latest_order_expires_date,
            latest_order_renewal_at,
            latest_order_created_at,
            latest_order_subscription_seq,
            latest_order_category,
            latest_order_type,
            latest_order_seq

        FROM favie_dw.dws_decofy_membership_full_1d
        WHERE dt = dt_param
            and date(coalesce(latest_order_renewal_at,latest_order_expires_date)) >= dt_param
    ),

    user_group_info as (
        select 
            user_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            user_group
        from favie_dw.dws_decofy_user_group_inc_1d 
        where dt = dt_param
            and user_group = 'all'
    ),

    joined AS (
        SELECT
            o.dt,
            o.user_id,
            o.appsflyer_id,
            u.country_name,
            u.platform,
            u.user_group,
            u.ad_source,
            u.ad_id,
            u.ad_group_id,
            u.ad_campaign_id,
            o.order_source,
            o.membership_tenure_type,
            -- 订阅类型
            o.first_subscribe_at,
            o.latest_subscribe_at,
            o.latest_subscribe_seq,
            o.latest_order_expires_date,
            o.latest_order_renewal_at,
            o.latest_order_created_at,
            o.latest_order_subscription_seq,
            o.latest_order_category,
            o.latest_order_type,
            o.latest_order_seq
        FROM membership_base o
        LEFT JOIN user_group_info u ON o.user_id = u.user_id 
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

        count(distinct user_id) AS subscription_active_user_cnt,
        count(distinct if(
            date(latest_order_created_at) = dt_param and latest_order_subscription_seq > 1
            ,user_id,null)
        ) as subscription_renewal_user_cnt,
        count(distinct if(
            date(latest_order_created_at) = dt_param and latest_order_subscription_seq > 1
            or 
            date(latest_order_created_at) < dt_param and date(latest_order_expires_date) = dt_param
            ,user_id,null)
        ) as subscription_should_expires_user_cnt

    FROM joined
    GROUP BY
        dt,
        country_name,
        platform,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        order_source,
        membership_tenure_type