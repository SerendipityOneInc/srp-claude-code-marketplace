CREATE VIEW `srpproduct-dc37e.favie_dw.favie_product_detail_bigtable_external_flat_view`
AS SELECT
  rowkey,
  m_base_column.name as name,
  m_base_column.cell.value as value,
  m_sys_column.name as sys_name,
  m_sys_column.cell.value as sys_value
FROM
  favie_dw.favie_product_detail_bigtable_external,
  UNNEST(m_base.column) as m_base_column,
  UNNEST(m_sys.column) as m_sys_column;