# dws_favie_gem_sku_search_cube_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_sku_search_cube_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-08
**最后更新**: 2025-10-08

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
with dwd_favie_gem_product_search as (
    select 
        trace_id,

        device_id,
        user_type,
        is_internal_user,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,
        appsflyer_id,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,

        product_sku_id,
        product_site as product_site,
        coalesce(product_shop_site,product_site) as product_shop_site,
        product_cate_tag,
        product_title,
        product_link,
        product_image_link,
        product_price_raw,
        -- product_score,
        gem_search_timestamp,
        moodboard_id,
        -- moodboard_seq,
        dt
    from favie_dw.dwd_favie_gem_product_search_inc_1d 
    where dt = dt_param
        and search_engine = "ha3"
        and coalesce(is_internal_user,false) = false
  )

  --1个商品可能属于多个moodboard，所以计算召回和gem return的时候需要根据trace_id+product_id去重
  select 
    user_type,
    user_login_type,
    user_tenure_type,
    country_name,
    platform,
    app_version,
    ad_source,
    ad_campaign_id,
    ad_group_id,
    ad_id, 

    product_site,
    product_shop_site,
    product_sku_id,
    STRING_AGG(distinct product_cate_tag,",") as product_cate_tag,
    product_title,
    product_link,
    product_image_link,

    STRING_AGG(distinct product_price_raw,",") as product_price_raw,
    -- count(product_sku_id) as product_recall_cnt,
    -- count(distinct concat(device_id,product_sku_id)) as product_recall_user_uniq_cnt,
    -- count(distinct if(product_score >= 0,concat(trace_id,product_sku_id),null)) as product_valid_recall_cnt,
    -- count(distinct if(product_score >= 0,concat(device_id,product_sku_id),null)) as product_valid_recall_user_uniq_cnt,
    count(distinct if(gem_search_timestamp is not null,concat(trace_id,product_sku_id),null)) as product_gem_return_cnt,
    count(distinct if(gem_search_timestamp is not null,concat(device_id,product_sku_id),null)) as product_gem_return_user_uniq_cnt,
    count(distinct if(moodboard_id is not null,concat(trace_id,product_sku_id),null)) as product_moodboard_cnt,
    count(distinct if(moodboard_id is not null,concat(device_id,product_sku_id),null)) as product_moodboard_user_uniq_cnt,
    -- count(distinct if(moodboard_seq = 1,concat(trace_id,product_sku_id),null)) as product_first_moodboard_cnt,
    -- count(distinct if(moodboard_seq = 1,concat(device_id,product_sku_id),null)) as product_first_moodboard_user_uniq_cnt,
    dt
  from dwd_favie_gem_product_search
  group by dt,
    user_type,
    user_login_type,
    user_tenure_type,
    country_name,
    platform,
    app_version,
    ad_source,
    ad_campaign_id,
    ad_group_id,
    ad_id,
    
    product_site,
    product_shop_site,
    product_sku_id,
    product_title,
    product_link,
    product_image_link
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
