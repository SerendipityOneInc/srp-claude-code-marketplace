# rpt_gensmo_analysis_search_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-07-11
**最后更新**: 2025-07-11

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

- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d` (dwd_favie_gensmo_events_inc_1d)
- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` (dws_gensmo_user_group_inc_1d)

---

## 💻 函数定义

```sql
WITH user_info_with_group as (
    select 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
    from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` 
    where dt = dt_param
  ),

  unnest_item_category AS (
    SELECT  
      a.dt,
      b.platform,
      b.app_version,
      b.country_name,
      b.user_login_type,
      b.user_tenure_type,
      b.user_group,
      a.device_id,
      b.device_id AS user_device_id,
      a.refer,
      a.event_action_type,
      a.cal_pre_refer,
      a.cal_next_refer,
      (
        SELECT item.item_type
        FROM UNNEST(a.event_items) AS item
        WHERE item.item_type IN ('query_text_only', 'query_pic_only', 'query_text_pic')
        LIMIT 1 
      ) AS query_input_type,
      CASE 
        WHEN EXISTS(
            SELECT 1
            FROM UNNEST(a.event_items) AS item
            WHERE item.item_type = 'reco_inspo'
        ) THEN 'inspo'
        ELSE 'without_inspo'
    END AS query_input_inspo,
      MAX(IF(refer = 'collage_gen' AND event_name = 'view_item_list' AND ap_name = 'ap_collage_list', 1, 0)) OVER user_refer_window AS is_loading_completed,
      MAX(IF(event_action_type = 'collage_gen', 1, 0)) OVER user_refer_window AS is_collage_gen,
      MAX(IF(refer = 'login_half_screen' AND event_name = 'select_item' AND event_method = 'page_view', 1, 0)) OVER user_refer_window AS is_login_block,
      CASE 
        WHEN MAX(IF(refer = 'collage_gen' AND event_name = 'select_item' AND event_method = 'error_general', 1, 0)) OVER user_refer_window = 1 THEN 'error_general'
        WHEN MAX(IF(refer = 'collage_gen' AND event_name = 'select_item' AND event_method = 'error_network', 1, 0)) OVER user_refer_window = 1 THEN 'error_network'
        WHEN MAX(IF(refer = 'collage_gen' AND event_name = 'select_item' AND event_method = 'error_busy', 1, 0)) OVER user_refer_window = 1 THEN 'error_busy'
        ELSE NULL 
      END AS error_block,
      CASE 
        WHEN refer = 'search_boot' AND cal_pre_refer = 'feed_detail' THEN 'gen_remix_from_feed'
        WHEN (refer = 'product_detail' AND cal_pre_refer = 'feed_detail') OR (refer = 'pseudo_product_detail' AND cal_pre_refer = 'feed_detail') THEN 'gen_remix_from_feed_item'
        WHEN refer = 'search_boot' AND cal_pre_refer = 'try_on_gen' THEN 'gen_remix_from_try_on'
        WHEN refer NOT IN ('search_boot', 'pseudo_product_detail', 'product_detail', 'product_detail_from_search', 'collage_gen') THEN 'gen_quick_mode'
        WHEN refer = 'search_boot' AND cal_pre_refer != 'collage_gen' THEN 'gen_custom'
        WHEN refer IN ('collage_gen', 'search_boot') AND cal_pre_refer = 'collage_gen' THEN 'gen_narrow_down'
        WHEN (refer = 'product_detail_from_search' AND cal_pre_refer = 'collage_gen') OR (refer = 'pseudo_product_detail' AND cal_pre_refer = 'collage_gen') THEN 'gen_remix_from_search_item'
        WHEN (refer = 'product_detail' AND cal_pre_refer = 'try_on_gen') OR (refer = 'pseudo_product_detail' AND cal_pre_refer = 'try_on_gen') THEN 'gen_remix_from_try_on_item'
        ELSE 'other'
      END AS search_type,
      refer_pv_seq,
      DATE_TRUNC(DATE(dt), WEEK(MONDAY)) AS week_date
    FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d a
    LEFT JOIN user_info_with_group b ON a.device_id = b.device_id
    WHERE 
      event_timestamp IS NOT NULL
      AND event_version = '1.0.0'
      AND event_timestamp != TIMESTAMP('1970-01-01 00:00:00 UTC')
      AND refer != 'app'
      AND refer IS NOT NULL
      AND b.platform IS NOT NULL
      and dt is not null
      AND dt = dt_param 
      AND b.user_group IS NOT NULL
    WINDOW user_refer_window AS (PARTITION BY a.dt, a.device_id, a.refer, a.refer_pv_seq ORDER BY event_timestamp ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  ),
  agg_data AS (
    SELECT 
      dt,
      device_id,
      refer,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      cal_pre_refer,
      cal_next_refer,
      refer_pv_seq,
      is_loading_completed,
      is_login_block,
      error_block,
      week_date,
      is_collage_gen
    FROM unnest_item_category
    GROUP BY  
      dt,
      device_id,
      refer,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      cal_pre_refer,
      cal_next_refer,
      refer_pv_seq,
      is_loading_completed,
      is_login_block,
      error_block,
      week_date,
      is_collage_gen
  ),
  finish_data AS (
    SELECT 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      week_date,
      device_id,
      query_input_type,
      search_type,
      query_input_inspo,
      event_action_type,
      refer,
      is_loading_completed,
      is_login_block,
      error_block,
      second_refer,
      second_is_loading_completed,
      second_is_login_block,
      second_error_block,
      third_refer,
      third_is_loading_completed,
      third_is_login_block,
      third_error_block,
      fourth_refer,
      fourth_is_loading_completed,
      fourth_is_login_block,
      fourth_error_block,
      fifth_refer,
      fifth_is_loading_completed,
      fifth_is_login_block,
      fifth_error_block,
      first_collage_gen_position,
      second_collage_gen_position,
      CASE 
        WHEN second_collage_gen_position = 2 THEN 'LOAD_FAIL'
        WHEN second_collage_gen_position = 3 THEN IF(COALESCE(second_is_loading_completed, 0) > 0, 'LOAD_FINISH', 'LOAD_FAIL')
        WHEN second_collage_gen_position = 4 THEN IF(COALESCE(second_is_loading_completed, 0) + COALESCE(third_is_loading_completed, 0) > 0, 'LOAD_FINISH', 'LOAD_FAIL')
        WHEN second_collage_gen_position = 5 THEN IF(COALESCE(second_is_loading_completed, 0) + COALESCE(third_is_loading_completed, 0) + COALESCE(fourth_is_loading_completed, 0) > 0, 'LOAD_FINISH', 'LOAD_FAIL')
        WHEN second_collage_gen_position IS NULL THEN IF(COALESCE(second_is_loading_completed, 0) + COALESCE(third_is_loading_completed, 0) + COALESCE(fourth_is_loading_completed, 0) + COALESCE(fifth_is_loading_completed, 0) > 0, 'LOAD_FINISH', 'LOAD_FAIL')
        ELSE 'UNKNOWN'
      END AS agg_load_finish,
      CASE 
        WHEN second_collage_gen_position = 2 THEN IF(COALESCE(second_error_block, '') != '', 'ERROR_BLOCK', 'NON_ERROR_BLOCK')
        WHEN second_collage_gen_position = 3 THEN IF(CONCAT(COALESCE(second_error_block, ''), COALESCE(third_error_block, '')) != '', 'ERROR_BLOCK', 'NON_ERROR_BLOCK')
        WHEN second_collage_gen_position = 4 THEN IF(CONCAT(COALESCE(second_error_block, ''), COALESCE(third_error_block, ''), COALESCE(fourth_error_block, '')) != '', 'ERROR_BLOCK', 'NON_ERROR_BLOCK')
        WHEN second_collage_gen_position = 5 THEN IF(CONCAT(COALESCE(second_error_block, ''), COALESCE(third_error_block, ''), COALESCE(fourth_error_block, ''), COALESCE(fifth_error_block, '')) != '', 'ERROR_BLOCK', 'NON_ERROR_BLOCK')
        WHEN second_collage_gen_position IS NULL THEN IF(CONCAT(COALESCE(second_error_block, ''), COALESCE(third_error_block, ''), COALESCE(fourth_error_block, ''), COALESCE(fifth_error_block, '')) != '', 'ERROR_BLOCK', 'NON_ERROR_BLOCK')
        ELSE 'UNKNOWN'
      END AS agg_error_block,
      CASE 
        WHEN second_collage_gen_position = 2 THEN IF(COALESCE(second_is_login_block, 0) > 0, 'LOGIN_BLOCK', 'NON_LOGIN_BLOCK')
        WHEN second_collage_gen_position = 3  THEN IF(COALESCE(second_is_login_block, 0) + COALESCE(third_is_login_block, 0) > 0, 'LOGIN_BLOCK', 'NON_LOGIN_BLOCK')
        WHEN second_collage_gen_position = 4 THEN IF(COALESCE(second_is_login_block, 0) + COALESCE(third_is_login_block, 0) + COALESCE(fourth_is_login_block, 0) > 0, 'LOGIN_BLOCK', 'NON_LOGIN_BLOCK')
        WHEN second_collage_gen_position = 5 THEN IF(COALESCE(second_is_login_block, 0) + COALESCE(third_is_login_block, 0) + COALESCE(fourth_is_login_block, 0) + COALESCE(fifth_is_login_block, 0) > 0, 'LOGIN_BLOCK', 'NON_LOGIN_BLOCK')
        WHEN second_collage_gen_position IS NULL THEN IF(COALESCE(second_is_login_block, 0) + COALESCE(third_is_login_block, 0) + COALESCE(fourth_is_login_block, 0) + COALESCE(fifth_is_login_block, 0) > 0, 'LOGIN_BLOCK', 'NON_LOGIN_BLOCK')
        ELSE 'UNKNOWN'
      END AS agg_login_block
    FROM (
      SELECT 
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        week_date,
        device_id,
        query_input_type,
        search_type,
        query_input_inspo,
        event_action_type,
        refer,
        is_loading_completed,
        is_login_block,
        error_block,
        second_refer,
        second_is_loading_completed,
        second_is_login_block,
        second_error_block,
        third_refer,
        third_is_loading_completed,
        third_is_login_block,
        third_error_block,
        fourth_refer,
        fourth_is_loading_completed,
        fourth_is_login_block,
        fourth_error_block,
        fifth_refer,
        fifth_is_loading_completed,
        fifth_is_login_block,
        fifth_error_block,
        1 AS first_collage_gen_position,
        CASE 
          WHEN collage_sum_2 = 1 THEN 2
          WHEN collage_sum_3 = 1 THEN 3
          WHEN collage_sum_4 = 1 THEN 4
          WHEN collage_sum_5 = 1 THEN 5
          ELSE NULL
        END AS second_collage_gen_position
      FROM (
        SELECT 
          a.dt,
          a.platform,
          a.app_version,
          a.country_name,
          a.user_login_type,
          a.user_tenure_type,
          a.user_group,
          a.week_date,
          a.device_id,
          a.query_input_type,
          a.search_type,
          a.query_input_inspo,
          a.event_action_type,
          a.refer,
          a.is_loading_completed,
          a.is_login_block,
          a.error_block,
          b.refer AS second_refer,
          b.is_loading_completed AS second_is_loading_completed,
          b.is_login_block AS second_is_login_block,
          b.error_block AS second_error_block,
          c.refer AS third_refer,
          c.is_loading_completed AS third_is_loading_completed,
          c.is_login_block AS third_is_login_block,
          c.error_block AS third_error_block,
          d.refer AS fourth_refer,
          d.is_loading_completed AS fourth_is_loading_completed,
          d.is_login_block AS fourth_is_login_block,
          d.error_block AS fourth_error_block,
          e.refer AS fifth_refer,
          e.is_loading_completed AS fifth_is_loading_completed,
          e.is_login_block AS fifth_is_login_block,
          e.error_block AS fifth_error_block,
          b.is_collage_gen AS collage_sum_2,
          c.is_collage_gen AS collage_sum_3,
          d.is_collage_gen AS collage_sum_4,
          e.is_collage_gen AS collage_sum_5
        FROM unnest_item_category a
        LEFT JOIN agg_data b ON a.dt = b.dt AND a.device_id = b.device_id AND a.cal_next_refer = b.refer AND b.cal_pre_refer = a.refer AND a.app_version = b.app_version AND a.platform = b.platform AND a.country_name = b.country_name AND a.user_tenure_type = b.user_tenure_type AND a.user_login_type = b.user_login_type AND a.refer_pv_seq + 1 = b.refer_pv_seq
        LEFT JOIN agg_data c ON b.dt = c.dt AND b.device_id = c.device_id AND b.cal_next_refer = c.refer AND c.cal_pre_refer = b.refer AND b.app_version = c.app_version AND b.platform = c.platform AND b.country_name = c.country_name AND b.user_tenure_type = c.user_tenure_type AND b.user_login_type = c.user_login_type AND b.refer_pv_seq + 1 = c.refer_pv_seq
        LEFT JOIN agg_data d ON c.dt = d.dt AND c.device_id = d.device_id AND c.cal_next_refer = d.refer AND d.cal_pre_refer = c.refer AND c.app_version = d.app_version AND c.platform = d.platform AND c.country_name = d.country_name AND c.user_tenure_type = d.user_tenure_type AND c.user_login_type = d.user_login_type AND c.refer_pv_seq + 1 = d.refer_pv_seq
        LEFT JOIN agg_data e ON d.dt = e.dt AND d.device_id = e.device_id AND d.cal_next_refer = e.refer AND e.cal_pre_refer = d.refer AND d.app_version = e.app_version AND d.platform = e.platform AND d.country_name = e.country_name AND d.user_tenure_type = e.user_tenure_type AND d.user_login_type = e.user_login_type AND d.refer_pv_seq + 1 = e.refer_pv_seq
        WHERE event_action_type = 'collage_gen'
        GROUP BY  
          a.dt,
          a.platform,
          a.app_version,
          a.country_name,
          a.user_login_type,
          a.user_tenure_type,
          a.user_group,
          a.week_date,
          a.device_id,
          a.query_input_type,
          a.search_type,
          a.query_input_inspo,
          a.event_action_type,
          a.refer,
          a.is_loading_completed,
          a.is_login_block,
          a.error_block,
          b.refer,
          b.is_loading_completed,
          b.is_login_block,
          b.error_block,
          c.refer,
          c.is_loading_completed,
          c.is_login_block,
          c.error_block,
          d.refer,
          d.is_loading_completed,
          d.is_login_block,
          d.error_block,
          e.refer,
          e.is_loading_completed,
          e.is_login_block,
          e.error_block,
          b.is_collage_gen,
          c.is_collage_gen,
          d.is_collage_gen,
          e.is_collage_gen
      ) t1
    ) t2
  )
  SELECT
    dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    device_id,
    query_input_inspo,
    query_input_type,
    search_type,
    COUNT(device_id) AS user_count,
    COUNT(IF(agg_load_finish = 'LOAD_FINISH', device_id, NULL)) AS load_finish_count,
    agg_load_finish,
    agg_error_block,
    agg_login_block,
    first_collage_gen_position,
    second_collage_gen_position
  FROM finish_data
  GROUP BY 
    dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    device_id,
    query_input_inspo,
    query_input_type,
    search_type,
    agg_load_finish,
    agg_error_block,
    agg_login_block,
    first_collage_gen_position,
    second_collage_gen_position
```

---

**文档生成**: 2026-01-30 13:39:22
**扫描工具**: scan_functions.py
