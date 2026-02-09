# dwd_favie_product_images_list_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_images_list_full_1d`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-11-15
**最后更新**: 2024-11-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| keywords | STRING | NULLABLE | - |
| categories | STRING | NULLABLE | - |
| f_categories | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| f_image_url | STRING | NULLABLE | - |
| r2_bucket | STRING | REQUIRED | - |
| image_path | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_images_list_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:41
**扫描工具**: scan_metadata_v2.py
