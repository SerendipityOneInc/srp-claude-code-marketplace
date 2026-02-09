# dim_ad_all_app_creative_tiktok_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_tiktok_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-07
**最后更新**: 2025-07-07

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
  -- 删除指定日期的数据
  DELETE FROM `favie_dw.dim_ad_all_app_creative_tiktok_inc_1d` WHERE dt = base_date;
  
  -- 插入新数据
  INSERT INTO `favie_dw.dim_ad_all_app_creative_tiktok_inc_1d` (
    dt,
    source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    creative_type,
    internal_creative_id,
    format,
    height,
    width,
    size,
    updated_at,
    created_at,
    upload_r2_process_at
  )
  SELECT 
    dt,
    source,
    app_name,
    account_id,
    account_name,
    external_creative_id,
    external_creative_name,
    external_creative_url,
    creative_type,
    internal_creative_id,
    format,
    height,
    width,
    size,
    updated_at,
    created_at,
    upload_r2_process_at
  FROM `favie_dw.dim_ad_all_app_creative_tiktok_inc_1d_function`(base_date);
  
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
