# rpt_decofy_growth_management_dashboard_v3_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v3_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-04
**最后更新**: 2025-09-04

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| base_date | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
  -- 计算full_dt：当前日期-1（最新一天的数据）

  
  -- 刷新8个日期的数据：base_date-0 到 base_date-7
  -- 按照正确顺序处理：先刷 base_date-7，最后刷 base_date
  
  DECLARE dt_param DATE;
  DECLARE dates ARRAY<INT64> DEFAULT [14,13,12,11,10,9,8,7, 6, 5, 4, 3, 2, 1, 0]; -- 14天前到当天
  DECLARE i INT64 DEFAULT 0;
  
  WHILE i < ARRAY_LENGTH(dates) DO
    SET dt_param = DATE_SUB(base_date, INTERVAL dates[OFFSET(i)] DAY);
    
    -- 删除指定日期的数据
    DELETE FROM `favie_rpt.rpt_decofy_growth_management_dashboard_v4_inc_1d` WHERE dt = dt_param;
    
    -- 插入新数据
    INSERT INTO `favie_rpt.rpt_decofy_growth_management_dashboard_v4_inc_1d` (
      dt,
      source,
      platform,
      app_name,
      account_id,
      account_name,
      campaign_id,
      campaign_name,
      ad_group_id,
      ad_group_name,
      ad_id,
      ad_name,
      country_code,
      channel,
      impression,
      click,
      conversion,
      cost,
      install_cnt,
      user_cnt,
      real_order_paid_amount_7d,
      real_order_paid_amount_30d,
      is_first_order_7d,
      order_cnt,
      paid_order_cnt,
      subscribed_user,
      paid_user,
      attribution_7d_benefit_order_7d,
      attribution_7d_trail_order_7d,
      attribution_7d_normal_order_7d,
      attribution_365d_benefit_order_7d,
      attribution_365d_trail_order_7d,
      attribution_365d_normal_order_7d
    )
    SELECT 
      dt,
      source,
      platform,
      app_name,
      account_id,
      account_name,
      campaign_id,
      campaign_name,
      ad_group_id,
      ad_group_name,
      ad_id,
      ad_name,
      country_code,
      channel,
      impression,
      click,
      conversion,
      cost,
      install_cnt,
      user_cnt,
      real_order_paid_amount_7d,
      real_order_paid_amount_30d,
      is_first_order_7d,
      order_cnt,
      paid_order_cnt,
      subscribed_user,
      paid_user,
      attribution_7d_benefit_order_7d,
      attribution_7d_trail_order_7d,
      attribution_7d_normal_order_7d,
      attribution_365d_benefit_order_7d,
      attribution_365d_trail_order_7d,
      attribution_365d_normal_order_7d
    FROM `favie_rpt.rpt_decofy_growth_management_dashboard_v4_inc_1d_function`( dt_param);
    
    SET i = i + 1;
  END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
