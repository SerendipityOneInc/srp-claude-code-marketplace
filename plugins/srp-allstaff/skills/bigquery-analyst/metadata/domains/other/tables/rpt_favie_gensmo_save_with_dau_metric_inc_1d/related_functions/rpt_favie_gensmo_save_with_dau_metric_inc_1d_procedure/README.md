# rpt_favie_gensmo_save_with_dau_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_save_with_dau_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-11
**最后更新**: 2025-07-11

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
    DELETE FROM favie_rpt.rpt_favie_gensmo_save_with_dau_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_save_with_dau_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,

        --app
        active_user_d1_cnt,

        --total
        total_save_click_cnt,
        total_save_click_user_cnt,

        --feed detail
        feed_detail_user_cnt,
        feed_detail_save_click_cnt,
        feed_detail_save_click_user_cnt,
        feed_item_similar_save_click_cnt,
        feed_item_similar_save_click_user_cnt,
        feed_item_tryon_save_click_cnt,
        feed_item_tryon_save_click_user_cnt,
        feed_item_general_save_click_cnt,
        feed_item_general_save_click_user_cnt,
        feed_item_product_save_click_cnt,
        feed_item_product_save_click_user_cnt,
        feed_item_styling_save_click_cnt,
        feed_item_styling_save_click_user_cnt,

        --try on gen
        tryon_gen_user_cnt,
        tryon_gen_save_click_cnt,
        tryon_gen_save_click_user_cnt,

        --product detail
        product_detail_save_click_cnt,
        product_detail_save_click_user_cnt,

        --product detail from search
        product_detail_from_search_save_click_cnt,
        product_detail_from_search_save_click_user_cnt,

        --full screen pic
        full_screen_pic_save_click_cnt,
        full_screen_pic_save_click_user_cnt,

        --collage gen
        collage_gen_user_cnt,
        collage_gen_save_click_cnt,
        collage_gen_save_click_user_cnt
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,

        --app
        active_user_d1_cnt,

        --total
        total_save_click_cnt,
        total_save_click_user_cnt,

        --feed detail
        feed_detail_user_cnt,
        feed_detail_save_click_cnt,
        feed_detail_save_click_user_cnt,
        feed_item_similar_save_click_cnt,
        feed_item_similar_save_click_user_cnt,
        feed_item_tryon_save_click_cnt,
        feed_item_tryon_save_click_user_cnt,
        feed_item_general_save_click_cnt,
        feed_item_general_save_click_user_cnt,
        feed_item_product_save_click_cnt,
        feed_item_product_save_click_user_cnt,
        feed_item_styling_save_click_cnt,
        feed_item_styling_save_click_user_cnt,

        --try on gen
        tryon_gen_user_cnt,
        tryon_gen_save_click_cnt,
        tryon_gen_save_click_user_cnt,

        --product detail
        product_detail_save_click_cnt,
        product_detail_save_click_user_cnt,

        --product detail from search
        product_detail_from_search_save_click_cnt,
        product_detail_from_search_save_click_user_cnt,

        --full screen pic
        full_screen_pic_save_click_cnt,
        full_screen_pic_save_click_user_cnt,

        --collage gen
        collage_gen_user_cnt,
        collage_gen_save_click_cnt,
        collage_gen_save_click_user_cnt
    FROM favie_rpt.rpt_favie_gensmo_save_with_dau_metric_inc_1d_function(dt_param);                    

end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
