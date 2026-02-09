# dim_official_brand_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_official_brand_view`
**层级**: 未分类
**业务域**: other
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
| raw_brand | STRING | NULLABLE | - |
| category | STRING | NULLABLE | - |
| official_brand | STRING | NULLABLE | - |
| parent_official_brand | STRING | NULLABLE | - |
| website | STRING | NULLABLE | - |
| status | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dim_favie_mapping_raw_brand` (dim_favie_mapping_raw_brand)
- `srpproduct-dc37e.favie_dw.dim_favie_official_brand` (dim_favie_official_brand)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_official_brand_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:32
**扫描工具**: scan_metadata_v2.py
