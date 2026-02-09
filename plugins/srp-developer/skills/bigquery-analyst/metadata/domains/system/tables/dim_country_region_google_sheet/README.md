# dim_country_region_google_sheet

**表全名**: `srpproduct-dc37e.favie_dw.dim_country_region_google_sheet`
**层级**: 未分类
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-03-27
**最后更新**: 2025-03-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| string_field_0 | STRING | NULLABLE | - |
| string_field_1 | STRING | NULLABLE | - |
| string_field_2 | STRING | NULLABLE | - |
| string_field_3 | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_country_region_google_sheet`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:29
**扫描工具**: scan_metadata_v2.py
