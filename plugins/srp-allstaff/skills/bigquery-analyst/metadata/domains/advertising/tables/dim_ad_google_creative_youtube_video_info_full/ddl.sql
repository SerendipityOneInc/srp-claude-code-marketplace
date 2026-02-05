CREATE TABLE `srpproduct-dc37e.favie_dw.dim_ad_google_creative_youtube_video_info_full`
(
  video_url STRING OPTIONS(description="原始视频URL"),
  video_id STRING OPTIONS(description="解析出的视频ID"),
  video_name STRING OPTIONS(description="视频标题"),
  author_name STRING OPTIONS(description="YouTube频道名称"),
  video_created_at STRING OPTIONS(description="视频上传日期"),
  processed_at TIMESTAMP OPTIONS(description="数据更新时间")
);