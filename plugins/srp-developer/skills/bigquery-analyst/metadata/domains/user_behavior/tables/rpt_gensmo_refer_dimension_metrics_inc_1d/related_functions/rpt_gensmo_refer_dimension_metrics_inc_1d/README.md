# rpt_gensmo_refer_dimension_metrics_inc_1d

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_dimension_metrics_inc_1d`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-04-12
**最后更新**: 2025-04-12

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
with gensmo_refer_metrics AS (
        SELECT
            refer,
            pre_refer,
            platform,
            app_version,
            native_version,
            COUNT(DISTINCT user_pseudo_id) AS uv,
            COUNTIF(event_name="select_item" and event_method = "page_view") AS pv1,
            COUNT(DISTINCT concat(user_pseudo_id,session_id,refer_pv_seq)) AS pv2,
            SUM(if(event_interval<30000,event_interval,0))/1000 AS duration,
            dt
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND event_version != "default"
        GROUP BY
            dt,refer,pre_refer,platform,app_version,native_version
    )

    select 
        refer,
        pre_refer,
        platform,
        app_version,
        native_version,
        pv2 as pv,
        uv,
        duration,
        dt
    from gensmo_refer_metrics
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
