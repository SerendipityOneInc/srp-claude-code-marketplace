# rpt_gensmo_daily_comprehensive_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d` (dwd_favie_gensmo_events_inc_1d)
- `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` (dws_favie_gensmo_user_feature_inc_1d)

---

## 💻 函数定义

```sql
WITH gender_data AS (
    SELECT  
        dt,
        COUNT(DISTINCT CASE WHEN final_gender = 'Male' THEN user_id ELSE NULL END) AS male_user_cnt,
        COUNT(DISTINCT CASE WHEN final_gender = 'Female' THEN user_id ELSE NULL END) AS female_user_cnt,
        
    FROM (
        SELECT  
            user_id,
            dt,
            final_gender
        FROM (
            SELECT  
                *, 
                -- 基于preference.gender和onboard_tags判断性别
                CASE 
                    -- 优先判断preference.gender字段
                    WHEN LOWER(TRIM(COALESCE(preference_gender,''))) IN ('male','man','men','m') THEN 'Male' 
                    WHEN LOWER(TRIM(COALESCE(preference_gender,''))) IN ('female','woman','women','f') THEN 'Female' 
                    
                    -- 如果preference.gender无法判断，则使用onboard_tags
                    WHEN (preference_gender IS NULL OR TRIM(preference_gender) = '' OR LOWER(TRIM(preference_gender)) NOT IN ('male','man','men','m','female','woman','women','f')) 
                         AND EXISTS (
                            SELECT 1 FROM UNNEST(onboard_tags) AS tag
                            WHERE LOWER(JSON_EXTRACT_SCALAR(tag, '$')) IN ('male', 'man', 'men')
                         ) AND NOT EXISTS (
                            SELECT 1 FROM UNNEST(onboard_tags) AS tag
                            WHERE LOWER(JSON_EXTRACT_SCALAR(tag, '$')) IN ('female', 'woman', 'women')
                         ) THEN 'Male' 
                         
                    WHEN (preference_gender IS NULL OR TRIM(preference_gender) = '' OR LOWER(TRIM(preference_gender)) NOT IN ('male', 'man', 'men', 'm', 'female', 'woman', 'women', 'f')) 
                         AND EXISTS (
                            SELECT 1 FROM UNNEST(onboard_tags) AS tag
                            WHERE LOWER(JSON_EXTRACT_SCALAR(tag, '$')) IN ('female', 'woman', 'women')
                         ) AND NOT EXISTS (
                            SELECT 1 FROM UNNEST(onboard_tags) AS tag
                            WHERE LOWER(JSON_EXTRACT_SCALAR(tag, '$')) IN ('male', 'man', 'men')
                         ) THEN 'Female' 
                         
                    ELSE 'Unknown' 
                END AS final_gender
            FROM (
                SELECT  
                    user_id,
                    json_value(preference,'$.gender') AS preference_gender,
                    DATE(last_updated) AS dt,
                    json_extract_array(onboard_tags) as onboard_tags
                FROM `favie_dw.dim_user_preference_view`
                WHERE onboard_tags IS NOT NULL 
            )
        )
        GROUP BY user_id, dt, final_gender
        HAVING DATE(dt) = dt_param
    )
    GROUP BY dt
),

user_general_metrics AS (
    SELECT 
        dt,
        COUNT(DISTINCT device_id) AS dau,
        COUNT(DISTINCT CASE WHEN user_tenure_type='New User' THEN device_id ELSE NULL END) AS new_user_cnt,
        COUNT(DISTINCT CASE WHEN user_tenure_type='Old User' THEN device_id ELSE NULL END) AS old_user_cnt,
        COUNT(DISTINCT CASE WHEN last_day_feature.geo_country_name='United States' THEN device_id ELSE NULL END) AS us_user,
        COUNT(DISTINCT CASE WHEN last_day_feature.geo_country_name!='United States' THEN device_id ELSE NULL END) AS non_us_user,
        COUNT(DISTINCT CASE WHEN LOWER(last_day_feature.platform)='android' THEN device_id ELSE NULL END) AS android_user,
        COUNT(DISTINCT CASE WHEN LOWER(last_day_feature.platform)='app' THEN device_id ELSE NULL END) AS ios_user,
        COUNT(DISTINCT CASE WHEN LOWER(last_day_feature.login_type)='login' THEN device_id ELSE NULL END) AS login_user_cnt
    FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
    WHERE dt = dt_param
    GROUP BY dt 
),

date_range AS (
    SELECT DISTINCT dt
    FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
    WHERE dt = dt_param
),

-- 过去三十天的MAU
mau AS (
    SELECT 
        d.dt AS report_date,
        COUNT(DISTINCT u.device_id) AS mau
    FROM date_range d
    LEFT JOIN `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` u
    ON u.dt BETWEEN DATE_SUB(d.dt, INTERVAL 29 DAY) AND d.dt
    GROUP BY d.dt
    ORDER BY d.dt DESC
),




core_function_data AS ( 
 SELECT
        dt,
        COUNT(DISTINCT CASE 
            WHEN event_action_type = 'collage_gen' THEN device_id 
            ELSE NULL 
        END) AS search_uv,
        COUNT(DISTINCT CASE 
            WHEN event_action_type in ( 'try_on' ,'try_on_no_avatar','try_on_trigger') THEN device_id 
            ELSE NULL 
        END) AS try_on_uv,
        COUNT(CASE 
            WHEN event_action_type = 'collage_gen' THEN event_uuid 
            ELSE NULL 
        END) AS search_pv,
        COUNT(CASE 
            WHEN event_action_type in ( 'try_on' ,'try_on_no_avatar','try_on_trigger') THEN event_uuid 
            ELSE NULL 
        END) AS try_on_pv
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d`
    WHERE device_id IS NOT NULL
    AND refer_group = "valid"
    AND event_version = "1.0.0"
    AND dt = dt_param
    GROUP BY dt
),



-- 周新增用户
wnu AS (
    -- dt_param是今天的日期
    SELECT 
        dt_param AS dt,
        COUNT(DISTINCT device_id) AS wnu_count
    FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
    WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 6 DAY) AND dt_param
    AND user_tenure_type = 'New User'
),

install_cnt AS (
    SELECT 
        COUNT(DISTINCT appsflyer_id) AS install_cnt,
        dt
    FROM `favie_dw.dwd_all_app_appsflyer_webhook_only_install_1d_view`
    WHERE app_name = 'Gensmo'
    AND channel != 'SKAN' 
    AND dt = dt_param
    GROUP BY dt 
),

cost AS (
    SELECT  
        SUM(cost) AS cost,
        dt
    FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
    WHERE app_name = 'Gensmo' 
    AND dt = dt_param
    GROUP BY dt
)

-- 汇总所有指标
SELECT 
    dt_param AS dt,
    
    -- 基础指标
    COALESCE(ugm.dau, 0) AS dau,
    COALESCE(ugm.new_user_cnt, 0) AS new_user_cnt,
    COALESCE(ugm.old_user_cnt, 0) AS old_user_cnt,
    COALESCE(m.mau, 0) AS mau,
    COALESCE(w.wnu_count, 0) AS wnu_count,
    
    -- 用户特征
    COALESCE(ugm.us_user, 0) AS us_user,
    COALESCE(ugm.non_us_user, 0) AS non_us_user,
    COALESCE(ugm.android_user, 0) AS android_user,
    COALESCE(ugm.ios_user, 0) AS ios_user,
    COALESCE(gd.male_user_cnt, 0) AS male_user_cnt,
    COALESCE(gd.female_user_cnt, 0) AS female_user_cnt,
    
    
    -- 行为特征
    COALESCE(cfd.search_uv, 0) AS search_uv,
    COALESCE(cfd.try_on_uv, 0) AS try_on_uv,
    COALESCE(cfd.search_pv, 0) AS search_pv,
    COALESCE(cfd.try_on_pv, 0) AS try_on_pv,
    COALESCE(ugm.login_user_cnt, 0) AS login_user_cnt,
    
    -- 业务指标
    COALESCE(ic.install_cnt, 0) AS install_cnt,
    COALESCE(c.cost, 0.0) AS cost,
    
    -- 留存指标（初始化为NULL，后续通过UPDATE更新）
    NULL AS d1_retention_cnt,
    NULL AS d1_to_d7_retention_cnt,
    NULL AS w1_retention_cnt,
    
    -- 元数据
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at

FROM (SELECT dt_param AS dt) base
LEFT JOIN user_general_metrics ugm ON ugm.dt = dt_param
LEFT JOIN gender_data gd ON gd.dt = dt_param
LEFT JOIN core_function_data cfd ON cfd.dt = dt_param
LEFT JOIN mau m ON m.report_date = dt_param
LEFT JOIN wnu w ON w.dt = dt_param
LEFT JOIN install_cnt ic ON ic.dt = dt_param
LEFT JOIN cost c ON c.dt = dt_param
```

---

**文档生成**: 2026-01-30 13:39:26
**扫描工具**: scan_functions.py
