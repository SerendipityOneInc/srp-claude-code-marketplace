# dwd_gem_product_detail_ha3_base_delete_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_base_delete_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2026-01-07
**最后更新**: 2026-01-07

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_archive_inc_1d` (dwd_favie_product_detail_archive_inc_1d)

---

## 💻 函数定义

```sql
with all_delete as (
        SELECT 
            f_sku_id 
        FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_archive_inc_1d`
        WHERE date(dt) = dt_param
        union all 
        select 
            f_sku_id
        from favie_dw.dwd_gem_product_detail_ha3_inc_1h
        where dt = date_add(dt_param, interval 1 day)
            and CMD = 'delete'
    )
    select 
        distinct f_sku_id
    from all_delete
```

---

**文档生成**: 2026-01-30 13:41:13
**扫描工具**: scan_functions.py
