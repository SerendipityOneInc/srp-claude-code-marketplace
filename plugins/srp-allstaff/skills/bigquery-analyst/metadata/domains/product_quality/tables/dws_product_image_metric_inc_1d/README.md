# dws_product_image_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_product_image_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 12,273 行
**大小**: 0.00 GB
**创建时间**: 2026-01-04
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期 |
| site | STRING | NULLABLE | 站点 |
| site_tier | STRING | NULLABLE | 站点等级 |
| site_type | STRING | NULLABLE | 站点类型 |
| site_rank | STRING | NULLABLE | 站点排名 |
| site_categories | STRING | NULLABLE | 站点类别 |
| site_parser_type | STRING | NULLABLE | 站点解析类型 |
| site_country_region | STRING | NULLABLE | 站点国家或地区 |
| image_size_type | STRING | NULLABLE | 图片尺寸类别 |
| image_category | STRING | NULLABLE | 图片类别 |
| total_sku_cnt | INTEGER | NULLABLE | SKU总数 |
| total_spu_cnt | INTEGER | NULLABLE | SPU总数 |
| image_sku_cnt | INTEGER | NULLABLE | image的SKU数 |
| image_spu_cnt | INTEGER | NULLABLE | image的SPU数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_product_image_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:25
**扫描工具**: scan_metadata_v2.py
