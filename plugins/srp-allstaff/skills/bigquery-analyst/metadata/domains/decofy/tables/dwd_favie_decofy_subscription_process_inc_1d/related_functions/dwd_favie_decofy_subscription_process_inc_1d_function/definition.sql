with trigger_pay_process as (
    select
      dt,
      user_id,
      'trigger_pay' as process_node,
      event_item.item_name as trigger_source,
      cast(null as string) as product_id,
      cast(null as string) as simple_product_id,
      cast(null as string) as order_id,
      cast(null as string) as  order_category,
      cast(null as string) as  order_type,
      cast(null as int64) as order_subscription_seq,
      cast(null as string) as subscription_id,
      event_timestamp as process_time
    from `favie_dw.dwd_favie_decofy_events_inc_1d`,unnest(event_items) event_item
    where dt = dt_param
    and event_action_type = 'trigger_pay'
    and event_item.item_type = 'trigger_reason'
  ),
  order_process as (
    select
      dt_param as dt,
      user_id,
      'order' as process_node,
      cast(null as string) as trigger_source,
      product_id,
      simple_product_id,
      order_id,
      order_category,
      order_type,
      order_subscription_seq,
      subscription_id,
      order_created_at as process_time
    from favie_dw.dwd_favie_decofy_subscription_order_full_1d 
    where dt = (select max(dt) from favie_dw.dwd_favie_decofy_subscription_order_full_1d )
    and date(order_created_at) = dt_param
  ),
  all_process_data as (
    select * from trigger_pay_process
    union all
    select * from order_process
  ),
  all_process_with_trigger_seq as (
    select 
      dt,
      user_id,
      process_node,
      trigger_source,
      product_id,
      simple_product_id,
      order_id,
      order_category,
      order_type,
      order_subscription_seq,
      subscription_id,
      process_time,
      sum(if(process_node = 'trigger_pay',1,0)) over (partition by user_id order by process_time) as trigger_pay_seq
    from all_process_data
  ),
  all_process_with_trigger_reason AS (
    select 
      dt,
      user_id,
      process_node,
      first_value(trigger_source ignore nulls) over (partition by user_id,trigger_pay_seq order by process_time)  as trigger_source,
      product_id,
      simple_product_id,
      order_id,
      order_category,
      order_type,
      order_subscription_seq,
      subscription_id,
      process_time,
      trigger_pay_seq
    from all_process_with_trigger_seq
  )
  select 
    dt,
    user_id,
    process_node,
    trigger_source,
    product_id,
    simple_product_id,
    order_id,
    order_category,
    order_type,
    order_subscription_seq,
    subscription_id,
    process_time,
    trigger_pay_seq
  from all_process_with_trigger_reason