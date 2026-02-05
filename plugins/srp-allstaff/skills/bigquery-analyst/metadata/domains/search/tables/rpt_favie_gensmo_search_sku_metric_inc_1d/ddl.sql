CREATE TABLE `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_search_sku_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段"),
  product_site STRING OPTIONS(description="商品所在站点标识，例如 site 名称"),
  product_shop_site STRING OPTIONS(description="商品所属店铺在站点内的标识（若有）"),
  gem_sku_raw_query_uniq_cnt INT64 OPTIONS(description="raw query 去重次数"),
  gem_sku_qp_query_uniq_cnt INT64 OPTIONS(description="qp query 去重次数"),
  gem_moodboard_sku_cnt INT64 OPTIONS(description="在 moodboard 中出现的 SKU 总次数（非去重）"),
  gem_moodboard_sku_uniq_cnt INT64 OPTIONS(description="在 moodboard 中出现的去重 SKU 数量"),
  gem_moodboard_1d_update_sku_cnt INT64 OPTIONS(description="过去 1 天内有更新的 SKU 次数（包含重复）"),
  gem_moodboard_1d_update_sku_uniq_cnt INT64 OPTIONS(description="过去 1 天内有更新的去重 SKU 数量"),
  gem_moodboard_7d_update_sku_cnt INT64 OPTIONS(description="过去 7 天内有更新的 SKU 次数（包含重复）"),
  gem_moodboard_7d_update_sku_uniq_cnt INT64 OPTIONS(description="过去 7 天内有更新的去重 SKU 数量"),
  gem_moodboard_28d_update_sku_cnt INT64 OPTIONS(description="过去 28 天内有更新的 SKU 次数（包含重复）"),
  gem_moodboard_28d_update_sku_uniq_cnt INT64 OPTIONS(description="过去 28 天内有更新的去重 SKU 数量"),
  gem_moodboard_p5_sku_seconds_amt INT64 OPTIONS(description="SKU 更新时长（moodboard 生成时间剪去 sku 更新时间）第 5 百分位（秒总量/统计量，视上游定义）"),
  gem_moodboard_p25_sku_seconds_amt INT64 OPTIONS(description="SKU 更新时长第 25 百分位（秒总量/统计量）"),
  gem_moodboard_p50_sku_seconds_amt INT64 OPTIONS(description="SKU 更新时长第 50 百分位/中位数（秒总量/统计量）"),
  gem_moodboard_p75_sku_seconds_amt INT64 OPTIONS(description="SKU 更新时长第 75 百分位（秒总量/统计量）"),
  gem_moodboard_p95_sku_seconds_amt INT64 OPTIONS(description="SKU 更新时长第 95 百分位（秒总量/统计量）"),
  inc_sku_uniq_cnt INT64 OPTIONS(description="该网站过去一天所有新增 SKU 去重数量"),
  update_sku_uniq_cnt INT64 OPTIONS(description="该网站过去一天所有更新 SKU 去重数量"),
  d7_update_and_inc_sku_uniq_cnt INT64 OPTIONS(description="该网站所有过去 7 天更新和新增的 SKU 去重数量"),
  d28_update_and_inc_sku_uniq_cnt INT64 OPTIONS(description="该网站所有过去 28 天更新和新增的 SKU 去重数量"),
  sku_uniq_cnt INT64 OPTIONS(description="该网站所有 SKU 去重数"),
  d7_inc_sku_uniq_cnt INT64 OPTIONS(description="该网站过去 7 天新增 SKU 去重数量"),
  d28_inc_sku_uniq_cnt INT64 OPTIONS(description="该网站过去 28 天新增 SKU 去重数量"),
  gem_moodboard_3d_update_sku_cnt INT64 OPTIONS(description="过去 3 天内有更新的 SKU 次数（包含重复）"),
  gem_moodboard_3d_update_sku_uniq_cnt INT64 OPTIONS(description="过去 3 天内有更新的去重 SKU 数量"),
  d3_update_and_inc_sku_uniq_cnt INT64 OPTIONS(description="该网站所有过去 3 天更新和新增的 SKU 去重数量"),
  d3_inc_sku_uniq_cnt INT64 OPTIONS(description="该网站过去 3 天新增 SKU 去重数量")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);