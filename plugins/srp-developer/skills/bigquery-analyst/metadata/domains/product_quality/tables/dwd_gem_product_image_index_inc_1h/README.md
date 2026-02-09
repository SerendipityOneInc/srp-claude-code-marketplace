# dwd_gem_product_image_index_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_inc_1h`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 6,277,378 行
**大小**: 1.89 GB
**创建时间**: 2026-01-20
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| CMD | STRING | NULLABLE | - |
| record_time | TIMESTAMP | NULLABLE | - |
| record_hour | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| f_status | STRING | NULLABLE | - |
| local_price | INTEGER | NULLABLE | - |
| local_currency | INTEGER | NULLABLE | - |
| base_price | INTEGER | NULLABLE | - |
| base_currency | INTEGER | NULLABLE | - |
| discount | FLOAT | NULLABLE | - |
| is_used | INTEGER | NULLABLE | - |
| inventory | STRING | NULLABLE | - |
| image_urls | STRING | REPEATED | - |
| created_time | STRING | NULLABLE | - |
| product_create_time | TIMESTAMP | NULLABLE | - |
| product_update_time | TIMESTAMP | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:14:00
**扫描工具**: scan_metadata_v2.py
