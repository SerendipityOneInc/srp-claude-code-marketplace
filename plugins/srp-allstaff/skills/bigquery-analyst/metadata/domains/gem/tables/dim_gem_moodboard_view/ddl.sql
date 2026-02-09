CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_moodboard_view`
AS SELECT  score
        ,is_try_on
        ,task_id
        ,reasoning
        ,image
        ,search_product_list
        ,image_width
        ,query
        ,moodboard_id
        ,updated_time
        ,updated_date
        ,created_time
        ,created_date
        ,status
        ,remix
        ,created_user_id
        ,image_url
        ,image_height
        ,image_description
        ,is_feed
        ,last_updated
        ,intention
        ,moodboards
        ,height
    FROM
    (
        SELECT  score
            ,is_try_on
            ,task_id
            ,reasoning
            ,image
            ,search_product_list
            ,image_width
            ,query
            ,moodboard_id
            ,update_time                                                             AS updated_time
            ,Date(update_time)                                                       AS updated_date
            ,created_time
            ,Date(created_time)                                                      AS created_date
            ,status
            ,remix
            ,created_user_id
            ,image_url
            ,image_height
            ,image_description
            ,is_feed
            ,last_updated
            ,intention
            ,moodboards
            ,height
            ,ROW_NUMBER() over(PARTITION BY moodboard_id ORDER BY  update_time DESC) AS rn
        FROM `srpproduct-dc37e.favie_mongodb_integration_stitch3_v2.moodboard_feed_serialized` 
        WHERE --status = 'NORMAL'AND 
        moodboard_id is not null
        AND moodboard_id != '' 
    ) t1
    WHERE rn = 1;