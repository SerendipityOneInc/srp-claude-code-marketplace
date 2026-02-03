# dws_gem_user_last_access_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_user_last_access_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-23
**最后更新**: 2025-09-23

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
WITH user_last_access AS (
        SELECT 
            device_id,
            MAX(dt) AS last_access_date
        FROM `favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt <= dt_param
            AND device_id IS NOT NULL
        GROUP BY device_id
    )
    
    SELECT 
        base.dt AS last_access_date,
        base.device_id,
        base.first_device_id,
        base.appsflyer_id,
        base.is_internal_user,
        base.user_type,
        base.user_tenure_type,
        base.created_at,
        
        -- 最后一天的完整特征信息
        base.last_day_feature,
        base.last_30_days_feature,
        
        CURRENT_TIMESTAMP() AS updated_at
    FROM `favie_dw.dws_favie_gensmo_user_feature_inc_1d` base
    INNER JOIN user_last_access ula
        ON base.device_id = ula.device_id
        AND base.dt = ula.last_access_date
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
