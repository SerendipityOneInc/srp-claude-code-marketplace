CREATE VIEW `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_replica_chain_view`
AS WITH RECURSIVE
base_data AS (
        SELECT
            DATE(created_time) as dt,
            replica_task_id,
            replica_model_url,
            source_replica_task_id,
            source_replica_model_url,
            user_id,
            status,
            user_prompt,
            JSON_VALUE(replica,"$.model_id") as model_id
        FROM
            `favie_dw.dim_replica_task_view` t1,UNNEST(JSON_EXTRACT_ARRAY(replica_list)) replica
        WHERE status IN ('validated', 'completed', 'failure')
    ),

    data_with_refine AS (
      SELECT
        dt,
        replica_task_id,
        replica_model_url,
        source_replica_task_id,
        source_replica_model_url,
        user_id,
        status,
        user_prompt,
        model_id,
        EXISTS(
          SELECT 1
          FROM base_data t1
          WHERE t1.source_replica_task_id = t2.replica_task_id
        ) AS refined
      FROM base_data t2
    ),

    data_with_beh AS (
        SELECT
            t1.dt,
            t1.replica_task_id,
            t1.replica_model_url,
            t1.source_replica_task_id,
            t1.source_replica_model_url,
            t1.user_id,
            t1.status,
            t1.user_prompt,
            t1.model_id,
            CASE
                WHEN
                    t1.status = 'validated' THEN 'validated'
                WHEN
                    t1.status = 'failure' THEN 'failed'
                WHEN
                    t1.refined IS TRUE THEN 'refined'
                WHEN
                    t1.status = 'completed' AND t2.model_id IS NOT NULL THEN 'selected'
                ELSE 'discarded'
            END AS user_behavior
        FROM
            data_with_refine t1
        LEFT JOIN
            `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` t2
        ON
            t1.model_id = t2.model_id
            AND t1.user_id= t2.user_id
    ),

chain AS (
  -- Anchor: start with tasks that have no source (roots)
  SELECT
    dt,
    user_id,
    replica_task_id,
    source_replica_task_id,
    ARRAY[replica_task_id] AS chain_array,
    ARRAY[replica_model_url] AS pic_chain,
    ARRAY[user_prompt] AS prompt_chain,
    ARRAY[user_behavior] AS beh_chain,
    1 as depth
  FROM data_with_beh
  WHERE source_replica_task_id IS NULL and status = 'completed'

  UNION ALL

  -- Recursive step: attach refinements
  SELECT 
    t.dt,
    t.user_id,
    t.replica_task_id,
    t.source_replica_task_id,
    c.chain_array || [t.replica_task_id] AS chain_array,
    c.pic_chain || [t.replica_model_url] AS pic_chain,
    c.prompt_chain || [t.user_prompt] AS prompt_chain,
    c.beh_chain || [t.user_behavior] AS beh_chain,
    c.depth+1 as depth
  FROM data_with_beh t
  JOIN chain c
    ON t.source_replica_task_id = c.replica_task_id
    and t.status = 'completed'
  where c.depth<25
)

-- Final result: one row per chain
SELECT
    dt,
    user_id,
    pic_chain[SAFE_OFFSET(0)]  AS pic_0,
    beh_chain[SAFE_OFFSET(0)] AS beh_0,
    prompt_chain[SAFE_OFFSET(1)] AS prompt_1,
    pic_chain[SAFE_OFFSET(1)]  AS pic_1,
    beh_chain[SAFE_OFFSET(1)] AS beh_1,
    prompt_chain[SAFE_OFFSET(2)] AS prompt_2,
    pic_chain[SAFE_OFFSET(2)]  AS pic_2,
    beh_chain[SAFE_OFFSET(2)] AS beh_2,
    prompt_chain[SAFE_OFFSET(3)] AS prompt_3,
    pic_chain[SAFE_OFFSET(3)]  AS pic_3,
    beh_chain[SAFE_OFFSET(3)] AS beh_3,
    prompt_chain[SAFE_OFFSET(4)] AS prompt_4,
    pic_chain[SAFE_OFFSET(4)]  AS pic_4,
    beh_chain[SAFE_OFFSET(4)] AS beh_4,
    prompt_chain[SAFE_OFFSET(5)] AS prompt_5,
    pic_chain[SAFE_OFFSET(5)]  AS pic_5,
    beh_chain[SAFE_OFFSET(5)] AS beh_5,
    prompt_chain[SAFE_OFFSET(6)] AS prompt_6,
    pic_chain[SAFE_OFFSET(6)]  AS pic_6,
    beh_chain[SAFE_OFFSET(6)] AS beh_6,
    prompt_chain[SAFE_OFFSET(7)] AS prompt_7,
    pic_chain[SAFE_OFFSET(7)]  AS pic_7,
    beh_chain[SAFE_OFFSET(7)] AS beh_7,
    prompt_chain[SAFE_OFFSET(8)] AS prompt_8,
    pic_chain[SAFE_OFFSET(8)]  AS pic_8,
    beh_chain[SAFE_OFFSET(8)] AS beh_8,
    prompt_chain[SAFE_OFFSET(9)] AS prompt_9,
    pic_chain[SAFE_OFFSET(9)]  AS pic_9,
    beh_chain[SAFE_OFFSET(9)] AS beh_9,
    prompt_chain[SAFE_OFFSET(10)] AS prompt_10,
    pic_chain[SAFE_OFFSET(10)] AS pic_10,
    beh_chain[SAFE_OFFSET(10)] AS beh_10,
    prompt_chain[SAFE_OFFSET(11)] AS prompt_11,
    pic_chain[SAFE_OFFSET(11)] AS pic_11,
    beh_chain[SAFE_OFFSET(11)] AS beh_11,
    prompt_chain[SAFE_OFFSET(12)] AS prompt_12,
    pic_chain[SAFE_OFFSET(12)] AS pic_12,
    beh_chain[SAFE_OFFSET(12)] AS beh_12,
    prompt_chain[SAFE_OFFSET(13)] AS prompt_13,
    pic_chain[SAFE_OFFSET(13)] AS pic_13,
    beh_chain[SAFE_OFFSET(13)] AS beh_13,
    prompt_chain[SAFE_OFFSET(14)] AS prompt_14,
    pic_chain[SAFE_OFFSET(14)] AS pic_14,
    beh_chain[SAFE_OFFSET(14)] AS beh_14,
    prompt_chain[SAFE_OFFSET(15)] AS prompt_15,
    pic_chain[SAFE_OFFSET(15)] AS pic_15,
    beh_chain[SAFE_OFFSET(15)] AS beh_15,
    prompt_chain[SAFE_OFFSET(16)] AS prompt_16,
    pic_chain[SAFE_OFFSET(16)] AS pic_16,
    beh_chain[SAFE_OFFSET(16)] AS beh_16,
    prompt_chain[SAFE_OFFSET(17)] AS prompt_17,
    pic_chain[SAFE_OFFSET(17)] AS pic_17,
    beh_chain[SAFE_OFFSET(17)] AS beh_17,
    prompt_chain[SAFE_OFFSET(18)] AS prompt_18,
    pic_chain[SAFE_OFFSET(18)] AS pic_18,
    beh_chain[SAFE_OFFSET(18)] AS beh_18,
    prompt_chain[SAFE_OFFSET(19)] AS prompt_19,
    pic_chain[SAFE_OFFSET(19)] AS pic_19,
    beh_chain[SAFE_OFFSET(19)] AS beh_19,
    prompt_chain[SAFE_OFFSET(20)] AS prompt_20,
    pic_chain[SAFE_OFFSET(20)] AS pic_20,
    beh_chain[SAFE_OFFSET(20)] AS beh_20,
    prompt_chain[SAFE_OFFSET(21)] AS prompt_21,
    pic_chain[SAFE_OFFSET(21)] AS pic_21,
    beh_chain[SAFE_OFFSET(21)] AS beh_21,
    prompt_chain[SAFE_OFFSET(22)] AS prompt_22
FROM chain
WHERE NOT EXISTS (
  SELECT 1 
  FROM data_with_beh t 
  WHERE t.source_replica_task_id = chain.replica_task_id
);