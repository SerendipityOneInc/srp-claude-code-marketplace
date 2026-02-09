# dws_favie_gensmo_search_query_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_search_query_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-24
**最后更新**: 2025-10-24

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
WITH 
  base_data AS (
    SELECT 
        raw_query,
        qp_query,
        CASE 
          WHEN (raw_query is not null and trim(raw_query) != "") and (user_image_url is not null and trim(user_image_url) != "") THEN "text&image" 
          WHEN (raw_query is not null and trim(raw_query) != "") and (user_image_url is null or trim(user_image_url) = "") THEN "text" 
          WHEN (raw_query is null or trim(raw_query) = "") and (user_image_url is not null and trim(user_image_url) != "") THEN "image" 
          ELSE "unknown" 
        END AS query_modality,
        ARRAY_LENGTH(SPLIT(TRIM(raw_query),' ')) AS raw_query_word_amt,
        ARRAY_LENGTH(SPLIT(TRIM(qp_query),' ')) AS qp_query_word_amt,
        dt_param AS dt 
    FROM `favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d`
    WHERE dt IS NOT NULL AND dt = dt_param
      AND raw_query IS NOT NULL AND raw_query != ''
      AND qp_query IS NOT NULL AND qp_query != ''
  )

  SELECT 
    raw_query,
    qp_query,
    query_modality,
    raw_query_word_amt,
    qp_query_word_amt,
    COUNT(1) AS query_cnt,
    dt
  FROM base_data
  GROUP BY
    raw_query,
    qp_query,
    query_modality,
    raw_query_word_amt,
    qp_query_word_amt,
    dt
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
