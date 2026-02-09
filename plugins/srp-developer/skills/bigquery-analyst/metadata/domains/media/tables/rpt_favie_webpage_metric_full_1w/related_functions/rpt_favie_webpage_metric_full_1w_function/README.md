# rpt_favie_webpage_metric_full_1w_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_webpage_metric_full_1w_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-17
**最后更新**: 2025-12-17

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
WITH rpt_favie_webpage_data AS (
        SELECT
            dt,
            domain,
            md5_id,
            favie_dw.get_spider_update_time(f_meta) AS updates_time,
            TIMESTAMP_SECONDS(safe_cast(create_time as int64)) AS creates_time
        FROM `favie_dw.dwd_favie_webpage_full_1d`
        WHERE dt is not null 
            and date(dt) = dt_param
    ),

    rpt_favie_webpage_cube AS (
        SELECT 
            dt,
            domain,
            count(1) as total_webpage_num,
            count(IF(date(creates_time) > DATE_SUB(dt_param, INTERVAL 7 DAY) and date(creates_time) <= dt_param , md5_id, NULL)) AS weekly_new_webpage_num,
            count(IF(date(creates_time) <= DATE_SUB(dt_param, INTERVAL 7 DAY) and date(updates_time) > DATE_SUB(dt_param, INTERVAL 7 DAY) and date(updates_time) <= dt_param, md5_id, NULL)) AS weekly_update_webpage_num,
        FROM rpt_favie_webpage_data
        GROUP BY dt,domain
    )

    select 
        domain,
        total_webpage_num,
        weekly_new_webpage_num,
        weekly_update_webpage_num,
        dt_param AS dt
    from rpt_favie_webpage_cube
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
