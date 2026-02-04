# rpt_favie_crawl_daily_host_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-11-26
**最后更新**: 2025-11-26

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH base AS (
    SELECT
      dt,
      host,
      crawl_status,
      COUNT(1) AS status_cnt
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_spider_status_inc_1d`
    -- 原始表里的 dt 是 'YYYY-MM-DD' 字符串，这里用 FORMAT_DATE 对齐传入的 dt_param
    WHERE dt = FORMAT_DATE('%Y-%m-%d', dt_param)
    GROUP BY dt, host, crawl_status
  ),

  -- 2. pivot 成 host 级别的宽表，聚合出各个状态的 cnt 和 total_cnt
  pivoted AS (
    SELECT
      dt_param AS dt,
      host,

      SUM(CASE WHEN crawl_status = 'success'      THEN status_cnt ELSE 0 END) AS success_cnt,
      SUM(CASE WHEN crawl_status = 'failed'       THEN status_cnt ELSE 0 END) AS failed_cnt,
      SUM(CASE WHEN crawl_status = 'duplicate'    THEN status_cnt ELSE 0 END) AS duplicate_cnt,
      SUM(CASE WHEN crawl_status = 'not found'    THEN status_cnt ELSE 0 END) AS not_found_cnt,
      SUM(CASE WHEN crawl_status = 'delisted'     THEN status_cnt ELSE 0 END) AS delisted_cnt,
      SUM(CASE WHEN crawl_status = 'parse failed' THEN status_cnt ELSE 0 END) AS parse_failed_cnt,

      SUM(status_cnt) AS total_cnt
    FROM base
    GROUP BY dt, host
  )

  -- 3. 输出列顺序要和 RPT 表结构一致
  SELECT
    dt,
    host,
    success_cnt,
    failed_cnt,
    duplicate_cnt,
    not_found_cnt,
    delisted_cnt,
    parse_failed_cnt,
    total_cnt
  FROM pivoted
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
