# dws_gensmo_prod_base_user_group_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_prod_base_user_group_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-11-07
**最后更新**: 2025-11-07

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
- `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` (dim_gem_user_replica_view)

---

## 💻 函数定义

```sql
WITH refer_base_data AS (
        SELECT 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            COALESCE(event_method, 'unknown') AS event_method,
            COALESCE(event_action_type, 'unknown') AS event_action_type,
            event_timestamp,
            event_ab_infos,
            event_version
        FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 7 DAY) AND dt_param
            AND event_version IS NOT NULL
            AND event_version = '1.0.0'
            and refer_group = 'valid'
    ),

    refer_item_base_data AS (
        SELECT 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            COALESCE(event_method, 'unknown') AS event_method,
            COALESCE(event_action_type, 'unknown') AS event_action_type,
            event_timestamp,
            event_version,
            event_item.item_type AS item_type
        FROM favie_dw.dwd_favie_gensmo_events_items_inc_1d
        WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 7 DAY) AND dt_param
            AND event_version is not null
            AND event_version = '1.0.0'
            AND refer_group = 'valid'
    ),

    ab_base as (
        SELECT DISTINCT 
            t1.dt, 
            t2.project,
            t2.router,
            t2.unique_id,
            t1.device_id
        FROM (SELECT 
                DISTINCT dt_param AS dt, 
                SAFE_CAST(ab_unique_id AS INT64) AS ab_unique_id, 
                device_id
            FROM refer_base_data, UNNEST(event_ab_infos) AS ab_unique_id
            WHERE TRIM(COALESCE(ab_unique_id, '')) != '' 
                and dt = dt_param
        )  t1 LEFT JOIN favie_dw.dim_gem_user_ab_config_view t2
        ON t1.ab_unique_id = t2.unique_id
    ),

    ab_valid as (
        select 
            dt,
            project,
            count(distinct concat(router,unique_id)) as router_count
        FROM ab_base
        GROUP BY dt, project
        HAVING router_count > 1
    ),

    user_other_groups AS (        
        SELECT DISTINCT dt_param AS dt, 'collage_gen_request' AS user_group, device_id
        FROM refer_base_data
        WHERE event_action_type = 'collage_gen_request'
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'feed_detail' AS user_group, device_id
        FROM refer_base_data
        WHERE refer = 'feed_detail'
            AND event_name = 'select_item'
            AND event_method = 'page_view'
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'tryon(trigger)' AS user_group, device_id
        FROM refer_base_data
        WHERE event_action_type in ('try_on_trigger','tryon')
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'product_save' AS user_group, device_id
        FROM refer_item_base_data
        WHERE event_action_type = 'save'
            AND item_type = 'product'
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'collage_save' AS user_group, device_id
        FROM refer_item_base_data
        WHERE event_action_type = 'save'
            AND item_type IN ('similar_collage', 'general_collage')
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'tryon_save' AS user_group, device_id
        FROM refer_item_base_data
        WHERE event_action_type = 'save'
            AND item_type = 'try_on_collage'
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'product_detail' AS user_group, device_id
        FROM refer_base_data
        WHERE refer IN ('product_detail', 'pseudo_product_detail', 'product_search_detail', 'product_detail_from_search')
            AND event_name = 'select_item'
            AND event_method = 'page_view'
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'product_export' AS user_group, device_id
        FROM refer_base_data
        WHERE refer IN ('product_detail', 'pseudo_product_detail', 'product_search_detail', 'product_detail_from_search')
            AND ap_name = 'ap_product_card'
        
        UNION ALL
        
        SELECT DISTINCT t1.dt, 
            'ab_' || t1.project || '@' || t1.router || '@' || t1.unique_id AS user_group,
            t1.device_id
        FROM ab_base t1
        LEFT JOIN ab_valid t2
        ON t1.project = t2.project and t1.dt = t2.dt
        where t2.project is not null
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'replica' AS user_group, t2.device_id
        FROM srpproduct-dc37e.favie_dw.dim_gem_user_replica_view t1
        LEFT JOIN favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d  t2
        ON t1.user_id = t2.user_id and t2.dt = dt_param

        UNION ALL

        SELECT
            distinct dt_param as dt, 'poster' AS user_group,device_id
        from favie_dw.dws_gensmo_refer_general_metrics_inc_1d
        where dt = dt_param
            and data_name = 'refer_ap_click_cnt'
            and event_action_type = 'post'
            and data_value is not null
        group by device_id
        having sum(data_value) = 1  

        UNION ALL
           
        select 
            distinct dt_param as dt, 'creator' AS user_group,device_id
        from favie_dw.dws_gensmo_refer_general_metrics_inc_1d
        where dt = dt_param
            and data_name = 'refer_ap_click_cnt'
            and event_action_type = 'post'
            and data_value is not null
        group by device_id
        having sum(data_value) > 1 
    )

    SELECT 
        dt,
        user_group,
        device_id
    FROM user_other_groups
```

---

**文档生成**: 2026-01-30 13:42:37
**扫描工具**: scan_functions.py
