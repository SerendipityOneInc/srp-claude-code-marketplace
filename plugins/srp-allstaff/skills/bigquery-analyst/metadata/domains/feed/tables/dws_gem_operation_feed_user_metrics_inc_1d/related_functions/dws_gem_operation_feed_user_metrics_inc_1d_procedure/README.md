# dws_gem_operation_feed_user_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_feed_user_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-11-12
**最后更新**: 2025-11-12

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
  -- 删除当日数据
  DELETE FROM `favie_dw.dws_gem_operation_feed_user_metrics_inc_1d`
  WHERE dt = dt_param;

  -- 插入最新聚合结果
  INSERT INTO `favie_dw.dws_gem_operation_feed_user_metrics_inc_1d`
  (
    dt,
    item_type,
    device_id,
    refer,
    user_group,
    country_name,
    platform,
    app_version,
    feed_type,
    production_type,
    user_login_type,
    user_tenure_type,
    feed_view_pv_cnt,
    feed_click_pv_cnt,
    feed_like_click_pv_cnt,
    feed_try_on_pv_cnt,
    -- ✅ 改名
    feed_try_on_trigger_pv_cnt,
    -- ✅ 新增
    feed_remix_see_it_on_me_pv_cnt,
    feed_comment_pv_cnt,
    feed_save_pv_cnt,
    feed_product_external_jump_pv_cnt,
    feed_product_click_pv_cnt,
    feed_share_pv_cnt,
    feed_screen_shot_pv_cnt,
    feed_hashtag_click_pv_cnt,
    feed_editor_pick_view_pv_cnt,
    feed_editor_pick_click_pv_cnt,
    follow_click_cnt
  )
  SELECT
    dt,
    item_type,
    device_id,
    refer,
    user_group,
    country_name,
    platform,
    app_version,
    feed_type,
    production_type,
    user_login_type,
    user_tenure_type,
    feed_view_pv_cnt,
    feed_click_pv_cnt,
    feed_like_click_pv_cnt,
    feed_try_on_pv_cnt,
    -- ✅ 改名
    feed_try_on_trigger_pv_cnt,
    -- ✅ 新增
    feed_remix_see_it_on_me_pv_cnt,
    feed_comment_pv_cnt,
    feed_save_pv_cnt,
    feed_product_external_jump_pv_cnt,
    feed_product_click_pv_cnt,
    feed_share_pv_cnt,
    feed_screen_shot_pv_cnt,
    feed_hashtag_click_pv_cnt,
    feed_editor_pick_view_pv_cnt,
    feed_editor_pick_click_pv_cnt,
    follow_click_cnt
  FROM `favie_dw.dws_gem_operation_feed_user_metrics_inc_1d_function`(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
