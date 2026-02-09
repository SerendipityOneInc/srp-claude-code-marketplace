# dim_favie_appsflyer_user_ad_source_full_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_user_ad_source_full_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-08-14
**最后更新**: 2025-08-14

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| target_date | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
  DELETE FROM `favie_dw.dim_favie_appsflyer_user_ad_source_full_1d`
  WHERE dt = target_date;

  INSERT INTO `favie_dw.dim_favie_appsflyer_user_ad_source_full_1d`
  (
    dt,
    created_date,
    appsflyer_id,
    source,
    channel,
    platform,
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    ad_id,
    ad_name,
    country_code,
    event_name,
    app_name
  )
  SELECT
    dt,
    created_date,
    appsflyer_id,
    source,
    channel,
    platform,
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    ad_id,
    ad_name,
    country_code,
    event_name,
    app_name
  FROM `favie_dw.dim_favie_appsflyer_user_ad_source_full_1d_function`(target_date);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
