# rpt_decofy_ad_nd_cost_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-09-25
**最后更新**: 2025-09-25

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dwd_growth_ad_total_by_source_inc_1d_view` (dwd_growth_ad_total_by_source_inc_1d_view)

---

## 💻 函数定义

```sql
SELECT
      dt,
      source as ad_source,
      ad_id,
      ad_group_id,
      campaign_id as ad_campaign_id,
      n_day as n_day,
      SUM(cost) as ad_cost
    FROM
      `srpproduct-dc37e.favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
    WHERE dt = dt_param
      AND app_name = 'Decofy'
    group by dt,ad_source,ad_id,ad_group_id,ad_campaign_id,n_day
```

---

**文档生成**: 2026-01-30 13:38:35
**扫描工具**: scan_functions.py
