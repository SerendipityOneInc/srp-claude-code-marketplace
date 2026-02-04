WITH earn_records as (
            select 
                  dt,
                  user_id,
                  device_id,
                  earn_id,
                  earn_type,
                  earn_point_type,
                  earn_points,
                  earn_time
            from favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d
            where dt = dt_param
      ),
      consume_records as (
            select 
                  dt,
                  user_id,
                  device_id,
                  consume_id,
                  consume_type,
                  consume_points,
                  consume_status,
                  consume_time
            from favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d
            where dt = dt_param
      ),

      hit_limit_records as (
            select 
                  user_id,
                  device_id,
                  refer,
                  ap_name,
                  event_name,
                  event_method,
                  event_timestamp,
                  event_uuid,
            from favie_dw.dwd_favie_gensmo_events_inc_1d
            where dt = dt_param
            and refer = 'out_of_credits_popup'
            and event_method = 'page_view'
      ),

      membership_process_records as (
            select 
                  dt,
                  user_id,
                  device_id,
                  earn_id as process_node_id,
                  "earn" as process_node_name,
                  earn_type as process_node_type,
                  earn_points as process_node_points,
                  earn_point_type as process_node_point_type,
                  null as process_node_status,
                  earn_time as process_node_time,
                  earn_point_type
            from earn_records
            union all
            select 
                  dt,
                  user_id,
                  device_id,
                  consume_id as process_node_id,
                  "consume" as process_node_name,
                  consume_type as process_node_type,
                  consume_points as process_node_points,
                  null as process_node_point_type,
                  consume_status as process_node_status,
                  consume_time as process_node_time,
                  null as earn_point_type
            from consume_records
            union all
            select 
                  dt_param as dt,
                  user_id,
                  device_id,
                  event_uuid as process_node_id,
                  "hit_limit" as process_node_name,
                  null as process_node_type,
                  null as process_node_points,
                  null as process_node_point_type,
                  null as process_node_status,
                  event_timestamp as process_node_time,
                  null as earn_point_type
            from hit_limit_records
      ),

      membership_process_records_with_seq as (
            select 
                  dt,
                  user_id,
                  device_id,
                  process_node_id,
                  process_node_name,
                  process_node_type,
                  process_node_points,
                  process_node_point_type,
                  process_node_status,
                  process_node_time,
                  sum(if(process_node_name in ('hit_limit',"consume"),1,0)) over (partition by user_id order by process_node_time) as earn_source_seq
            from membership_process_records
      ),

      membership_process_records_with_earn_group as (
            select 
                  dt,
                  user_id,
                  device_id,
                  process_node_id,
                  process_node_name,
                  process_node_type,
                  process_node_points,
                  process_node_point_type,
                  process_node_status,
                  process_node_time,
                  earn_source_seq,
                  first_value(process_node_name) over (partition by user_id,earn_source_seq order by process_node_time) as earn_group_type
            from membership_process_records_with_seq
      )

      select 
            dt,
            user_id,
            device_id,
            process_node_id,
            process_node_name,
            process_node_type,
            process_node_points,
            process_node_point_type,
            process_node_status,
            process_node_time,
            earn_source_seq as earn_seq,
            earn_group_type as earn_group
      from membership_process_records_with_earn_group