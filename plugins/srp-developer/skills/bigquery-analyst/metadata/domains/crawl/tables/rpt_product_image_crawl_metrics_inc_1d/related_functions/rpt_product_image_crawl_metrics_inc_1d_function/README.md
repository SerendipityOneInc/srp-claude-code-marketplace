# rpt_product_image_crawl_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_product_image_crawl_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-11
**最后更新**: 2025-10-11

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
select 
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        image_category,
        count(distinct image_link) as download_image_cnt,
        count(distinct f_sku_id) as download_image_sku_cnt
    from favie_dw.dwd_product_image_crawl_inc_1d
    where dt = dt_param
    group by 
        dt,
        site,
        shop_site,
        uploader_type,
        status,
        image_category
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
