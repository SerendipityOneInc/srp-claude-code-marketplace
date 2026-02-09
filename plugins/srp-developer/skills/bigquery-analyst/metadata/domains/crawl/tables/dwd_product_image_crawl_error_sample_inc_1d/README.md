# dwd_product_image_crawl_error_sample_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_product_image_crawl_error_sample_inc_1d`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 4,124 行
**大小**: 0.00 GB
**创建时间**: 2025-10-11
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| site | STRING | NULLABLE | 商品站点名称 |
| shop_site | STRING | NULLABLE | 商品店铺站点名称 |
| uploader_type | STRING | NULLABLE | 图片上传方式 |
| status | STRING | NULLABLE | 图片状态 |
| f_sku_id | STRING | NULLABLE | 商品SKU |
| link | STRING | NULLABLE | 商品链接 |
| image_link | STRING | NULLABLE | 错误图片数 |
| image_category | STRING | NULLABLE | 图片分类 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_product_image_crawl_error_sample_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:35
**扫描工具**: scan_metadata_v2.py
