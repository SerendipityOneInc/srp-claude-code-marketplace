# dim_gensmo_brand_wall_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gensmo_brand_wall_view`
**层级**: 未分类
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-09-17
**最后更新**: 2025-09-17

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| brand | STRING | NULLABLE | - |
| brand_url | STRING | NULLABLE | - |
| display_brand | STRING | NULLABLE | - |
| score | INTEGER | NULLABLE | - |
| brand_image | STRING | NULLABLE | - |
| main_inner | STRING | NULLABLE | - |
| main_inner_image | STRING | NULLABLE | - |
| is_nyfw | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gensmo_brand_wall_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:19
**扫描工具**: scan_metadata_v2.py
