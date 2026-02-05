CREATE VIEW `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_avatar_refine_detail_inc_1d_view`
AS WITH base_data AS (
        SELECT
            date(created_time) AS dt,
            replica_task_id,
            replica_model_url,
            source_replica_task_id,
            source_replica_model_url,
            user_image_url,
            user_prompt,
            user_id,
            status
        FROM
            `favie_dw.dim_replica_task_view` t1
        WHERE status IN ('unvalidated', 'completed', 'failure')
          and source_replica_task_id IS NOT NULL
          AND source_replica_task_id != ''
    )

      SELECT
        DATE(dt) AS dt,
        user_id,
        replica_task_id,
        source_replica_task_id,
        user_image_url,
        source_replica_model_url,
        replica_model_url,
        user_prompt,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY dt ASC) AS seq_order
      FROM base_data
      WHERE source_replica_model_url != replica_model_url
      ORDER BY dt;