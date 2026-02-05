# dim_favie_gensmo_user_account_changelog_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-08-15
**最后更新**: 2025-08-15

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
    -- merge from dim_gem_account_view and dim_gem_unregister_account_view using last 3 days data
    DECLARE n_day int64 default 2;
    MERGE favie_dw.dim_favie_gensmo_user_account_changelog_1d AS target
    USING (
        WITH mongo_gensmo_user_account_inc AS (
            SELECT  
                SAFE_CAST(uid AS STRING) AS user_id,
                name AS user_name,
                email AS user_email,
                CASE WHEN is_active THEN 1 ELSE 2 END AS user_type,
                device_id AS last_device_id,
                device_ids, 
                device_ids[SAFE_OFFSET(0)] AS first_device_id,
                false as is_internal_user,
                updated_at,       
                created_at
            FROM `srpproduct-dc37e.favie_dw.dim_gem_account_view`   
            WHERE uid IS NOT NULL 
                AND ( 
                    DATE(created_at) >= DATE_SUB(dt_param, INTERVAL n_day DAY) AND DATE(created_at) <= dt_param 
                    OR DATE(updated_at) >= DATE_SUB(dt_param, INTERVAL n_day DAY) AND DATE(updated_at) <= dt_param
                )

            UNION ALL

            SELECT  
                SAFE_CAST(uid AS STRING) AS user_id,
                SAFE_CAST(NULL AS STRING) AS user_name,
                SAFE_CAST(NULL AS STRING) AS user_email,
                0 AS user_type,
                device_id AS last_device_id,
                ARRAY[device_id] AS device_ids,
                device_id AS first_device_id,
                false as is_internal_user,
                updated_at,       
                created_at
            FROM `srpproduct-dc37e.favie_dw.dim_gem_unregister_account_view`
            WHERE uid IS NOT NULL
                AND device_id IS NOT NULL 
                AND ( 
                    DATE(created_at) >= DATE_SUB(dt_param, INTERVAL n_day DAY) AND DATE(created_at) <= dt_param 
                    OR DATE(updated_at) >= DATE_SUB(dt_param, INTERVAL n_day DAY) AND DATE(updated_at) <= dt_param
                )
        )
        SELECT * FROM mongo_gensmo_user_account_inc
    ) AS source
    ON target.user_id = source.user_id
    WHEN MATCHED THEN
        UPDATE SET
            target.process_date = dt_param,
            target.updated_at = source.updated_at,
            target.user_name = source.user_name,
            target.device_ids = source.device_ids
    WHEN NOT MATCHED THEN
        INSERT (process_date, updated_at, created_at, user_id, first_device_id, last_device_id, user_name, user_email, user_type, device_ids, is_internal_user)
        VALUES (dt_param, source.updated_at, source.created_at, source.user_id, source.first_device_id, source.last_device_id, source.user_name, source.user_email, source.user_type, source.device_ids, source.is_internal_user);

    -- merge from dwd_favie_gensmo_events_inc_1d by device_id using last day data
    MERGE favie_dw.dim_favie_gensmo_user_account_changelog_1d AS target
    USING (
        WITH event_user_info_by_device_id_based as (
            SELECT 
                device_id,
                appsflyer_id,
                event_timestamp,
                if(coalesce(platform,app_version) is null, null, struct(
                    platform,
                    app_version
                )) as app_info,
                if(coalesce(geo_continent_name,geo_sub_continent_name,geo_country_name,geo_region_name,geo_metro_name,geo_city_name) is null ,null,struct(
                    geo_continent_name,
                    geo_sub_continent_name,
                    geo_country_name,
                    geo_region_name,
                    geo_metro_name,
                    geo_city_name
                )) as geo_address
            FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
            WHERE dt >= DATE_SUB(dt_param, INTERVAL n_day DAY) AND dt <= dt_param 
                and device_id is not null   
        ),
            
        event_user_info_by_device_id as (
            SELECT 
                device_id,
                first_value(appsflyer_id) over (partition by device_id order by if(appsflyer_id is not null,0,1), event_timestamp) as appsflyer_id,
                first_value(app_info) over (partition by device_id order by if(app_info is not null,0,1), event_timestamp) as app_info,
                first_value(geo_address) over (partition by device_id order by if(geo_address is not null,0,1), event_timestamp) as geo_address,
                row_number() over (partition by device_id order by event_timestamp) as rn
            FROM event_user_info_by_device_id_based
        )
        SELECT * FROM event_user_info_by_device_id WHERE rn = 1
    ) AS source
    ON target.first_device_id = source.device_id
    WHEN MATCHED THEN
    UPDATE SET
        target.process_date = dt_param,

        target.first_device_id = coalesce(source.device_id, target.first_device_id),
        target.last_device_id = source.device_id,
        target.appsflyer_id = coalesce(source.appsflyer_id, target.appsflyer_id),

        target.geo_address = coalesce(source.geo_address, target.geo_address),   
        target.app_info = IF(DATE(target.created_at) >= DATE_SUB(dt_param, INTERVAL n_day DAY) and DATE(target.created_at) <= dt_param, source.app_info, target.app_info)
        ;

    -- merge from dwd_favie_gensmo_events_inc_1d by user_id using last day data
    MERGE favie_dw.dim_favie_gensmo_user_account_changelog_1d AS target
    USING (
        with event_user_info_by_user_id_based as (
            SELECT 
                user_id,
                appsflyer_id,
                device_id,
                event_timestamp,
                if(coalesce(platform,app_version) is null , null,struct(
                    platform,
                    app_version
                )) as app_info,
                if(coalesce(geo_continent_name,geo_sub_continent_name,geo_country_name,geo_region_name,geo_metro_name,geo_city_name) is null ,null,struct(
                    geo_continent_name,
                    geo_sub_continent_name,
                    geo_country_name,
                    geo_region_name,
                    geo_metro_name,
                    geo_city_name
                )) as geo_address
            FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
            WHERE dt >= DATE_SUB(dt_param, INTERVAL n_day DAY) AND dt <= dt_param 
                and user_id is not null
                and REGEXP_CONTAINS(user_id, r'^[0-9]+$') 
                and device_id is not null             
        ),
        
        event_user_info_by_user_id as (
            SELECT 
                user_id,
                first_value(appsflyer_id) over (partition by user_id order by if(appsflyer_id is not null,0,1), event_timestamp) as appsflyer_id,
                first_value(app_info) over (partition by user_id order by if(app_info is not null,0,1), event_timestamp) as app_info,
                first_value(geo_address) over (partition by user_id order by if(geo_address is not null,0,1), event_timestamp) as geo_address,
                first_value(device_id) over (partition by user_id order by if(device_id is not null,0,1), event_timestamp) as first_device_id,
                first_value(device_id) over (partition by user_id order by if(device_id is not null,0,1), event_timestamp desc) as last_device_id,
                row_number() over (partition by user_id order by event_timestamp) as rn
            FROM event_user_info_by_user_id_based   
        )
        SELECT * FROM event_user_info_by_user_id WHERE rn = 1
    ) AS source
    ON target.user_id = source.user_id
    WHEN MATCHED THEN
    UPDATE SET
        target.process_date = dt_param,

        target.first_device_id = coalesce(source.first_device_id, target.first_device_id),
        target.last_device_id = source.last_device_id,
        target.appsflyer_id = coalesce(source.appsflyer_id, target.appsflyer_id),

        target.geo_address = coalesce(source.geo_address, target.geo_address),
        target.app_info = IF(DATE(target.created_at) >= DATE_SUB(dt_param, INTERVAL n_day DAY) and DATE(target.created_at) <= dt_param, source.app_info, target.app_info)
        ;


    UPDATE favie_dw.dim_favie_gensmo_user_account_changelog_1d AS target
    SET target.is_internal_user = TRUE
    WHERE target.user_id IN (
        SELECT SAFE_CAST(source.user_id AS STRING)
        FROM srpproduct-dc37e.favie_dw.dim_starquest_internal_user_view AS source
    );

    UPDATE favie_dw.dim_favie_gensmo_user_account_changelog_1d AS target
    SET target.is_internal_user = TRUE
    WHERE target.user_email IN (
        SELECT source.user_email
        FROM srpproduct-dc37e.favie_dw.dim_starquest_internal_user_view AS source
    );

    UPDATE favie_dw.dim_favie_gensmo_user_account_changelog_1d AS target
    SET target.is_internal_user = TRUE
    WHERE target.first_device_id IN (
        SELECT source.device_id
        FROM srpproduct-dc37e.favie_dw.dim_starquest_internal_user_view AS source
    );

    UPDATE favie_dw.dim_favie_gensmo_user_account_changelog_1d AS target
    SET target.is_internal_user = TRUE
    WHERE target.last_device_id IN (
        SELECT source.device_id
        FROM srpproduct-dc37e.favie_dw.dim_starquest_internal_user_view AS source
    );
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
