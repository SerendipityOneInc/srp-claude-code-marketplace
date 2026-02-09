WITH 
  base_qpquery_data AS (
    SELECT 
        query AS raw_query,
        JSON_VALUE(moodboard_product,'$.query') AS qp_query,
        CASE 
          WHEN (query is not null and trim(query) != "") and (image_url is not null and trim(image_url) != "") THEN "text&image" 
          WHEN (query is not null and trim(query) != "") and (image_url is null or trim(image_url) = "") THEN "text" 
          WHEN (query is null or trim(query) = "") and (image_url is not null and trim(image_url) != "") THEN "image" 
          ELSE "unknown" 
        END AS query_modality,
        ARRAY_LENGTH(SPLIT(TRIM(query),' ')) AS raw_query_word_amt,
        ARRAY_LENGTH(SPLIT(TRIM(JSON_VALUE(moodboard_product,'$.query')),' ')) AS qp_query_word_amt,
        dt_param AS dt 
    FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
    CROSS JOIN UNNEST(moodboard_products) AS moodboard_product
    WHERE DATE(created_time) = dt_param 
      AND query IS NOT NULL AND query != ''
      AND JSON_VALUE(moodboard_product,'$.query') IS NOT NULL AND JSON_VALUE(moodboard_product,'$.query') != ''
  )

  SELECT 
    raw_query,
    qp_query,
    query_modality,
    raw_query_word_amt,
    qp_query_word_amt,
    COUNT(1) AS query_cnt,
    dt
  FROM base_qpquery_data
  GROUP BY
    raw_query,
    qp_query,
    query_modality,
    raw_query_word_amt,
    qp_query_word_amt,
    dt