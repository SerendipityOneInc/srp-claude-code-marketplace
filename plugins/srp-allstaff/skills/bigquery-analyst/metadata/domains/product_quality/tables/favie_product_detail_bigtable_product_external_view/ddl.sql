CREATE VIEW `srpproduct-dc37e.favie_dw.favie_product_detail_bigtable_product_external_view`
AS select 
  rowkey,
  case when hfreq_cf.column[offset(0)].name = "f_sku_id" then hfreq_cf.column[offset(0)].cell.value end as f_sku_id,
  case when hfreq_cf.column[offset(0)].name = "f_spu_id" then hfreq_cf.column[offset(0)].cell.value end as f_spu_id,
  case when hfreq_cf.column[offset(0)].name = "sku_id" then hfreq_cf.column[offset(0)].cell.value end as sku_id,
  case when hfreq_cf.column[offset(0)].name = "spu_id" then hfreq_cf.column[offset(0)].cell.value end as spu_id,
  case when hfreq_cf.column[offset(0)].name = "site" then hfreq_cf.column[offset(0)].cell.value end as site
from favie_dw.favie_product_detail_bigtable_product_external;