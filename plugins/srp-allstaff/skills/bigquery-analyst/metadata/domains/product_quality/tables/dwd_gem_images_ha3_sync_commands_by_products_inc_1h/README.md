# dwd_gem_images_ha3_sync_commands_by_products_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_images_ha3_sync_commands_by_products_inc_1h`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-12
**最后更新**: 2025-12-12

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| biz_time | TIMESTAMP | NULLABLE | - |
| CMD | STRING | NULLABLE | - |
| target_image_id | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| f_url | STRING | NULLABLE | - |
| embedding | FLOAT | REPEATED | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_images_ha3_sync_commands_by_products_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:12:58
**扫描工具**: scan_metadata_v2.py
