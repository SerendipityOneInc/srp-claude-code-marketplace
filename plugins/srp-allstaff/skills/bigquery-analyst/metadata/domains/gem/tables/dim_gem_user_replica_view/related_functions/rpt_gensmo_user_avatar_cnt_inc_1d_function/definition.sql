WITH inc_task_with_model_id AS (
        SELECT
            replica_task_id,
            replica_model_url,
            source_replica_task_id,
            user_id,
            status,
            JSON_VALUE(t2,"$.model_id") as model_id
        FROM
            `favie_dw.dim_replica_task_view` t1
        LEFT JOIN
            UNNEST(JSON_EXTRACT_ARRAY(replica_list)) t2
        WHERE status IN ('validated', 'completed', 'failure')
        AND DATE(created_time) = dt_param
    ),

    task_with_refine AS (
      SELECT
        replica_task_id,
        replica_model_url,
        source_replica_task_id,
        user_id,
        status,
        model_id,
        EXISTS(
          SELECT 1
          FROM inc_task_with_model_id t1
          WHERE t1.source_replica_task_id = t2.replica_task_id
        ) AS refined
      FROM inc_task_with_model_id t2
    ),

    labeled_task_model AS (
        SELECT
            t1.replica_task_id,
            t1.user_id,
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
            END AS status_label
        FROM
            task_with_refine t1
        LEFT JOIN
            `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` t2
        ON
            t1.model_id = t2.model_id
            AND t1.user_id= t2.user_id
    ),

    inc_labeled_task_cnt AS (
        SELECT
            user_id,
            COUNT(DISTINCT CASE WHEN status_label = 'validated' THEN replica_task_id END) AS validated_task_cnt,
            COUNT(DISTINCT CASE WHEN status_label = 'failed' THEN replica_task_id END) AS failed_task_cnt,
            COUNT(DISTINCT CASE WHEN status_label = 'discarded' THEN replica_task_id END) AS discarded_task_cnt,
            COUNT(DISTINCT CASE WHEN status_label = 'refined' THEN replica_task_id END) AS refined_task_cnt,
            COUNT(DISTINCT CASE WHEN status_label = 'selected' THEN replica_task_id END) AS selected_task_cnt
        FROM
            labeled_task_model
        GROUP BY
            user_id
    ),

    task_cnt_by_device AS (
        SELECT
            t1.user_id,
            t2.device_id,
            t1.validated_task_cnt,
            t1.failed_task_cnt,
            t1.discarded_task_cnt,
            t1.refined_task_cnt,
            t1.selected_task_cnt
        FROM
            inc_labeled_task_cnt t1
        LEFT JOIN `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_snapshot_function`(dt_param) t2
        ON t1.user_id = t2.user_id
    ),
    
    stocked_avatar_cnt AS (
        SELECT
            t2.device_id,
            COUNT(DISTINCT CASE WHEN
                    DATE(t1.created_timestamp) = dt_param AND (DATE(t1.deleted_timestamp) > dt_param OR t1.deleted_timestamp IS NULL)
                THEN t1.model_id END) AS new_avatar_cnt,
            COUNT(DISTINCT CASE WHEN
                    DATE(t1.created_timestamp) <= dt_param AND (DATE(t1.deleted_timestamp) > dt_param OR t1.deleted_timestamp IS NULL)
                THEN t1.model_id END) AS valid_avatar_cnt,
            COUNT(DISTINCT CASE WHEN
                    DATE(t1.deleted_timestamp) < dt_param
                THEN t1.model_id END) AS invalid_avatar_cnt
        FROM
            `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` t1
        LEFT JOIN `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_snapshot_function`(dt_param) t2
        ON
            t1.user_id = t2.user_id
            AND
            DATE(t1.created_timestamp) = t2.dt
        LEFT JOIN (
            SELECT
                user_id,
                JSON_VALUE(t2,"$.model_id") as model_id
            FROM
                `favie_dw.dim_replica_task_view` t1
            LEFT JOIN
                UNNEST(JSON_EXTRACT_ARRAY(replica_list)) t2
            WHERE status IN ('validated', 'completed', 'failure')
        ) t3
        ON
            t1.model_id = t3.model_id
            AND t1.user_id = t3.user_id
        WHERE t3.model_id IS NOT NULL
        GROUP BY
            device_id
    ),

    avatar_cnt_info AS (
        SELECT
            COALESCE(t1.device_id, t2.device_id) AS device_id,
            t1.validated_task_cnt,
            t1.failed_task_cnt,
            t1.discarded_task_cnt,
            t1.refined_task_cnt,
            t1.selected_task_cnt,
            t2.new_avatar_cnt,
            t2.valid_avatar_cnt,
            t2.invalid_avatar_cnt
        FROM
            task_cnt_by_device t1
        FULL JOIN
            stocked_avatar_cnt t2
        ON
            t1.device_id = t2.device_id
    ),
    
    avatar_with_user_group_info AS (
        SELECT
            t2.device_id,
            t1.user_group,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.platform,
            t1.app_version,
            t1.country_name,


            COALESCE(t2.validated_task_cnt, 0) AS validated_task_cnt,
            COALESCE(t2.failed_task_cnt, 0) AS failed_task_cnt,
            COALESCE(t2.discarded_task_cnt, 0) AS discarded_task_cnt,
            COALESCE(t2.refined_task_cnt, 0) AS refined_task_cnt,
            COALESCE(t2.selected_task_cnt, 0) AS selected_task_cnt,
            COALESCE(t2.new_avatar_cnt, 0) AS new_avatar_cnt,
            COALESCE(t2.valid_avatar_cnt, 0) AS valid_avatar_cnt,
            COALESCE(t2.invalid_avatar_cnt, 0) AS invalid_avatar_cnt,

            IF(validated_task_cnt > 0, t2.device_id, NULL) AS validated_task_device_id,
            IF(failed_task_cnt > 0, t2.device_id, NULL) AS failed_task_device_id,
            IF(discarded_task_cnt > 0, t2.device_id, NULL) AS discarded_task_device_id,
            IF(refined_task_cnt > 0, t2.device_id, NULL) AS refined_task_device_id,
            IF(selected_task_cnt > 0, t2.device_id, NULL) AS selected_task_device_id,
            IF(new_avatar_cnt > 0, t2.device_id, NULL) AS new_avatar_device_id,
            IF(valid_avatar_cnt > 0, t2.device_id, NULL) AS valid_avatar_device_id,
            IF(invalid_avatar_cnt > 0, t2.device_id, NULL) AS invalid_avatar_device_id
        FROM
            `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param) t1
        LEFT JOIN
            avatar_cnt_info t2
        ON
            t1.device_id = t2.device_id
        WHERE
            t1.dt = dt_param
            AND
            t2.device_id IS NOT NULL
        )
    
    SELECT
        dt_param AS dt,
        
        device_id,
        user_group,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        country_name,
        validated_task_cnt,
        failed_task_cnt,
        discarded_task_cnt,
        refined_task_cnt,
        selected_task_cnt,
        new_avatar_cnt,
        valid_avatar_cnt,
        invalid_avatar_cnt,
        validated_task_device_id,
        failed_task_device_id,
        discarded_task_device_id,
        refined_task_device_id,
        selected_task_device_id,
        new_avatar_device_id,
        valid_avatar_device_id,
        invalid_avatar_device_id
    FROM
        avatar_with_user_group_info