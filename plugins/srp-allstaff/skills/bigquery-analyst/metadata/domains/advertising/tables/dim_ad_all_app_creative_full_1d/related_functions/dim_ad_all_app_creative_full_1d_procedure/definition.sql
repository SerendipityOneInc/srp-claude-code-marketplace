BEGIN
  delete from `favie_dw.dim_ad_all_app_creative_full_1d` where dt=base_date;
  -- 插入新数据
  INSERT INTO `favie_dw.dim_ad_all_app_creative_full_1d` (
    dt,
    source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    external_creative_cover_url,
    creative_type,
    creative_status,
    internal_creative_id,
    format,
    height,
    width,
    size,
    creative_video_duration,
    creative_allowed_placements,
    creative_video_bit_rate,
    updated_at,
    created_at,
    upload_r2_process_at
  )

 

 select 
    base_date,
    coalesce(a.source,b.source) as source,
    coalesce(a.app_name,b.app_name) as app_name,
    coalesce(a.account_id,b.account_id) as account_id,
    coalesce(a.account_name,b.account_name) as account_name,
    coalesce(a.external_creative_id,b.external_creative_id) as external_creative_id,
    coalesce(a.external_creative_name,b.external_creative_name) as external_creative_name,
    coalesce(b.external_creative_url,a.external_creative_url) as external_creative_url,
    coalesce(b.external_creative_cover_url,a.external_creative_cover_url) as external_creative_cover_url,
    coalesce(a.creative_type,b.creative_type) as creative_type,
    coalesce(a.creative_status,b.creative_status) as creative_status,
    coalesce(a.internal_creative_id,b.internal_creative_id) as internal_creative_id,
    coalesce(a.format,b.format) as format,
    coalesce(a.height,b.height) as height,
    coalesce(a.width,b.width) as width,
    coalesce(a.size,b.size) as size,
    coalesce(a.creative_video_duration,b.creative_video_duration) as creative_video_duration,
    coalesce(a.creative_allowed_placements,b.creative_allowed_placements) as creative_allowed_placements,
    coalesce(a.creative_video_bit_rate,b.creative_video_bit_rate) as creative_video_bit_rate,
    coalesce(a.updated_at,b.updated_at) as updated_at,
    coalesce(a.created_at,b.created_at) as created_at,
    coalesce(a.upload_r2_process_at,b.upload_r2_process_at) as upload_r2_process_at
 from (
  select 
  source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    external_creative_cover_url,
    creative_type,
    creative_status,
    internal_creative_id,
    format,
    height,
    width,
    size,
    creative_video_duration,
    creative_allowed_placements,
    creative_video_bit_rate,
    updated_at,
    created_at,
    upload_r2_process_at,
  from (
  select 
    
    source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    external_creative_cover_url,
    creative_type,
    creative_status,
    internal_creative_id,
    format,
    height,
    width,
    size,
    creative_video_duration,
    creative_allowed_placements,
    creative_video_bit_rate,
    updated_at,
    created_at,
    upload_r2_process_at,
    row_number() over(partition by  external_creative_id order by case when creative_status='normal' then 1 else 0 end desc ) as rk 
  from srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_full_1d 
  where dt=(select max(dt) from srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_full_1d ) )
  where rk=1
  
   )a 
  full join (
    SELECT 
    
    source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    external_creative_cover_url,
    creative_type,
    creative_status,
    internal_creative_id,
    format,
    height,
    width,
    size,
    creative_video_duration,
    creative_allowed_placements,
    creative_video_bit_rate,
    updated_at,
    created_at,
    upload_r2_process_at
  FROM `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_full_1d_function`(base_date)
  
  )b 
  on  a.external_creative_id=b.external_creative_id and a.source=b.source
  and a.creative_type=b.creative_type;
  
  

  
  

  
END