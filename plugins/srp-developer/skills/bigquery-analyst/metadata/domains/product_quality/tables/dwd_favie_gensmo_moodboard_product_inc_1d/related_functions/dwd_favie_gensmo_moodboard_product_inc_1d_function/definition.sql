SELECT
            -- moodboard level
            moodboard_id,
            task_id AS moodboard_task_id,
            moodboard_index,
            query AS raw_query,
            created_user_id AS moodboard_created_user_id,
            gender AS moodboard_user_gender,
            created_time AS moodboard_created_time,
            update_time AS moodboard_updated_time,            
            description AS moodboard_description,
            is_feed AS moodboard_is_feed,
            is_try_on AS moodboard_is_try_on,
            hashtags AS moodboard_hashtags,

            image AS moodboard_image_url,
            user_image_tag,
            image_url AS user_image_url,
            image_description AS user_image_description,

            liked_count AS moodboard_liked_count,
            saved_count AS moodboard_saved_count,
            shared_count AS moodboard_shared_count,
            intention,
            reasoning,
            is_onboard,
            moderation_status,
            publisher,

            -- product level
            JSON_VALUE(moodboard_product,'$.global_id') AS product_id,

            TIMESTAMP_SECONDS(SAFE_CAST(JSON_VALUE(moodboard_product,'$.f_creates_at') AS INT)) AS product_created_time,
            TIMESTAMP_SECONDS(SAFE_CAST(JSON_VALUE(moodboard_product,'$.f_updates_at') AS INT)) AS product_updated_time,


            JSON_VALUE(moodboard_product,'$.brand') AS product_brand,
            JSON_VALUE(moodboard_product,'$.norm_brand') AS product_norm_brand,
            JSON_VALUE(moodboard_product,'$.brand_link') AS product_brand_link,
            JSON_VALUE(moodboard_product,'$.link') AS product_link,
            JSON_VALUE(moodboard_product,'$.source') AS product_site,
            JSON_VALUE(moodboard_product,'$.platform') AS product_platform,
            JSON_VALUE(moodboard_product,'$.title') AS product_title,
            JSON_VALUE(moodboard_product, '$.collage_category') AS product_collage_category,
            PARSE_JSON(JSON_QUERY(moodboard_product,'$.tags')) AS product_tags,

            JSON_VALUE(moodboard_product,'$.display_image') AS product_display_image,
            JSON_VALUE(moodboard_product,'$.main_image.link') AS product_main_image,

            JSON_VALUE(moodboard_product,'$.query') AS qp_query,
            JSON_VALUE(moodboard_product,'$.search_engine') AS search_engine,


            -- calculated fields
            TIMESTAMP_DIFF(
            created_time,
            TIMESTAMP_SECONDS(
              SAFE_CAST(
                COALESCE(
                  JSON_VALUE(moodboard_product,'$.f_updates_at'),
                  JSON_VALUE(moodboard_product,'$.f_creates_at')
                )
              AS INT)
            ),
            SECOND
          ) AS time_gap,
          dt_param AS dt
    FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
    CROSS JOIN UNNEST(moodboard_products) AS moodboard_product
    WHERE DATE(created_time) = dt_param