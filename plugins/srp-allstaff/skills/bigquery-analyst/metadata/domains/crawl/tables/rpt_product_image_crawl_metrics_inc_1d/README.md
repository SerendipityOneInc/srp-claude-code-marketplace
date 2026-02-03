# rpt_product_image_crawl_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_product_image_crawl_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 97,910 行
**大小**: 0.01 GB
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
| image_category | STRING | NULLABLE | 图片分类 |
| download_image_cnt | INTEGER | NULLABLE | 图片数 |
| download_image_sku_cnt | INTEGER | NULLABLE | SKU数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_product_image_crawl_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:18
**扫描工具**: scan_metadata_v2.py
