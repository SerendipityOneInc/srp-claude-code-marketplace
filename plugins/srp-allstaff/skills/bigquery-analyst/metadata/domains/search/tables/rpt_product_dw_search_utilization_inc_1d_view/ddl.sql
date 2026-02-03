CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_product_dw_search_utilization_inc_1d_view`
AS WITH max_date AS (
  SELECT MAX(dt) AS max_dt
  FROM favie_rpt.rpt_product_dw_search_metric_inc_1d_view
),

----------------------product_sku-------------------------------
valid_sku_uniq_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "product_sku" as data_name,
    "all valid skus" as data_level_name,
    0 as data_level_seq,
    valid_sku_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_rpt.rpt_product_dw_search_metric_inc_1d_view,max_date
),

d28_update_sku_uniq_cnt_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "product_sku" as data_name,
    "28 days updated skus" as data_level_name,
    1 as data_level_seq,
    d28_update_and_inc_sku_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_dw.dws_favie_product_data_cube_inc_1d_view,max_date
),

d7_update_sku_uniq_cnt_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "product_sku" as data_name,
    "7 days updated skus" as data_level_name,
    2 as data_level_seq,
    d7_update_and_inc_sku_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_dw.dws_favie_product_data_cube_inc_1d_view,max_date
),

----------------------product_spu-------------------------------
valid_spu_uniq_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "product_spu" as data_name,
    "all valid spus" as data_level_name,
    0 as data_level_seq,
    valid_spu_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_rpt.rpt_product_dw_search_metric_inc_1d_view,max_date
),

d28_update_spu_uniq_cnt_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "product_spu" as data_name,
    "28 days updated spus" as data_level_name,
    1 as data_level_seq,
    d28_update_and_inc_spu_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_dw.dws_favie_product_data_cube_inc_1d_view,max_date
),

d7_update_spu_uniq_cnt_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "product_spu" as data_name,
    "7 days updated spus" as data_level_name,
    2 as data_level_seq,
    d7_update_and_inc_spu_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_dw.dws_favie_product_data_cube_inc_1d_view,max_date
),

----------------------sku_utilization------------------------
gem_ha3_recall_sku_uniq_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "sku_utilization" as data_name,
    "ha3 recall skus" as data_level_name,
    0 as data_level_seq,
    gem_ha3_recall_sku_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_rpt.rpt_product_dw_search_metric_inc_1d_view,max_date
),

valid_gem_ha3_recall_sku_uniq_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "sku_utilization" as data_name,
    "valid ha3 recall skus" as data_level_name,
    1 as data_level_seq,
    valid_gem_ha3_recall_sku_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_rpt.rpt_product_dw_search_metric_inc_1d_view,max_date
),

gem_search_return_sku_uniq_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "sku_utilization" as data_name,
    "gem return skus" as data_level_name,
    2 as data_level_seq,
    gem_search_return_sku_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_rpt.rpt_product_dw_search_metric_inc_1d_view,max_date
),

gem_moodboard_sku_uniq_cnt_data as (
  select
    site_domain,
    site_top_domain,
    site_tier,
    site_rank,
    site_type,
    site_categories,
    site_parser_type,
    site_country_region,  
    "sku_utilization" as data_name,
    "gem moodboard skus" as data_level_name,
    3 as data_level_seq,
    gem_moodboard_sku_uniq_cnt as data_value,
    dt = max_dt as is_max_dt,
    dt
  from favie_rpt.rpt_product_dw_search_metric_inc_1d_view,max_date
)


-----------------------------------------product_sku----------------------------
select 
  *
from valid_sku_uniq_cnt_data
union all
select 
  *
from d28_update_sku_uniq_cnt_cnt_data
union all
select 
  *
from d7_update_sku_uniq_cnt_cnt_data
-----------------------------------------product_spu----------------------------
union all
select 
  *
from valid_spu_uniq_cnt_data
union all
select 
  *
from d28_update_spu_uniq_cnt_cnt_data
union all
select 
  *
from d7_update_spu_uniq_cnt_cnt_data
----------------------sku_utilization------------------------
-- union all
-- select 
--   *
-- from gem_ha3_recall_sku_uniq_cnt_data
-- union all
-- select 
--   *
-- from valid_gem_ha3_recall_sku_uniq_cnt_data
union all
select 
  *
from gem_search_return_sku_uniq_cnt_data
union all
select 
  *
from gem_moodboard_sku_uniq_cnt_data;