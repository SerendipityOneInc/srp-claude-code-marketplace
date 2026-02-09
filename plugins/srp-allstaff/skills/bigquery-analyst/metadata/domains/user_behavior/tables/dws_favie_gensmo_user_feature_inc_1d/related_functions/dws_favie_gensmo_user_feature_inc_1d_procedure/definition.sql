BEGIN
    --   DECLARE n_day int64 default 2;
      DECLARE current_dt DATE;
      DECLARE start_dt DATE;
      
      -- 计算开始日期（从最早的日期开始正向处理）
      set start_dt = DATE_SUB(dt_param, INTERVAL n_day - 1 DAY);
      set current_dt = start_dt;

      WHILE current_dt <= dt_param DO
        delete from favie_dw.dws_favie_gensmo_user_feature_inc_1d
        where dt = current_dt;

        insert into favie_dw.dws_favie_gensmo_user_feature_inc_1d(
            dt,

            device_id,
            first_device_id,
            appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,

            last_day_feature,
            last_30_days_feature,
            last_access_at
        )
        select 
            dt,
            device_id,
            first_device_id,
            appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            created_at,
            last_day_feature,
            last_30_days_feature,
            last_access_at
        from favie_dw.dws_favie_gensmo_user_feature_inc_1d_function(current_dt);

        -- 正向递增日期
        SET current_dt = DATE_ADD(current_dt, INTERVAL 1 DAY);
    END WHILE;
END