BEGIN
      -- 删除指定日期的旧数据
      DELETE FROM `favie_dw.dwd_favie_city_weather_inc_1d`
      WHERE dt = dt_param;

      -- 插入新数据
      INSERT INTO `favie_dw.dwd_favie_city_weather_inc_1d` (
        dt,
        country_name,
        region_name,
        city_name,

        real_country_name,
        real_region_name,
        real_city_name,
        real_latitude,
        real_longitude,
        real_tz_id,
        real_localtime_epoch,
        real_localtime,

        weather_date,
        weather_date_epoch,
        
        maxtemp_c,
        maxtemp_f,
        mintemp_c,
        mintemp_f,
        avgtemp_c,
        avgtemp_f,
        
        condition_text,
        condition_icon,
        condition_code,
        
        maxwind_mph,
        maxwind_kph,
        
        totalprecip_mm,
        totalprecip_in,
        totalsnow_cm,
        daily_will_it_rain,
        daily_chance_of_rain,
        daily_will_it_snow,
        daily_chance_of_snow,
        
        avgvis_km,
        avgvis_miles,
        avghumidity,
        
        uv,
        
        sunrise,
        sunset,
        moonrise,
        moonset,
        moon_phase,
        moon_illumination,
        
        data_source,
        created_at,
        updated_at
      )
      SELECT
        dt,
        country_name,
        region_name,
        city_name,
        
        real_country_name,
        real_region_name,
        real_city_name,
        real_latitude,
        real_longitude,
        real_tz_id,
        real_localtime_epoch,
        real_localtime,
        
        weather_date,
        weather_date_epoch,
        
        maxtemp_c,
        maxtemp_f,
        mintemp_c,
        mintemp_f,
        avgtemp_c,
        avgtemp_f,
        
        condition_text,
        condition_icon,
        condition_code,
        
        maxwind_mph,
        maxwind_kph,
        
        totalprecip_mm,
        totalprecip_in,
        totalsnow_cm,
        daily_will_it_rain,
        daily_chance_of_rain,
        daily_will_it_snow,
        daily_chance_of_snow,
        
        avgvis_km,
        avgvis_miles,
        avghumidity,
        
        uv,
        
        sunrise,
        sunset,
        moonrise,
        moonset,
        moon_phase,
        moon_illumination,
        
        data_source,
        created_at,
        updated_at
      FROM `favie_dw.dwd_favie_city_weather_inc_1d_function`(dt_param);

END