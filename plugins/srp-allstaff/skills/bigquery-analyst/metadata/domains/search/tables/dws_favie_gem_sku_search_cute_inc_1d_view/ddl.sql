CREATE VIEW `srpproduct-dc37e.favie_dw.dws_favie_gem_sku_search_cute_inc_1d_view`
AS WITH dwd_favie_gem_product_data as (
  select 
    trace_id,
    raw_query,
    ha3_query,
    query_type,
    is_default,
    product_sku_id,
    coalesce(product_site,REGEXP_EXTRACT(product_sku_id, r'-([^-]*)$')) as product_site,
    product_score,
    moodboard_id,
    moodboard_timestamp,
    moodboard_seq,
    safe_cast(product_updates_at as int64) as product_updates_at,
    safe_cast(product_creates_at as int64) as product_creates_at,
    is_retrieval,
    dt
  from favie_dw.dwd_favie_gem_product_search_inc_1d 
  where search_engine = "ha3" 
    and raw_query is not null
),

dwd_favie_gem_product_data_join_site_dim AS (
  SELECT 
    t1.trace_id AS trace_id,
    t1.raw_query AS raw_query,
    t1.ha3_query AS ha3_query,
    t1.query_type AS query_type,
    t1.is_default AS is_default,
    t1.product_sku_id AS product_sku_id,
    t1.product_updates_at as product_updates_at,
    t1.product_creates_at as product_creates_at,
    t1.product_site AS product_site,
    t1.product_score as product_score,
    t1.is_retrieval as is_retrieval,
    t1.moodboard_id as moodboard_id,
    UNIX_SECONDS(t1.moodboard_timestamp) as moodboard_at,
    t1.moodboard_seq as moodboard_seq,
    IF(t2.site_top_domain IS NULL, REGEXP_EXTRACT(t1.product_site, r'([^.]+\.[^.]+)$'), t2.site_top_domain) AS site_top_domain,
    IF(t2.site_tier IS NULL, "Other", t2.site_tier) AS site_tier,
    IF(t2.site_type IS NULL, "Other", t2.site_type) AS site_type,
    IF(t2.site_categories IS NULL, "Other", t2.site_categories) AS site_categories,
    IF(t2.site_parser_type IS NULL, "Other", t2.site_parser_type) AS site_parser_type,
    IF(t2.site_country_region IS NULL, "Other", t2.site_country_region) AS site_country_region,
    t1.dt AS dt
  FROM dwd_favie_gem_product_data t1 
  LEFT OUTER JOIN `favie_dw.dim_site_mut_view` t2
  ON t1.product_site = t2.site_domain_without_www
),

dwd_favie_gem_product_moodboard_data_join_site_dim as (
  SELECT
    *,
    row_number() over (partition by product_site order by product_updates_at desc) as row_no,
  from dwd_favie_gem_product_data_join_site_dim
  where moodboard_id is not null
),

dwd_favie_gem_moodboard_id_with_max_row_no as (
  select 
    product_site,
    max(row_no) as max_row_no
  from dwd_favie_gem_product_moodboard_data_join_site_dim
  group by product_site
),

rpt_favie_gem_sku_search_cube_tmp_normal as (
  SELECT 
    product_site,
    site_top_domain,
    site_tier,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,
    "Other" as user_country,
    "Other" as user_language,
    "Other" as user_device_os,
    "Other" as user_type,
    "Other" as user_register_type,
    COUNT(distinct trace_id) AS gem_sku_raw_query_cnt,
    COUNT(distinct raw_query) AS gem_sku_raw_query_uniq_cnt,
    COUNT(distinct concat(trace_id,ha3_query)) AS gem_sku_ha3_query_cnt,
    COUNT(distinct ha3_query) AS gem_sku_ha3_query_uniq_cnt,
    COUNT(product_sku_id) AS gem_ha3_recall_sku_cnt,
    COUNT(distinct product_sku_id) AS gem_ha3_recall_sku_uniq_cnt,
    COUNT(if(product_score>0,product_sku_id,null)) AS valid_gem_ha3_recall_sku_cnt,
    COUNT(distinct if(product_score>0,product_sku_id,null)) AS valid_gem_ha3_recall_sku_uniq_cnt,
    COUNT(if(is_retrieval,product_sku_id,null)) AS gem_search_retrieval_sku_cnt,
    COUNT(distinct if(is_retrieval,product_sku_id,null)) AS gem_search_retrieval_sku_uniq_cnt,
    dt
  FROM dwd_favie_gem_product_data_join_site_dim
  GROUP BY dt, product_site, site_top_domain, site_tier, site_type, site_categories,site_parser_type,site_country_region
),

rpt_favie_gem_sku_search_cube_tmp_moodboard as (
  SELECT 
    t1.product_site as product_site,
    t1.site_top_domain,
    t1.site_tier,
    t1.site_type,
    t1.site_categories,
    t1.site_parser_type,
    t1.site_country_region,
    "Other" as user_country,
    "Other" as user_language,
    "Other" as user_device_os,
    "Other" as user_type,
    "Other" as user_register_type,
    COUNT(t1.product_sku_id) AS gem_moodboard_sku_cnt,
    COUNT(distinct t1.product_sku_id) AS gem_moodboard_sku_uniq_cnt,
    COUNT(if(t1.moodboard_seq is not null and t1.moodboard_seq = 1,t1.product_sku_id,null)) AS first_gem_moodboard_sku_cnt,
    COUNT(distinct if(t1.moodboard_seq is not null and t1.moodboard_seq = 1,t1.product_sku_id,null)) AS first_gem_moodboard_sku_uniq_cnt,  
    COUNT(if(t1.moodboard_at - t1.product_updates_at <= 86400 ,t1.product_sku_id,null)) AS gem_moodboard_1d_update_sku_cnt,
    COUNT(if(t1.moodboard_at - t1.product_updates_at <= 86400 * 7,t1.product_sku_id,null)) AS gem_moodboard_7d_update_sku_cnt,
    COUNT(if(t1.moodboard_at - t1.product_updates_at <= 86400 * 28,t1.product_sku_id,null)) AS gem_moodboard_28d_update_sku_cnt,
    max(if(t1.row_no = cast(ceil(t2.max_row_no*0.05) as int64),t1.moodboard_at - t1.product_updates_at,null)) AS gem_moodboard_p5_sku_seconds_amt,
    max(if(t1.row_no = cast(ceil(t2.max_row_no*0.25) as int64),t1.moodboard_at - t1.product_updates_at,null)) AS gem_moodboard_p25_sku_seconds_amt,
    max(if(t1.row_no = cast(ceil(t2.max_row_no*0.50) as int64),t1.moodboard_at - t1.product_updates_at,null)) AS gem_moodboard_p50_sku_seconds_amt,
    max(if(t1.row_no = cast(ceil(t2.max_row_no*0.75) as int64),t1.moodboard_at - t1.product_updates_at,null)) AS gem_moodboard_p75_sku_seconds_amt,
    max(if(t1.row_no = cast(ceil(t2.max_row_no*0.95) as int64),t1.moodboard_at - t1.product_updates_at,null)) AS gem_moodboard_p95_sku_seconds_amt,
    dt
  FROM dwd_favie_gem_product_moodboard_data_join_site_dim t1 left outer join dwd_favie_gem_moodboard_id_with_max_row_no t2
  ON t1.product_site = t2.product_site
  GROUP BY t1.dt, t1.product_site, t1.site_top_domain, t1.site_tier, t1.site_type, t1.site_categories,site_parser_type,site_country_region
)

select 
  t1.product_site as product_site,
  t1.site_top_domain as site_top_domain,
  t1.site_tier as site_tier,
  t1.site_type as site_type,
  t1.site_categories as site_categories,
  t1.site_parser_type as site_parser_type,
  t1.site_country_region as site_country_region,
  t1.user_country as user_country,
  t1.user_language as user_language,
  t1.user_device_os as user_device_os,
  t1.user_type as user_type,
  t1.user_register_type as user_register_type,
  t1.gem_sku_raw_query_cnt as gem_sku_raw_query_cnt,
  t1.gem_sku_raw_query_uniq_cnt as gem_sku_raw_query_uniq_cnt,
  t1.gem_sku_ha3_query_cnt as gem_sku_ha3_query_cnt,
  t1.gem_sku_ha3_query_uniq_cnt as gem_sku_ha3_query_uniq_cnt,
  t1.gem_ha3_recall_sku_cnt as gem_ha3_recall_sku_cnt,
  t1.gem_ha3_recall_sku_uniq_cnt as gem_ha3_recall_sku_uniq_cnt,
  t1.valid_gem_ha3_recall_sku_cnt as valid_gem_ha3_recall_sku_cnt,
  t1.valid_gem_ha3_recall_sku_uniq_cnt as valid_gem_ha3_recall_sku_uniq_cnt,
  t1.gem_search_retrieval_sku_cnt as gem_search_retrieval_sku_cnt,
  t1.gem_search_retrieval_sku_uniq_cnt as gem_search_retrieval_sku_uniq_cnt,
  t2.gem_moodboard_sku_cnt as gem_moodboard_sku_cnt,
  t2.gem_moodboard_sku_uniq_cnt as gem_moodboard_sku_uniq_cnt,
  t2.first_gem_moodboard_sku_cnt as first_gem_moodboard_sku_cnt,
  t2.first_gem_moodboard_sku_uniq_cnt as first_gem_moodboard_sku_uniq_cnt,
  t2.gem_moodboard_1d_update_sku_cnt as gem_moodboard_1d_update_sku_cnt,
  t2.gem_moodboard_7d_update_sku_cnt as gem_moodboard_7d_update_sku_cnt,
  t2.gem_moodboard_28d_update_sku_cnt as gem_moodboard_28d_update_sku_cnt,
  t2.gem_moodboard_p5_sku_seconds_amt as gem_moodboard_p5_sku_seconds_amt,
  t2.gem_moodboard_p25_sku_seconds_amt as gem_moodboard_p25_sku_seconds_amt,
  t2.gem_moodboard_p50_sku_seconds_amt as gem_moodboard_p50_sku_seconds_amt,
  t2.gem_moodboard_p75_sku_seconds_amt as gem_moodboard_p75_sku_seconds_amt,
  t2.gem_moodboard_p95_sku_seconds_amt as gem_moodboard_p95_sku_seconds_amt,
  t1.dt as dt
from rpt_favie_gem_sku_search_cube_tmp_normal t1 left outer join rpt_favie_gem_sku_search_cube_tmp_moodboard t2
on t1.dt = t2.dt
  and t1.product_site = t2.product_site
  and t1.site_top_domain = t2.site_top_domain
  and t1.site_tier = t2.site_tier
  and t1.site_type = t2.site_type
  and t1.site_categories = t2.site_categories
  and t1.site_parser_type = t2.site_parser_type
  and t1.site_country_region = t2.site_country_region
  and t1.user_country = t2.user_country
  and t1.user_language = t2.user_language
  and t1.user_device_os = t2.user_device_os
  and t1.user_type = t2.user_type
  and t1.user_register_type = t2.user_register_type;