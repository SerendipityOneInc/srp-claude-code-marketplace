# dwd_favie_decofy_subscription_process_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_process_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-15
**最后更新**: 2025-10-15

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
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
