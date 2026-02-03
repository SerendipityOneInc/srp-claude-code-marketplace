# rpt_favie_gensmo_search_by_server_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

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

- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read` (dws_gensmo_user_group_inc_1d_function_read)
- `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d` (dim_favie_gensmo_user_account_changelog_1d)
- `srpproduct-dc37e.favie_dw.dim_moodboard_view` (dim_moodboard_view)

---

## 💻 函数定义

```sql
with dim_moodboard as (
SELECT  
        _id,
        created_user_id,
        created_time as created_at,
        update_time as updated_at,
        moodboard_id,
        moodboard_index,
        task_id,
        status,
        description,
        is_feed,
        is_try_on,
        gender,
        hashtags,
        height,
        width,

        search_product_list,
        image,
        user_image_tag,

        image_url,
        image_description,
        image_height,
        image_width,

        liked_count,
        remix,
        saved_count,
        shared_count,
        score,
        intention,
        moodboards,
        query,
        reasoning,
        publisher,
        cover_image_list

        
    FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
),
  server_search_task_data AS (
    SELECT 
      dt_param as dt,
      task_id,
      coalesce(created_user_id,"unknown") as user_id,
    FROM dim_moodboard
    WHERE status in ("completed",'NORMAL')
      and moodboard_index=0
      and created_user_id is not null 
      and date(created_at) = dt_param
  ),

  server_search_task_data_with_device_id as (
    SELECT 
      t1.dt,
      t1.task_id,
      t1.user_id,
      coalesce(t2.last_device_id,"unknown") as device_id
    FROM server_search_task_data t1
    LEFT JOIN srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d t2
      ON t1.user_id = t2.user_id
  ),

  server_search_metric_data as (
    SELECT 
      dt,
      device_id,
      COUNT(task_id) AS collage_server_complete_task_cnt
    FROM server_search_task_data_with_device_id
    GROUP BY dt,device_id
  ),

  user_info_with_group as (
    select 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
        FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)

  ),

  server_search_metric_data_with_user as (
    select 
      t1.dt,
      --user info 
      t2.platform,
      t2.app_version,
      t2.country_name,
      t2.user_login_type,
      t2.user_tenure_type,
      t2.user_group,

      sum(t1.collage_server_complete_task_cnt) as collage_server_complete_task_cnt,
      count(distinct t2.device_id) as collage_server_complete_user_cnt

    from server_search_metric_data as t1 left outer join user_info_with_group t2
    on t1.device_id = t2.device_id
    where t2.user_group is not null
    group by t1.dt,
      t2.platform,
      t2.app_version,
      t2.country_name,
      t2.user_login_type,
      t2.user_tenure_type,
      t2.user_group
  )

  SELECT
      dt,
      --user info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,

      collage_server_complete_task_cnt,
      collage_server_complete_user_cnt
    FROM server_search_metric_data_with_user
```

---

**文档生成**: 2026-01-30 13:39:03
**扫描工具**: scan_functions.py
