# favie_product_detail_clean_brand_view

**表全名**: `srpproduct-dc37e.favie_dw.favie_product_detail_clean_brand_view`
**层级**: 未分类
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-23
**最后更新**: 2025-07-23

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| brand_name | STRING | NULLABLE | - |
| f_brand | JSON | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d` (dwd_favie_product_detail_full_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.favie_product_detail_clean_brand_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:55
**扫描工具**: scan_metadata_v2.py
