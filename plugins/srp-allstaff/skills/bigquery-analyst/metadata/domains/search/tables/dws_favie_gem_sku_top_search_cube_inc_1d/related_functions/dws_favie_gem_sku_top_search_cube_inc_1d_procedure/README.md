# dws_favie_gem_sku_top_search_cube_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-09
**最后更新**: 2025-10-09

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
BEGIN
    DELETE FROM `favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d`
    WHERE dt = dt_param;

    INSERT INTO `favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d`(
        product_site,
        product_shop_site,
        user_type,
        country_name,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        product_sku_id,
        product_cate_tag,
        product_title,
        product_link,
        product_image_link,
        product_price_raw,
        product_gem_return_cnt,
        product_gem_return_user_uniq_cnt,
        product_moodboard_cnt,
        product_moodboard_user_uniq_cnt,
        dt
    )
    select 
        product_site,
        product_shop_site,
        user_type,
        country_name,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        product_sku_id,
        product_cate_tag,
        product_title,
        product_link,
        product_image_link,
        product_price_raw,
        product_gem_return_cnt,
        product_gem_return_user_uniq_cnt,
        product_moodboard_cnt,
        product_moodboard_user_uniq_cnt,
        dt
    from favie_dw.dws_favie_gem_sku_search_cube_inc_1d
    where dt = dt_param
    order by product_gem_return_cnt desc
    limit 500;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
