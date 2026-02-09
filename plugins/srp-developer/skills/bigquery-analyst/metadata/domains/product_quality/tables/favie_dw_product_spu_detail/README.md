# favie_dw_product_spu_detail

**表全名**: `srpproduct-dc37e.favie_dw.favie_dw_product_spu_detail`
**层级**: 未分类
**业务域**: product_quality
**表类型**: TABLE
**行数**: 33,146 行
**大小**: 0.01 GB
**创建时间**: 2025-09-09
**最后更新**: 2025-09-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| link | STRING | NULLABLE | - |
| sku_link | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.favie_dw_product_spu_detail`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:29
**扫描工具**: scan_metadata_v2.py
