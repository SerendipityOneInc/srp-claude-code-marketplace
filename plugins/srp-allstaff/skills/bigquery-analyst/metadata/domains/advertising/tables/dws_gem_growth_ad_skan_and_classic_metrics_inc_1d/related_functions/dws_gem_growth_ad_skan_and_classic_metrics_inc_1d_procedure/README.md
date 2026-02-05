# dws_gem_growth_ad_skan_and_classic_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-11-03
**最后更新**: 2025-11-03

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
  DECLARE current_dt DATE;
  DECLARE start_dt DATE;
  DECLARE day_counter INT64;
  
  -- 计算开始日期：dt_param 减去 (n-1) 天
  SET start_dt = DATE_SUB(dt_param, INTERVAL (n - 1) DAY);
  
  -- 初始化计数器
  SET day_counter = 0;
  
  -- 循环处理n天数据（从 start_dt 到 dt_param，正序）
  WHILE day_counter < n DO
    -- 计算当前处理日期：从 start_dt 开始正序递增
    SET current_dt = DATE_ADD(start_dt, INTERVAL day_counter DAY);
    
    -- 删除当前日期的数据
    DELETE FROM `favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d` 
    WHERE dt = current_dt;

    -- 插入当前日期的新数据
    INSERT INTO `favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d` (
      dt
      ,source
      ,platform
      ,app_name
      ,account_id
      ,account_name
      ,campaign_id
      ,campaign_name
      ,ad_group_id
      ,ad_group_name
      ,ad_id
      ,ad_name
      ,ad_category
      ,country_code
      ,channel
      ,attribution_method
      ,account_put_type
      ,account_open_agency
      ,impression
      ,click
      ,conversion
      ,cost
      ,install_cnt
      ,new_user_cnt
      ,d0_active_cnt
      ,d1_retention_cnt
      ,lt7_cnt
    )
    SELECT 
      dt
      ,source
      ,platform
      ,app_name
      ,account_id
      ,account_name
      ,campaign_id
      ,campaign_name
      ,ad_group_id
      ,ad_group_name
      ,ad_id
      ,ad_name
      ,ad_category
      ,country_code
      ,channel
      ,attribution_method
      ,account_put_type
      ,account_open_agency
      ,impression
      ,click
      ,conversion
      ,cost
      ,install_cnt
      ,new_user_cnt
      ,d0_active_cnt
      ,d1_retention_cnt
      ,lt7_cnt
    FROM `favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d_function`(current_dt);
    
    -- 递增计数器，处理下一天
    SET day_counter = day_counter + 1;
  END WHILE;
  
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
