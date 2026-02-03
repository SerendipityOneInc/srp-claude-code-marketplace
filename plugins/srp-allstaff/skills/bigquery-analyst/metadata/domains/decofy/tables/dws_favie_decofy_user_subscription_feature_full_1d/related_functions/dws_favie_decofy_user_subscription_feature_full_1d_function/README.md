# dws_favie_decofy_user_subscription_feature_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_decofy_user_subscription_feature_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-08-12
**最后更新**: 2025-08-12

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH all_users AS (
        SELECT 
            user_id,
            appsflyer_id,
            datetime(created_at) as created_at
        FROM `favie_dw.dim_favie_decofy_user_account_changelog_1d`
        WHERE user_id IS NOT NULL
            and DATE(datetime(created_at)) <= dt_param
    ),
    
    subscription_data AS (
        SELECT 
            t1.user_id,
            t1.original_transaction_id,
            t1.product_id,
            t2.price_usd AS product_price,
            "USD" AS product_currency,
            t1.price as paid_price,
            t1.currency as paid_currency,
            t1.created_at,
            t1.updated_at,
            t1.expires_date,
            t1.deleted_at,
            -- 判断是否为付费订阅（价格大于0）
            CASE WHEN t1.price > 0 THEN 1 ELSE 0 END AS is_paid,
            -- 判断是否为免费试用（价格为0或空）
            CASE WHEN t1.price = 0 OR t1.price IS NULL THEN 1 ELSE 0 END AS is_trial,
            -- 判断是否为已删除订阅
            CASE WHEN t1.deleted_at IS NOT NULL THEN 1 ELSE 0 END AS is_deleted
        FROM `favie_dw.dim_decofy_subscriptions_view` t1
        left outer join `favie_dw.dim_decofy_package_price_mapping_view` t2
        on t1.product_id = t2.product_id
        WHERE user_id IS NOT NULL
            AND DATE(created_at) <= dt_param  -- 只考虑指定日期之前创建的订阅
    ),

    -- 计算每个original_transaction_id的创建时间
    subscription_times AS (
        SELECT 
            user_id,
            original_transaction_id,
            MIN(created_at) AS subscription_created_time
        FROM subscription_data
        WHERE original_transaction_id IS NOT NULL
        GROUP BY user_id, original_transaction_id
    ),

    user_subscription_metrics AS (
        SELECT 
            s.user_id,
            
            -- 第一次订阅时间（按不同original_transaction_id的最早创建时间）
            MIN(st.subscription_created_time) AS first_subscription_time,
            
            -- 最近一次订阅时间（按不同original_transaction_id的最晚创建时间）
            MAX(st.subscription_created_time) AS latest_subscription_time,
            
            -- 第一次付费时间
            MIN(CASE WHEN s.is_paid = 1 THEN s.created_at END) AS first_paid_time,
            
            -- 最近一次付费时间
            MAX(CASE WHEN s.is_paid = 1 THEN s.created_at END) AS latest_paid_time,
            
            -- 最近一次付费金额
            MAX(CASE WHEN s.is_paid = 1 THEN s.paid_price END) AS latest_paid_amount,
            
            -- 最近一次付费货币
            MAX(CASE WHEN s.is_paid = 1 THEN s.paid_currency END) AS latest_paid_currency,
            
            -- 第一次免费试用时间
            MIN(CASE WHEN s.is_trial = 1 THEN s.created_at END) AS first_trial_time,
            
            -- 最近一次免费试用时间
            MAX(CASE WHEN s.is_trial = 1 THEN s.created_at END) AS latest_trial_time,
            
            -- 总订阅次数（使用subscription_times去重）
            COUNT(DISTINCT st.original_transaction_id) AS total_subscription_count,
            
            -- 总付费次数
            SUM(CASE WHEN s.is_paid = 1 THEN 1 ELSE 0 END) AS total_paid_count,
            
            -- 总付费金额
            SUM(CASE WHEN s.is_paid = 1 THEN s.product_price ELSE 0 END) AS total_paid_amount,
            
            -- 总付费货币（统一为USD）
            "USD" AS total_paid_currency,
            
            -- 总试用次数
            SUM(CASE WHEN s.is_trial = 1 THEN 1 ELSE 0 END) AS total_trial_count,
            
            -- 第一次删除订阅时间
            MIN(CASE WHEN s.is_deleted = 1 THEN s.deleted_at END) AS first_deleted_time,
            
            -- 最近一次删除订阅时间
            MAX(CASE WHEN s.is_deleted = 1 THEN s.deleted_at END) AS latest_deleted_time,
            
            -- 总订阅删除次数
            SUM(CASE WHEN s.is_deleted = 1 THEN 1 ELSE 0 END) AS total_deleted_count
            
        FROM subscription_data s
        LEFT JOIN subscription_times st ON s.user_id = st.user_id AND s.original_transaction_id = st.original_transaction_id
        GROUP BY user_id
    ),

    current_subscription_status AS (
        SELECT 
            user_id,
            product_id AS current_paid_package,
            expires_date AS current_paid_expires_time,
            product_price AS current_package_price,
            product_currency AS current_package_currency,
            -- 判断是否为当前活跃订阅
            CASE 
                WHEN deleted_at IS NULL AND DATE(expires_date) > dt_param THEN 1 
                ELSE 0 
            END AS is_currently_active,
            ROW_NUMBER() OVER (
                PARTITION BY user_id 
                ORDER BY expires_date DESC, created_at DESC
            ) AS rn
        FROM subscription_data
        WHERE is_paid = 1  -- 只考虑付费订阅
    ),

    current_trial_status AS (
        SELECT 
            user_id,
            expires_date AS current_trial_expires_time,
            -- 判断是否为当前活跃试用
            CASE 
                WHEN deleted_at IS NULL AND DATE(expires_date) > dt_param THEN 1 
                ELSE 0 
            END AS is_trial_currently_active,
            ROW_NUMBER() OVER (
                PARTITION BY user_id 
                ORDER BY expires_date DESC, created_at DESC
            ) AS rn
        FROM subscription_data
        WHERE is_trial = 1 AND deleted_at IS NULL
    ),

    user_subscription_status AS (
        SELECT 
            dt_param AS dt,
            u.user_id,
            coalesce(uf.last_30_days_feature.geo_country_name,fs.country_name) as country_name,
            coalesce(uf.last_day_feature.platform,fs.platform) as platform,
            coalesce(uf.last_day_feature.app_version,fs.app_version) as app_version,

            u.appsflyer_id,
            coalesce(af.source,fs.ad_source) as ad_source,
            coalesce(af.ad_id,fs.ad_id) as ad_id,
            coalesce(af.ad_group_id,fs.ad_group_id) as ad_group_id,
            coalesce(af.campaign_id,fs.ad_campaign_id) as ad_campaign_id,

            u.created_at,
            
            -- 订阅时间相关字段
            m.first_subscription_time,
            m.latest_subscription_time,
            COALESCE(m.total_subscription_count, 0) AS total_subscription_count,
            
            -- 付费相关字段
            m.first_paid_time,
            m.latest_paid_time,
            COALESCE(m.latest_paid_amount, 0) AS latest_paid_amount,
            m.latest_paid_currency,
            COALESCE(m.total_paid_count, 0) AS total_paid_count,
            COALESCE(m.total_paid_amount, 0) AS total_paid_amount,
            if(date(fs.current_paid_expires_time) = dt_param ,1,0) as today_is_expires,
            m.total_paid_currency,
            c.current_paid_package,
            c.current_paid_expires_time,
            c.current_package_price,
            c.current_package_currency,
            
            -- 试用相关字段
            m.first_trial_time,
            m.latest_trial_time,
            COALESCE(m.total_trial_count, 0) AS total_trial_count,
            t.current_trial_expires_time,
            
            -- 删除相关字段
            m.first_deleted_time,
            m.latest_deleted_time,
            COALESCE(m.total_deleted_count, 0) AS total_deleted_count,
            
            -- 用户状态字段
            CASE 
                WHEN c.current_paid_package IS NOT NULL AND c.is_currently_active = 1 THEN 'active_paid'
                WHEN t.current_trial_expires_time IS NOT NULL AND t.is_trial_currently_active = 1 THEN 'active_trial'
                WHEN COALESCE(m.total_paid_count, 0) > 0 THEN 'expired_paid'
                WHEN COALESCE(m.total_trial_count, 0) > 0 THEN 'trial_only'
                ELSE 'no_subscription'
            END AS subscription_status,
            
            -- 距离到期天数（根据当前活跃订阅类型计算）
            CASE 
                WHEN c.current_paid_package IS NOT NULL AND c.is_currently_active = 1 
                THEN DATE_DIFF(DATE(c.current_paid_expires_time), dt_param, DAY)
                WHEN t.current_trial_expires_time IS NOT NULL AND t.is_trial_currently_active = 1 
                THEN DATE_DIFF(DATE(t.current_trial_expires_time), dt_param, DAY)
                ELSE NULL
            END AS days_to_expire
            
        FROM all_users u
        LEFT JOIN user_subscription_metrics m ON u.user_id = m.user_id
        LEFT JOIN current_subscription_status c ON u.user_id = c.user_id AND c.rn = 1
        LEFT JOIN current_trial_status t ON u.user_id = t.user_id AND t.rn = 1
        LEFT JOIN favie_dw.dws_favie_decofy_user_feature_inc_1d uf ON u.user_id = uf.user_id and uf.dt = dt_param
        LEFT JOIN favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view af ON u.appsflyer_id = af.appsflyer_id and af.dt = dt_param
        LEFT JOIN favie_dw.dws_favie_decofy_user_subscription_feature_full_1d fs ON u.user_id = fs.user_id and fs.dt = date_sub(dt_param, INTERVAL 1 DAY)
    )

    SELECT 
        dt,
        user_id,
        country_name,
        platform,
        app_version,

        appsflyer_id,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        created_at,
        
        -- 订阅时间相关字段
        first_subscription_time,
        latest_subscription_time,
        total_subscription_count,
        
        -- 付费相关字段
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
        
        -- 试用相关字段
        first_trial_time,
        latest_trial_time,
        total_trial_count,
        current_trial_expires_time,
        
        -- 删除相关字段
        first_deleted_time,
        latest_deleted_time,
        total_deleted_count,
        
        -- 用户状态字段
        subscription_status,
        days_to_expire
    FROM user_subscription_status
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
