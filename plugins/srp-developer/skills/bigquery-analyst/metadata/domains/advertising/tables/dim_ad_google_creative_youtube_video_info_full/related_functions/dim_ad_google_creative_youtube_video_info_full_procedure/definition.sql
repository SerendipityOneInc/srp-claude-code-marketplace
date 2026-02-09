BEGIN

    -- 1. 使用 MERGE 语句将新数据合并到目标表
    MERGE INTO `favie_dw.dim_ad_google_creative_youtube_video_info_full` AS target
    USING (
        -- 从 function 中获取源数据
        -- 注意：如果 function 有参数需要传入参数，这里假设 function 没有参数或使用默认值
        -- 如果 function 需要 date 参数，可以写成: `favie_dw.dim_ad_google_creative_youtube_video_info_full_function`(run_date)
        SELECT
             video_url
            ,video_id
            ,video_name
            ,author_name
            ,video_created_at
        FROM `favie_dw.dim_ad_google_creative_youtube_video_info_full_initial_view`
        -- 过滤掉无效的 video_id
        WHERE video_id IS NOT NULL AND video_id != ''
    ) AS source
    ON target.video_id = source.video_id

    -- 2. 当不匹配时（目标表中不存在），插入新记录
    WHEN NOT MATCHED THEN
        INSERT (
             video_url
            ,video_id
            ,video_name
            ,author_name
            ,video_created_at
            ,processed_at
        )
        VALUES (
             source.video_url
            ,source.video_id
            ,source.video_name
            ,source.author_name
            ,source.video_created_at
            ,CURRENT_TIMESTAMP()
        );

END