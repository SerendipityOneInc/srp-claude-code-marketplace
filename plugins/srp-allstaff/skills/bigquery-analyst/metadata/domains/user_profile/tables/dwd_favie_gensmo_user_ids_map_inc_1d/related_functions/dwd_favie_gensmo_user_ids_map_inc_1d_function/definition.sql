WITH latest_mapping AS (
        SELECT
            user_id,
            device_id,
            appsflyer_id,
            dt,
            event_timestamp,
            ROW_NUMBER() OVER (
                PARTITION BY user_id
                ORDER BY event_timestamp DESC
            ) AS rn
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND user_id IS NOT NULL
            AND device_id IS NOT NULL
            AND appsflyer_id IS NOT NULL
            AND refer_group = 'valid'
    )
    SELECT
        user_id,
        device_id,
        appsflyer_id,
        dt,
        event_timestamp
    FROM latest_mapping
    WHERE rn = 1