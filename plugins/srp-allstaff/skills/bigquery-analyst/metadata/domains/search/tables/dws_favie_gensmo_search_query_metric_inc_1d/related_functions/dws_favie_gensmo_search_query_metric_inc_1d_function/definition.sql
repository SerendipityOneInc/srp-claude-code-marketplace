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