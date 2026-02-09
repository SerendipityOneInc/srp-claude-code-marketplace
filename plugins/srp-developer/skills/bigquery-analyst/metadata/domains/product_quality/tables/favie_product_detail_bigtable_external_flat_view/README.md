# favie_product_detail_bigtable_external_flat_view

**表全名**: `srpproduct-dc37e.favie_dw.favie_product_detail_bigtable_external_flat_view`
**层级**: 未分类
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-01-01
**最后更新**: 2025-01-01

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| rowkey | STRING | NULLABLE | - |
| name | STRING | NULLABLE | - |
| value | STRING | NULLABLE | - |
| sys_name | STRING | NULLABLE | - |
| sys_value | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.favie_product_detail_bigtable_external_flat_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:48
**扫描工具**: scan_metadata_v2.py
