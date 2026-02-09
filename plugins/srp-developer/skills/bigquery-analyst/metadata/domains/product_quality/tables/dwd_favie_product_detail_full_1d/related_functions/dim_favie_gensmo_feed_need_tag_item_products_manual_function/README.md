# dim_favie_gensmo_feed_need_tag_item_products_manual_function

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_need_tag_item_products_manual_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: dimension
**语言**: SQL
**创建时间**: 2025-10-27
**最后更新**: 2025-10-27

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

- `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d` (dwd_favie_product_detail_full_1d)

---

## 💻 函数定义

```sql
with favie_gensmo_feed_item_explode as (
      select 
        feed_type,
        task_id,
        moodboard_id,
        moodboard_image_url,
        query,
        reasoning,
        title,
        `description`,
        gender,
        tags,
        score,
        is_feed,
        json_extract_scalar(product,"$.search_engine") as search_engine,
        json_extract_scalar(product,"$.global_id") as f_sku_id,
        product,  
        created_time,
        update_time
      from favie_dw.dim_favie_gensmo_feed_need_tag_item_manual_function('2025-09-01','2025-10-30')
      left outer join unnest(products) as product
    ),

    feed_product_sku_ids as (
      select 
        distinct f_sku_id 
      from favie_gensmo_feed_item_explode
    ),

    favie_product_info as (
      select 
        f_sku_id,
        title as product_title,
        coalesce(feature_bullets,description) as product_description,
        
        (
          SELECT STRING_AGG(json_extract_scalar(item,'$.name'), ' > ')
          FROM UNNEST(json_extract_array(f_categories)) AS item
        ) as product_categories,
      
        json_extract_scalar(brand,"$.name") as product_brand
      from `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d`
      where dt = format_date("%Y-%m-%d",dt_param)
    ),

    favie_gensmo_feed_item_with_product_info as (
      select 
        t1.feed_type,
        t1.task_id,
        t1.moodboard_id,
        t1.moodboard_image_url,
        t1.query,
        t1.reasoning,
        t1.title,
        t1.`description`,
        t1.gender,
        t1.tags,
        t1.score,
        t1.is_feed,
        t1.search_engine,
        t1.f_sku_id,
        t2.product_title,
        t2.product_description,
        t2.product_categories,
        t2.product_brand,
        t1.created_time,
        t1.update_time      
      from favie_gensmo_feed_item_explode t1 
      left outer join favie_product_info t2
      on t1.f_sku_id = t2.f_sku_id
    ),

    taged_feed_items as (
      select 
        distinct moodboard_id
      from (
        select 
          moodboard_id
        from favie_dw.dwd_gem_feed_moodboard_tag_inc_1hour_view
        where dt is not null
        union all
        select
          moodboard_id
        from favie_dw.dwd_gem_feed_tags_source_full_view
      )
    )

    select 
      feed_type,
      task_id,
      moodboard_id,
      moodboard_image_url,
      query,
      reasoning,
      title,
      `description`,
      gender,
      tags,
      score,
      is_feed,
      search_engine,
      f_sku_id,
      product_title,
      product_description,
      product_categories,
      product_brand,
      created_time,
      update_time
    from favie_gensmo_feed_item_with_product_info
```

---

**文档生成**: 2026-01-30 13:40:34
**扫描工具**: scan_functions.py
