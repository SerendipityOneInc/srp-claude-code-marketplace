# dws_favie_gensmo_search_query_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_search_query_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-27
**最后更新**: 2025-10-27

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN 

    DECLARE current_dt DATE;
    SET current_dt = dt_param;

    while n_day>=1 do
    -- Remove old data for the given date
        DELETE FROM favie_dw.dws_favie_gensmo_search_query_metric_inc_1d
        WHERE dt IS NOT NULL AND dt = current_dt;

        -- Insert new data for the given date
        INSERT INTO favie_dw.dws_favie_gensmo_search_query_metric_inc_1d(
            raw_query,
            qp_query,
            query_modality,
            raw_query_word_amt,
            qp_query_word_amt,
            query_cnt,
            dt
        )
        SELECT 
            raw_query,
            qp_query,
            query_modality,
            raw_query_word_amt,
            qp_query_word_amt,
            query_cnt,
            dt
        FROM favie_dw.dws_favie_gensmo_search_query_metric_inc_1d_function(current_dt);    
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;  
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
