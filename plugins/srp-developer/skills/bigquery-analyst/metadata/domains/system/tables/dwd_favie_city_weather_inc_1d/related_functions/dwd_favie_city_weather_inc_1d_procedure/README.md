# dwd_favie_city_weather_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_city_weather_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-11-03
**最后更新**: 2025-11-03

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
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
