# rpt_favie_crawl_daily_host_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d_procedure`
**类型**: PROCEDURE
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
BEGIN
  -- 1. 先删除这一天已有的数据，避免重复 & 支持重跑
  DELETE FROM `favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d`
  WHERE dt = dt_param;

  -- 2. 插入 function 计算出的这一天所有 host 指标
  INSERT INTO `favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d` (
    dt,
    host,
    success_cnt,
    failed_cnt,
    duplicate_cnt,
    not_found_cnt,
    delisted_cnt,
    parse_failed_cnt,
    total_cnt
  )
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
  FROM `favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d_function`(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
