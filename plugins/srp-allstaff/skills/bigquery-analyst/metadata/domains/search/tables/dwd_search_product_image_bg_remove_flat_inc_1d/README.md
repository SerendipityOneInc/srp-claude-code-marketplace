# dwd_search_product_image_bg_remove_flat_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_search_product_image_bg_remove_flat_inc_1d`
**层级**: DWD (明细层)
**业务域**: search
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-04-16
**最后更新**: 2025-04-16

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| f_url | STRING | NULLABLE | - |
| bg_remove_url | STRING | NULLABLE | - |
| image_info | STRING | NULLABLE | - |
| original_image_index | INTEGER | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| model_version | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_search_product_image_bg_remove_flat_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:09
**扫描工具**: scan_metadata_v2.py
