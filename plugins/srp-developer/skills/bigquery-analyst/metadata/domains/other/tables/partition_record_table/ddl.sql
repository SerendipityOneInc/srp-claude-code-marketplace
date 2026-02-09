CREATE TABLE `srpproduct-dc37e.favie_dw.partition_record_table`
(
  dt DATE OPTIONS(description="数据日期，表示事件发生的日期"),
  table_name STRING OPTIONS(description="表名称，标识具体的数据表"),
  biz_condition STRING OPTIONS(description="业务条件，描述数据所属的业务场景或条件"),
  created_at TIMESTAMP OPTIONS(description="表创建时间，表示表的创建时间"),
  updated_at TIMESTAMP OPTIONS(description="表更新时间，表示表的最后更新时间")
)
PARTITION BY dt
CLUSTER BY table_name;