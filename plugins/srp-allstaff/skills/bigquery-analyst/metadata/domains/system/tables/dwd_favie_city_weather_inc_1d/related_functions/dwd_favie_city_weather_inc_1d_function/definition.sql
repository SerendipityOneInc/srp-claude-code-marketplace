WITH weather_data AS (
  SELECT 
    date(dt) as dt,
    city_name,
    region_name,
    country_name,
    -- 解析基础位置信息
    CAST(JSON_VALUE(content, '$.location.lat') AS FLOAT64) AS real_latitude,
    CAST(JSON_VALUE(content, '$.location.lon') AS FLOAT64) AS real_longitude,
    CAST(JSON_VALUE(content, '$.location.name') AS STRING) AS real_city_name,
    CAST(JSON_VALUE(content, '$.location.region') AS STRING) AS real_region_name,
    CAST(JSON_VALUE(content, '$.location.country') AS STRING) AS real_country_name,
    CAST(JSON_VALUE(content, '$.location.tz_id') AS STRING) AS real_tz_id,
    CAST(JSON_VALUE(content, '$.location.localtime_epoch') AS INT64) AS real_localtime_epoch,
    CAST(JSON_VALUE(content, '$.location.localtime') AS STRING) AS real_localtime,

    -- 解析预报数据数组
    JSON_EXTRACT_ARRAY(content, '$.forecast.forecastday') AS forecast_days
  FROM `favie_ods.favie_weather_data`
  WHERE date(dt) = dt_param
    and success is true
    and status_code = 200
    and content IS NOT NULL and content != ''
),

parsed_forecast AS (
  SELECT 
    wd.dt,
    wd.city_name,
    wd.region_name,
    wd.country_name,

    wd.real_country_name,
    wd.real_region_name,
    wd.real_city_name,
    wd.real_latitude,
    wd.real_longitude,
    wd.real_tz_id,
    wd.real_localtime_epoch,
    wd.real_localtime,

    -- 遍历每一天的预报数据
    JSON_VALUE(forecast_day, '$.date') AS weather_date,
    CAST(JSON_VALUE(forecast_day, '$.date_epoch') AS INT64) AS weather_date_epoch,
    
    -- 日温度预报（来自day对象）
    CAST(JSON_VALUE(forecast_day, '$.day.maxtemp_c') AS FLOAT64) AS maxtemp_c,
    CAST(JSON_VALUE(forecast_day, '$.day.maxtemp_f') AS FLOAT64) AS maxtemp_f,
    CAST(JSON_VALUE(forecast_day, '$.day.mintemp_c') AS FLOAT64) AS mintemp_c,
    CAST(JSON_VALUE(forecast_day, '$.day.mintemp_f') AS FLOAT64) AS mintemp_f,
    CAST(JSON_VALUE(forecast_day, '$.day.avgtemp_c') AS FLOAT64) AS avgtemp_c,
    CAST(JSON_VALUE(forecast_day, '$.day.avgtemp_f') AS FLOAT64) AS avgtemp_f,
    
    -- 日天气状况（来自day.condition）
    JSON_VALUE(forecast_day, '$.day.condition.text') AS condition_text,
    JSON_VALUE(forecast_day, '$.day.condition.icon') AS condition_icon,
    CAST(JSON_VALUE(forecast_day, '$.day.condition.code') AS INT64) AS condition_code,
    
    -- 日风力信息（来自day对象）
    CAST(JSON_VALUE(forecast_day, '$.day.maxwind_mph') AS FLOAT64) AS maxwind_mph,
    CAST(JSON_VALUE(forecast_day, '$.day.maxwind_kph') AS FLOAT64) AS maxwind_kph,
    
    -- 日降水信息（来自day对象）
    CAST(JSON_VALUE(forecast_day, '$.day.totalprecip_mm') AS FLOAT64) AS totalprecip_mm,
    CAST(JSON_VALUE(forecast_day, '$.day.totalprecip_in') AS FLOAT64) AS totalprecip_in,
    CAST(JSON_VALUE(forecast_day, '$.day.totalsnow_cm') AS FLOAT64) AS totalsnow_cm,
    CAST(JSON_VALUE(forecast_day, '$.day.daily_will_it_rain') AS INT64) AS daily_will_it_rain,
    CAST(JSON_VALUE(forecast_day, '$.day.daily_chance_of_rain') AS INT64) AS daily_chance_of_rain,
    CAST(JSON_VALUE(forecast_day, '$.day.daily_will_it_snow') AS INT64) AS daily_will_it_snow,
    CAST(JSON_VALUE(forecast_day, '$.day.daily_chance_of_snow') AS INT64) AS daily_chance_of_snow,
    
    -- 日能见度和湿度（来自day对象）
    CAST(JSON_VALUE(forecast_day, '$.day.avgvis_km') AS FLOAT64) AS avgvis_km,
    CAST(JSON_VALUE(forecast_day, '$.day.avgvis_miles') AS FLOAT64) AS avgvis_miles,
    CAST(JSON_VALUE(forecast_day, '$.day.avghumidity') AS INT64) AS avghumidity,
    
    -- 日紫外线指数（来自day对象）
    CAST(JSON_VALUE(forecast_day, '$.day.uv') AS FLOAT64) AS uv,
    
    -- 天文信息（来自astro对象）
    JSON_VALUE(forecast_day, '$.astro.sunrise') AS sunrise,
    JSON_VALUE(forecast_day, '$.astro.sunset') AS sunset,
    JSON_VALUE(forecast_day, '$.astro.moonrise') AS moonrise,
    JSON_VALUE(forecast_day, '$.astro.moonset') AS moonset,
    JSON_VALUE(forecast_day, '$.astro.moon_phase') AS moon_phase,
    CAST(JSON_VALUE(forecast_day, '$.astro.moon_illumination') AS INT64) AS moon_illumination

  FROM weather_data wd,
  UNNEST(wd.forecast_days) AS forecast_day
)

SELECT 
  -- 基础维度信息
  dt,  -- 分区字段
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

  -- 日期时间信息
  weather_date,
  weather_date_epoch,
  
  -- 日温度预报
  maxtemp_c,
  maxtemp_f,
  mintemp_c,
  mintemp_f,
  avgtemp_c,
  avgtemp_f,
  
  -- 日天气状况
  condition_text,
  condition_icon,
  condition_code,
  
  -- 日风力信息
  maxwind_mph,
  maxwind_kph,
  
  -- 日降水信息
  totalprecip_mm,
  totalprecip_in,
  totalsnow_cm,
  daily_will_it_rain,
  daily_chance_of_rain,
  daily_will_it_snow,
  daily_chance_of_snow,
  
  -- 日能见度和湿度
  avgvis_km,
  avgvis_miles,
  avghumidity,
  
  -- 日紫外线指数
  uv,
  
  -- 天文信息
  sunrise,
  sunset,
  moonrise,
  moonset,
  moon_phase,
  moon_illumination,
  
  -- 扩展字段
  'weatherapi' AS data_source,
  CURRENT_TIMESTAMP() AS created_at,
  CURRENT_TIMESTAMP() AS updated_at

FROM parsed_forecast