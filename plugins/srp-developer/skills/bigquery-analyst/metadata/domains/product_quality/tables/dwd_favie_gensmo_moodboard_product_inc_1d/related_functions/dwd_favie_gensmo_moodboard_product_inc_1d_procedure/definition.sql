BEGIN
    DECLARE current_dt DATE;
    SET current_dt = dt_param;

    WHILE n_day>=1 DO

        -- remove old data
        DELETE FROM favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d
        WHERE dt IS NOT NULL AND dt = current_dt;

        -- insert new data
        INSERT INTO favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d(
            moodboard_id,
            moodboard_task_id,
            moodboard_index,
            raw_query,
            moodboard_created_user_id,
            moodboard_user_gender,
            moodboard_created_time,
            moodboard_updated_time,
            moodboard_description,
            moodboard_is_feed,
            moodboard_is_try_on,
            moodboard_hashtags,
            moodboard_image_url,
            user_image_tag,
            user_image_url,
            user_image_description,
            moodboard_liked_count,
            moodboard_saved_count,
            moodboard_shared_count,
            intention,
            reasoning,
            is_onboard,
            moderation_status,
            publisher,
            product_id,
            product_created_time,
            product_updated_time,
            product_brand,
            product_norm_brand,
            product_brand_link,
            product_link,
            product_site,
            product_platform,
            product_title,
            product_collage_category,
            product_tags,
            product_display_image,
            product_main_image,
            qp_query,
            search_engine,
            time_gap,
            dt
        )
        SELECT 
            moodboard_id,
            moodboard_task_id,
            moodboard_index,
            raw_query,
            moodboard_created_user_id,
            moodboard_user_gender,
            moodboard_created_time,
            moodboard_updated_time,
            moodboard_description,
            moodboard_is_feed,
            moodboard_is_try_on,
            moodboard_hashtags,
            moodboard_image_url,
            user_image_tag,
            user_image_url,
            user_image_description,
            moodboard_liked_count,
            moodboard_saved_count,
            moodboard_shared_count,
            intention,
            reasoning,
            is_onboard,
            moderation_status,
            publisher,
            product_id,
            product_created_time,
            product_updated_time,
            product_brand,
            product_norm_brand,
            product_brand_link,
            product_link,
            product_site,
            product_platform,
            product_title,
            product_collage_category,
            product_tags,
            product_display_image,
            product_main_image,
            qp_query,
            search_engine,
            time_gap,
            dt
        FROM favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END