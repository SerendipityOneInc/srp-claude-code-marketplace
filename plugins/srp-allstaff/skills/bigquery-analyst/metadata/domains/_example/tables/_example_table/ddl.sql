CREATE OR REPLACE TABLE `project.dataset.table_name`
PARTITION BY dt
AS
SELECT
    dt,
    field1,
    field2
FROM `project.dataset.source_table`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY);
