# dws_favie_gensmo_feed_bysource_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-08-20
**最后更新**: 2025-08-20

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
begin
    DELETE FROM favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d (
        dt
        --User Info
        ,platform
        ,app_version
        ,country_name
        ,user_login_type
        ,user_tenure_type
        ,user_group
        ,device_id

        --event info      
        ,refer
        ,ap_name
        ,event_name
        ,event_method
        ,event_action_type
        ,event_source

        --feed info
        ,item_type
        ,item_intention
        ,feed_source

        --home
        ,home_pv_cnt
        ,home_device_id

        --feed item list
        ,feed_item_list_pv_cnt
        ,feed_item_list_device_id

        --feed item view
        ,feed_item_view_pv_cnt
        ,feed_item_view_device_id

        --feed click
        ,feed_item_click_cnt
        ,feed_item_click_device_id

        --feed detail
        ,feed_detail_click_cnt
        ,feed_item_tryon_click_cnt
        ,feed_item_remix_click_cnt
        ,feed_item_save_share_click_cnt
        ,feed_item_product_click_cnt     
        ,feed_item_detail_pv_cnt
        ,feed_item_detail_click_device_id

        --product detail
        ,feed_product_detail_click_cnt
        ,feed_product_detail_pv_cnt
        ,feed_product_detail_device_id
    )
    SELECT
        dt
        --User Info
        ,platform
        ,app_version
        ,country_name
        ,user_login_type
        ,user_tenure_type
        ,user_group
        ,device_id

        --event info      
        ,refer
        ,ap_name
        ,event_name
        ,event_method
        ,event_action_type
        ,event_source

        --feed info
        ,item_type
        ,item_intention
        ,feed_source

        --home
        ,home_pv_cnt
        ,home_device_id

        --feed item list
        ,feed_item_list_pv_cnt
        ,feed_item_list_device_id

        --feed item view
        ,feed_item_view_pv_cnt
        ,feed_item_view_device_id

        --feed click
        ,feed_item_click_cnt
        ,feed_item_click_device_id

        --feed detail
        ,feed_detail_click_cnt
        ,feed_item_tryon_click_cnt
        ,feed_item_remix_click_cnt
        ,feed_item_save_share_click_cnt
        ,feed_item_product_click_cnt     
        ,feed_item_detail_pv_cnt
        ,feed_item_detail_click_device_id

        --product detail
        ,feed_product_detail_click_cnt
        ,feed_product_detail_pv_cnt
        ,feed_product_detail_device_id
    FROM favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d_function(
        dt_param
    );   
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
