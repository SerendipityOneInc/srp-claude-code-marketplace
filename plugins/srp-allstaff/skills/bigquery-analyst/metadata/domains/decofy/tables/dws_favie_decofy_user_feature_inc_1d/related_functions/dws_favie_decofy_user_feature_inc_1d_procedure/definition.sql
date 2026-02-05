BEGIN
    --   DECLARE n_day int64 default 2;
      DECLARE current_dt DATE;
      set current_dt = dt_param;

      WHILE n_day >= 1 DO
        delete from favie_dw.dws_favie_decofy_user_feature_inc_1d
        where dt = current_dt;

        insert into favie_dw.dws_favie_decofy_user_feature_inc_1d(
            dt,

            user_id,
            first_device_id,
            first_appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,

            last_day_feature,
            last_30_days_feature
        )
        select 
            dt,
            user_id,
            first_device_id,
            first_appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,

            last_day_feature,
            last_30_days_feature
        from favie_dw.dws_favie_decofy_user_feature_inc_1d_function(current_dt);

        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END