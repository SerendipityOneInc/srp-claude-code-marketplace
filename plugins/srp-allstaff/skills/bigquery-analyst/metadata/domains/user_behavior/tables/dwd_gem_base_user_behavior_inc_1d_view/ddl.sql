CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_base_user_behavior_inc_1d_view`
AS select        
            event_name
	       ,event_date
	       ,stream_id
	       ,is_active_user
	       ,user_pseudo_id
	       ,event_time
	       ,event_timestamp
	       ,operating_system
	       ,items
	       ,timestamp_offset
	       ,ga_app_version
	       ,country
	       ,city
	       ,region
	       ,metro
	       ,sub_continent
	       ,continent
	       ,geo
	       ,engagement_time_sec
	       ,user_id
	       ,item_id
	       ,number
	       ,round
	       ,refer
	       ,if_preference
	       ,utm_source
	       ,query_id
	       ,app_version
	       ,platform
	       ,engagement_platform
	       ,click_src
	       ,input_type
	       ,item_list_name
	       ,action_type
	       ,search_term
	       ,method
	       ,creative_name
	       ,promotion_name
	       ,item_name
	       ,user_type
	       ,gensmo_active_id
	       ,ga_session_id
	       ,query_session_id
	       ,ab_infos
	       ,item_list_id
	       ,dt
             ,if(item_list_name in ('entity_list','collage_shop','entity_option_list'),item_id,null) as sku_id
             ,case 
                  when  event_name='search' and input_type='user_text_only' and click_src !='default_query'       then 'undefault_search_text_only'
                  when  event_name='search' and input_type='user_text_only' and click_src='default_query'         then 'default_search_text_only'
                  when  event_name='search' and input_type='user_pic_only' and click_src !='default_query'        then 'search_pic_only'
                  when  event_name='search' and input_type='user_text_pic' and click_src !='default_query'        then 'search_text_pic' 
            end as search_query_type
                  
from (
      SELECT 
            event_name,
            FORMAT_DATE('%Y-%m-%d', PARSE_DATE('%Y%m%d', event_date)) as event_date,
            stream_id,
            is_active_user,
            user_pseudo_id,
            DATETIME(TIMESTAMP_MICROS(event_timestamp)) AS event_time,
            event_timestamp,
            -- operating_system
            device.operating_system,
            items,
            event_server_timestamp_offset as timestamp_offset,
            -- other version 
            app_info.version as ga_app_version,
            geo.country as country,
            geo.city as city,
            geo.region as region,
            geo.metro as metro,
            geo.sub_continent as sub_continent,
            geo.continent as continent,
            geo,
            (SELECT element.value.int_value 
                  FROM UNNEST(event_params.list) 
                  WHERE element.key = 'engagement_time_msec') * 1000 AS engagement_time_sec,
            -- Calculate user_id based on platform and event_params
            CASE
                  WHEN (SELECT element.value.string_value 
                        FROM UNNEST(event_params.list) 
                        WHERE element.key = 'platform') != 'app' 
                  THEN CAST(user_id AS INT64)  -- Force user_id to INT64 when platform is not 'app'
                  ELSE (SELECT element.value.int_value 
                        FROM UNNEST(event_params.list) 
                        WHERE element.key = 'user_id')  -- Use user_id from event_params when platform is 'app'
            END AS user_id,
            -- item_id
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'item_id') AS item_id,
            -- number
            (SELECT element.value.int_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'number')  as `number`,

            (SELECT element.value.int_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'round')  as `round`,
            
            
            -- refer
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'refer') AS refer,
      
                  -- if_preference
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'if_preference') AS if_preference,
            
            -- utm_source
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'utm_source') AS utm_source,
            
            -- query_id
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'query_id') AS query_id,

            -- version
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'version') AS app_version,

            -- platform
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'platform') AS platform,
            
            case 
            when platform='IOS' AND device.category='mobile' then 'app'
            when platform='WEB' and device.category='mobile' then 'mobile-web'
            when platform='IOS' and device.category='tablet' then 'app' 
            when platform='WEB' and device.category='desktop' then 'pc-web'
            when platform='WEB' and device.category='tablet' then 'mobile-web'
            end as engagement_platform,
            
            -- click_src
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'click_src') AS click_src,
            
            -- input_type
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'input_type') AS input_type,
            
            -- item_list_name
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'item_list_name') AS item_list_name,
            
            -- action_type
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'action_type') AS action_type,
            
            -- search_term
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'search_term') AS search_term,
            
            -- method
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'method') AS method,
            
            -- creative_name
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'creative_name') AS creative_name,

            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'promotion_name') AS promotion_name,
            -- item_name
            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'item_name') AS item_name,
      
            -- Calculate user_type based on calculated user_id
            CASE 
            WHEN 
                  -- If user_id (calculated) is NULL or 0, then 'guest'
                  (CASE
                  WHEN (SELECT element.value.string_value 
                        FROM UNNEST(event_params.list) 
                        WHERE element.key = 'platform') != 'app' 
                  THEN CAST(user_id AS INT64)  -- Force user_id to INT64 when platform is not 'app'
                  ELSE (SELECT element.value.int_value 
                        FROM UNNEST(event_params.list) 
                        WHERE element.key = 'user_id')  -- Use user_id from event_params when platform is 'app'
                  END) IS NULL 
            OR (CASE
                  WHEN (SELECT element.value.string_value 
                        FROM UNNEST(event_params.list) 
                        WHERE element.key = 'platform') != 'app' 
                  THEN CAST(user_id AS INT64)  -- Force user_id to INT64 when platform is not 'app'
                  ELSE (SELECT element.value.int_value 
                        FROM UNNEST(event_params.list) 
                        WHERE element.key = 'user_id')  -- Use user_id from event_params when platform is 'app'
                  END) = 0 
            THEN 'guest'   -- If calculated user_id is NULL or 0, set user_type to 'guest'
            ELSE 'login'   -- Otherwise, set user_type to 'login'
            END AS user_type,

            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'gensmo_active_id') as gensmo_active_id,

            (SELECT element.value.int_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'ga_session_id') as ga_session_id,

            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'query_session_id') as query_session_id,

            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'ab_info') as ab_infos,

            (SELECT element.value.string_value 
            FROM UNNEST(event_params.list) 
            WHERE element.key = 'item_list_id') as item_list_id,
            
            Date(FORMAT_DATE('%Y-%m-%d', PARSE_DATE('%Y%m%d', event_date))) as dt
            
            FROM
            `srpproduct-dc37e.ga_analytics.events_intraday`
            WHERE stream_id IN ('8576715039', '9998456869')

            
            

      );