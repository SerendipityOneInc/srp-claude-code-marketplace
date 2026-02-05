# rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-17
**最后更新**: 2025-10-17

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
WITH core_function_data_with_new_user AS (
    SELECT
        dt,
        COUNT(DISTINCT CASE 
            WHEN event_action_type = 'collage_gen' AND b.user_tenure_type = 'New User' THEN a.device_id  
            ELSE NULL 
        END) AS new_user_search_uv,
        COUNT(DISTINCT CASE 
            WHEN event_action_type IN ('try_on', 'try_on_no_avatar','try_on_trigger') AND b.user_tenure_type = 'New User' THEN a.device_id 
            ELSE NULL 
        END) AS new_user_try_on_uv,
        COUNT(CASE 
            WHEN event_action_type = 'collage_gen' AND b.user_tenure_type = 'New User' THEN a.event_uuid 
            ELSE NULL 
        END) AS new_user_search_pv,
        COUNT(CASE 
            WHEN event_action_type IN ('try_on', 'try_on_no_avatar','try_on_trigger') AND b.user_tenure_type = 'New User' THEN a.event_uuid 
            ELSE NULL 
        END) AS new_user_try_on_pv
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d` a
    LEFT JOIN (
        SELECT device_id, user_tenure_type 
        FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` 
        WHERE dt = dt_param 
    ) b ON a.device_id = b.device_id
    WHERE b.device_id IS NOT NULL
    AND refer_group = "valid"
    AND event_version = "1.0.0"
    AND dt = dt_param
    GROUP BY dt
),

login_new_user_cnt AS ( 
    SELECT 
        dt,
        COUNT(DISTINCT CASE WHEN user_tenure_type='New User' AND last_day_feature.login_type='login' THEN device_id ELSE NULL END) AS login_new_user_cnt
    FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
    WHERE dt = dt_param
    GROUP BY dt
)
-- 汇总所有指标
SELECT 
    dt_param AS dt,
    
    -- 新用户行为指标（当天计算）
    COALESCE(cfn.new_user_search_uv, 0) AS new_user_search_uv,
    COALESCE(cfn.new_user_try_on_uv, 0) AS new_user_try_on_uv,
    COALESCE(cfn.new_user_search_pv, 0) AS new_user_search_pv,
    COALESCE(cfn.new_user_try_on_pv, 0) AS new_user_try_on_pv,
    COALESCE(lnu.login_new_user_cnt, 0) AS login_new_user_cnt,
    
    -- 登录用户留存指标（初始化为NULL，后续通过UPDATE更新）
    NULL AS login_d1_retention_cnt,
    NULL AS login_d1_to_d7_retention_cnt,
    NULL AS login_w1_retention_cnt,
    
    -- 元数据
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at

FROM (SELECT dt_param AS dt) base
LEFT JOIN core_function_data_with_new_user cfn ON cfn.dt = dt_param
LEFT JOIN login_new_user_cnt lnu ON lnu.dt = dt_param
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
