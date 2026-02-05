# rpt_favie_gensmo_tryon_model_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_model_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-07-10
**最后更新**: 2025-07-10

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
WITH base_dws_data AS (
    SELECT 
      dt,
      item_type,
      item_task_model,
      item_task_type,
      COUNT(DISTINCT IF(item_task_created_time IS NOT NULL 
                        AND DATE(item_task_created_time) = dt_param, item_id, NULL)) AS item_task_list_item_cnt,
      COUNT(DISTINCT IF(event_action_type = "save", item_id, NULL)) AS item_task_save_item_cnt,
      COUNT(DISTINCT IF(event_action_type = 'download', item_id, NULL)) AS item_task_download_item_cnt
    FROM favie_dw.dwd_gensmo_channel_action_info_inc_1d_function(dt_param)
    WHERE item_task_type = 'mix'
    GROUP BY dt, item_type, item_task_model, item_task_type
  )
  SELECT
    dt,
    item_task_model,
    SUM(item_task_list_item_cnt) AS item_task_list_item_cnt,
    SUM(item_task_save_item_cnt) AS item_task_save_item_cnt,
    SUM(item_task_download_item_cnt) AS item_task_download_item_cnt
  FROM base_dws_data
  GROUP BY dt, item_task_model
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
