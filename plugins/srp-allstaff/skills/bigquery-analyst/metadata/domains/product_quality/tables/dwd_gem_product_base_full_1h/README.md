# dwd_gem_product_base_full_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_base_full_1h`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 54,595,905 行
**大小**: 6.38 GB
**创建时间**: 2025-12-09
**最后更新**: 2026-01-18

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| local_price | INTEGER | NULLABLE | - |
| is_used | INTEGER | NULLABLE | - |
| created_time | STRING | NULLABLE | - |
| inventory | STRING | NULLABLE | - |
| f_status | STRING | NULLABLE | - |
| base_update_time | TIMESTAMP | NULLABLE | - |
| base_update_date | DATE | NULLABLE | - |
| norm_brand | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_product_base_full_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:13:18
**扫描工具**: scan_metadata_v2.py
