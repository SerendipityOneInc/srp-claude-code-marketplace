# view_dwd_gem_product_images_ha3_full

**表全名**: `srpproduct-dc37e.favie_dw.view_dwd_gem_product_images_ha3_full`
**层级**: 未分类
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-11
**最后更新**: 2025-12-11

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| f_url | STRING | NULLABLE | - |
| target_image_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| local_price | INTEGER | NULLABLE | - |
| is_used | INTEGER | NULLABLE | - |
| created_time | STRING | NULLABLE | - |
| embedding | FLOAT | REPEATED | - |
| update_time | TIMESTAMP | NULLABLE | - |
| update_date | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.view_dwd_gem_product_images_ha3_full`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:37
**扫描工具**: scan_metadata_v2.py
