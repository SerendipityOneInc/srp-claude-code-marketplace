WITH mongo_gensmo_user_inc AS (
        SELECT  
            cast(uid as string) AS user_id,
            email AS user_email,
            name AS user_name,
            CASE WHEN is_active THEN 1 ELSE 2 END AS user_type,
            device_id,
            (select array_agg(struct(item as value))
              from unnest(device_ids) as item
            ) as device_ids, 
            device_ids[safe_offset(0)] AS first_device_id,
            updated_at,       
            created_at
        -- FROM `srpproduct-dc37e.favie_mongodb_integration_stitch3_v2.gem_account`   
        FROM `srpproduct-dc37e.favie_dw.dim_gem_account_view`   
        WHERE uid IS NOT NULL 
        and date(created_at) <= dt_param

        UNION ALL

        SELECT  
            cast(uid as string) AS user_id,
            CAST(NULL AS STRING) AS user_email,
            CAST(NULL AS STRING) AS user_name,
            0 AS user_type,
            device_id,
            CAST(NULL AS ARRAY<STRUCT<value STRING>>) AS device_ids,
            device_id AS first_device_id,
            updated_at,       
            created_at
        -- FROM `srpproduct-dc37e.favie_mongodb_integration_stitch3_v2.gem_unregister_account`
        FROM `srpproduct-dc37e.favie_dw.dim_gem_unregister_account_view`
        WHERE uid IS NOT NULL
            AND device_id IS NOT NULL -- 检查为何可能为空
            and date(created_at) <= dt_param
    ),



    user_replica_cnt AS (
        SELECT 
            user_id,
            COUNT(1) AS user_replica_cnt
        -- FROM favie_mongodb_integration_stitch3_v2.gem_user_replica
        FROM srpproduct-dc37e.favie_dw.dim_gem_user_replica_view
        GROUP BY user_id
    ),


user_inc_info as (
SELECT  user_id
       ,dt
       ,last_access_at
       ,last_platform
       ,last_app_version
       ,last_user_pseudo_id
       ,last_user_login_type
FROM
(
SELECT  user_id
       ,dt
       ,event_timestamp                                                      AS last_access_at
       ,platform                                                             AS last_platform
       ,app_version                                                          AS last_app_version
       ,user_pseudo_id                                                       AS last_user_pseudo_id
       ,user_login_type                                                      AS last_user_login_type
       ,rank() over(PARTITION BY user_id,dt ORDER BY  event_timestamp DESC ) AS rk
FROM favie_dw.dwd_favie_gensmo_events_inc_1d
where dt=dt_param
)
WHERE rk = 1 ) ,


user_duration_inc as (
SELECT  user_id
       ,dt
       ,array_agg(distinct device_id)                                  AS device_ids
       ,SUM(if(event_interval < 30000,event_interval,0))/1000 AS duration
FROM favie_dw.dwd_favie_gensmo_events_inc_1d
GROUP BY  user_id
,dt
),


mongo_user_info as (
      SELECT  user_id
            ,user_type
            ,user_email
      FROM mongo_gensmo_user_inc
      GROUP BY  user_id
              ,user_type
              ,user_email
),

internal_staff_info as (

select user_id,user_email
  from   `favie_dw.dim_favie_user_google_sheet_config_mut_view`
  group by user_id,user_email 
)


SELECT  a.user_id
       ,a.dt
       ,a.last_access_at
       ,a.last_platform
       ,a.last_app_version
       ,a.last_user_pseudo_id
       ,a.last_user_login_type
      ,b.device_ids       AS device_ids
      ,b.duration         AS duration
    ,c.user_type        AS user_type
    ,c.user_email as user_email 
    ,d.user_replica_cnt AS user_replica_cnt
    ,if(e.user_id is not null ,1,0) as is_internal
FROM user_inc_info a
LEFT JOIN user_duration_inc b
ON a.user_id = b.user_id and a.dt=b.dt
LEFT JOIN mongo_user_info c
ON a.user_id = c.user_id
LEFT JOIN user_replica_cnt d
ON a.user_id = d.user_id
left join internal_staff_info e 
on (cast(a.user_id as string) =cast(e.user_id as string) or c.user_email=e.user_email )