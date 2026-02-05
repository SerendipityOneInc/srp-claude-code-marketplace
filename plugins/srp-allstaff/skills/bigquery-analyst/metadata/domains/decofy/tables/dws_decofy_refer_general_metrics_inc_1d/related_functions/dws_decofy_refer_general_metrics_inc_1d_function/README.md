# dws_decofy_refer_general_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_decofy_refer_general_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-15
**最后更新**: 2025-09-15

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
with refer_base_data as (
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            coalesce(event_method,'unknown') as event_method,
            coalesce(event_action_type,'unknown') as event_action_type,
            event_timestamp,
            event_version,
            event_interval
        from favie_dw.dwd_favie_decofy_events_inc_1d
        where dt = dt_param
            and event_version = '1.0.0'
            and refer_group = 'valid'
            and coalesce(user_id,'unknown') != 'unknown'
    ),

    refer_ap_metric_data as (
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            "refer_ap_click_cnt" as data_name,
            count(1) as data_value
        from refer_base_data
        where event_name = 'select_item' 
            and event_method in ('swipe','click','shake','screenshot')
        group by 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type
    ),

    refer_view_item_list_data as (
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            "refer_view_item_list_cnt" as data_name,
            count(1) as data_value
        from refer_base_data
        where event_name = 'view_item_list' 
        group by 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type
    ),

    refer_true_view_data as (
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            "refer_true_view_cnt" as data_name,
            count(1) as data_value
        from refer_base_data
        where event_name = 'true_view' 
        group by 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type
    ),

    refer_pv_data as (
        select 
            dt,
            user_id,
            refer,
            'ap_screen' as ap_name,
            event_name,
            event_method,
            event_action_type,
            'refer_pv_cnt' as data_name,
            count(1) as data_value,
        from refer_base_data
        where event_name = 'select_item' 
        and event_method = 'page_view'
        group by 
            dt,
            user_id,
            refer,
            event_name,
            event_method,
            event_action_type         
    ),

    refer_leave_directly_data as (
        select 
            dt,
            user_id,
            refer,
            'ap_screen' as ap_name,
            'select_item' as event_name,
            'leave_directly' as event_method,
            'leave' as event_action_type,
            'refer_leave_directly_cnt' as data_name,
            if(countif(event_name = 'select_item' and event_method in ('swipe','click','shake','screenshot'))>0,0,1) as data_value,
        from refer_base_data
        group by 
            dt,
            user_id,
            refer
    ),

    refer_duration_data as (
        select 
            dt,
            user_id,
            refer,
            'ap_screen' as ap_name,
            'all_event' as event_name,
            'stay' as event_method,
            'stay' as event_action_type,
            'refer_duration_amount' as data_name,
            sum((if(event_interval<30000,event_interval,0)/1000)) as data_value
        from refer_base_data
        group by 
            dt,
            user_id,
            refer
    ),

    refer_all_data as (
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_ap_metric_data
        union all 
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_leave_directly_data
        union all
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_duration_data
        union all 
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_pv_data
        union all 
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_view_item_list_data
        union all 
        select 
            dt,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_true_view_data
    )

    SELECT
        dt,
        user_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
    FROM refer_all_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
