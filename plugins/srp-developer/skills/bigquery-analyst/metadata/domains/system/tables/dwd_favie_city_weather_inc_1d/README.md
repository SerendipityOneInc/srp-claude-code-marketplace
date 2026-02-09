# dwd_favie_city_weather_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_city_weather_inc_1d`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: TABLE
**行数**: 2,944,093 行
**大小**: 1.33 GB
**创建时间**: 2025-11-03
**最后更新**: 2026-01-30

---

## 📊 表说明

城市天气日级预报表 - 基于WeatherAPI日级预报数据

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区日期 YYYY-MM-DD |
| country_name | STRING | NULLABLE | 国家名称 |
| region_name | STRING | NULLABLE | 地区名称 |
| city_name | STRING | NULLABLE | 城市名称 |
| real_country_name | STRING | NULLABLE | 实际国家名称 |
| real_region_name | STRING | NULLABLE | 实际地区名称 |
| real_city_name | STRING | NULLABLE | 实际城市名称 |
| real_latitude | FLOAT | NULLABLE | 实际纬度 |
| real_longitude | FLOAT | NULLABLE | 实际经度 |
| real_tz_id | STRING | NULLABLE | 实际时区ID |
| real_localtime_epoch | INTEGER | NULLABLE | 实际本地时间戳（Unix epoch） |
| real_localtime | STRING | NULLABLE | 实际本地时间（YYYY-MM-DD HH:MM） |
| weather_date | STRING | NULLABLE | 预报日期 YYYY-MM-DD |
| weather_date_epoch | INTEGER | NULLABLE | 预报日期时间戳（Unix epoch） |
| maxtemp_c | FLOAT | NULLABLE | 最高温度（摄氏度） |
| maxtemp_f | FLOAT | NULLABLE | 最高温度（华氏度） |
| mintemp_c | FLOAT | NULLABLE | 最低温度（摄氏度） |
| mintemp_f | FLOAT | NULLABLE | 最低温度（华氏度） |
| avgtemp_c | FLOAT | NULLABLE | 平均温度（摄氏度） |
| avgtemp_f | FLOAT | NULLABLE | 平均温度（华氏度） |
| condition_text | STRING | NULLABLE | 天气状况描述 |
| condition_icon | STRING | NULLABLE | 天气状况图标URL |
| condition_code | INTEGER | NULLABLE | 天气状况代码 |
| maxwind_mph | FLOAT | NULLABLE | 最大风速（英里/小时） |
| maxwind_kph | FLOAT | NULLABLE | 最大风速（公里/小时） |
| totalprecip_mm | FLOAT | NULLABLE | 总降水量（毫米） |
| totalprecip_in | FLOAT | NULLABLE | 总降水量（英寸） |
| totalsnow_cm | FLOAT | NULLABLE | 总积雪深度（厘米） |
| daily_will_it_rain | INTEGER | NULLABLE | 全天是否会下雨（1=是，0=否） |
| daily_chance_of_rain | INTEGER | NULLABLE | 全天降雨概率（0-100） |
| daily_will_it_snow | INTEGER | NULLABLE | 全天是否会下雪（1=是，0=否） |
| daily_chance_of_snow | INTEGER | NULLABLE | 全天降雪概率（0-100） |
| avgvis_km | FLOAT | NULLABLE | 平均能见度（公里） |
| avgvis_miles | FLOAT | NULLABLE | 平均能见度（英里） |
| avghumidity | INTEGER | NULLABLE | 平均相对湿度（百分比） |
| uv | FLOAT | NULLABLE | 紫外线指数 |
| sunrise | STRING | NULLABLE | 日出时间（HH:MM AM/PM） |
| sunset | STRING | NULLABLE | 日落时间（HH:MM AM/PM） |
| moonrise | STRING | NULLABLE | 月出时间（HH:MM AM/PM） |
| moonset | STRING | NULLABLE | 月落时间（HH:MM AM/PM） |
| moon_phase | STRING | NULLABLE | 月相（如：Waxing Gibbous） |
| moon_illumination | INTEGER | NULLABLE | 月亮照明度（0-100） |
| data_source | STRING | NULLABLE | 数据来源（如：weatherapi） |
| created_at | TIMESTAMP | NULLABLE | 记录创建时间 |
| updated_at | TIMESTAMP | NULLABLE | 记录更新时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_city_weather_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:22
**扫描工具**: scan_metadata_v2.py
