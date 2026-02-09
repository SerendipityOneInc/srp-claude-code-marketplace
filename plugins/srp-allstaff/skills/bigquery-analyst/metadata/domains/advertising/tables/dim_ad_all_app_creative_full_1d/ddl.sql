CREATE TABLE `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_full_1d`
(
  dt DATE NOT NULL OPTIONS(description="分区日期字段"),
  source STRING NOT NULL OPTIONS(description="数据来源，固定值为Tiktok"),
  app_name STRING OPTIONS(description="应用名称：Gensmo、Decofy或UNKNOWN"),
  account_id STRING OPTIONS(description="账户ID，对应advertiser_id"),
  account_name STRING OPTIONS(description="账户名称"),
  external_creative_id STRING OPTIONS(description="外部创意ID，对应image_id或video_id"),
  external_creative_name STRING OPTIONS(description="外部创意名称，对应file_name"),
  external_creative_url STRING OPTIONS(description="外部创意URL，对应image_url或preview_url"),
  external_creative_cover_url STRING OPTIONS(description="外部创意封面URL，仅视频有值"),
  creative_type STRING NOT NULL OPTIONS(description="创意类型：image或video"),
  creative_status STRING OPTIONS(description="创意状态, NORMAL,EXPIRED,UNKNOWN"),
  internal_creative_id STRING OPTIONS(description="内部创意ID"),
  format STRING OPTIONS(description="文件格式"),
  height INT64 OPTIONS(description="高度"),
  width INT64 OPTIONS(description="宽度"),
  size INT64 OPTIONS(description="文件大小"),
  creative_video_duration FLOAT64 OPTIONS(description="视频时长（秒），仅视频有值"),
  creative_allowed_placements STRING OPTIONS(description="允许的投放位置，仅视频有值"),
  creative_video_bit_rate FLOAT64 OPTIONS(description="视频比特率，仅视频有值"),
  updated_at TIMESTAMP OPTIONS(description="更新时间"),
  created_at TIMESTAMP OPTIONS(description="创建时间"),
  upload_r2_process_at STRING OPTIONS(description="上传到R2的处理时间")
)
PARTITION BY dt
CLUSTER BY source, app_name, creative_type
OPTIONS(
  partition_expiration_days=30.0,
  description="TikTok广告创意维度表完整版，存储图片和视频创意信息"
);