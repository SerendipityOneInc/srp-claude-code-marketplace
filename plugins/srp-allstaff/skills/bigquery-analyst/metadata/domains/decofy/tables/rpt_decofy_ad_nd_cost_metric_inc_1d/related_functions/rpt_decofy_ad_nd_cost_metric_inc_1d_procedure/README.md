# rpt_decofy_ad_nd_cost_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-28
**最后更新**: 2025-09-28

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| x_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    DECLARE current_dt DATE;
    DECLARE start_dt DATE;
    
    -- 计算开始日期
    SET start_dt = DATE_SUB(dt_param, INTERVAL x_day DAY);
    SET current_dt = start_dt;
    
    -- 循环处理从 start_dt 到 dt_param 的每一天
    WHILE current_dt <= dt_param DO
        -- 删除当前日期的数据，避免重复插入
        DELETE FROM favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d
        WHERE dt = current_dt and n_day = 7;

        -- 插入当前日期的新数据
        INSERT INTO favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d (
            dt,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            n_day,
            ad_cost
        )
        SELECT
            dt,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            n_day,
            ad_cost
        FROM favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d_function(current_dt, 7);
        
        -- 移动到下一天
        SET current_dt = DATE_ADD(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
