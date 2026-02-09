BEGIN
  -- 删除指定日期的数据
  DELETE FROM `favie_dw.dim_ad_all_app_creative_tiktok_inc_1d` WHERE dt = base_date;
  
  -- 插入新数据
  INSERT INTO `favie_dw.dim_ad_all_app_creative_tiktok_inc_1d` (
    dt,
    source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    creative_type,
    internal_creative_id,
    format,
    height,
    width,
    size,
    updated_at,
    created_at,
    upload_r2_process_at
  )
  SELECT 
    dt,
    source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    creative_type,
    internal_creative_id,
    format,
    height,
    width,
    size,
    updated_at,
    created_at,
    upload_r2_process_at
  FROM `favie_dw.dim_ad_all_app_creative_tiktok_inc_1d_function`(base_date);
  
END