CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gem_feed_tags_fail_metric_inc_1d_view`
AS SELECT 
        COUNTIF(ARRAY_LENGTH(style_1) = 0) AS style_1_fail,  -- style_1 数组长度为 0
        COUNTIF(ARRAY_LENGTH(style_2) = 0) AS style_2_fail,  -- style_2 数组长度为 0
        COUNTIF(ARRAY_LENGTH(occasion_1) = 0) AS occasion_1_fail,  -- occasion_1 数组长度为 0
        COUNTIF(ARRAY_LENGTH(occasion_2) = 0) AS occasion_2_fail,  -- occasion_2 数组长度为 0
        COUNTIF(ARRAY_LENGTH(color) = 0) AS color_fail,  -- color 数组长度为 0
        COUNTIF(ARRAY_LENGTH(temperature) = 0) AS temperature_fail,  -- temperature 数组长度为 0
        COUNTIF(ARRAY_LENGTH(weather) = 0) AS weather_fail,  -- weather 数组长度为 0
        COUNTIF(ARRAY_LENGTH(gender) = 0) AS gender_fail,  -- gender 数组长度为 0
        COUNTIF(ARRAY_LENGTH(age) = 0) AS age_fail,  -- age 数组长度为 0
        COUNTIF(ARRAY_LENGTH(body_size) = 0) AS body_size_fail,  -- body_size 数组长度为 0
        COUNTIF(ARRAY_LENGTH(body_shape) = 0) AS body_shape_fail,  -- body_shape 数组长度为 0
        COUNTIF(ARRAY_LENGTH(height) = 0) AS height_fail  -- height 数组长度为 0
    FROM favie_dw.dwd_gem_feed_tags_full_view;