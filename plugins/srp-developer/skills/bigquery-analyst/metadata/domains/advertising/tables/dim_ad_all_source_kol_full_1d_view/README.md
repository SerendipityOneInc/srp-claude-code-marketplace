# dim_ad_all_source_kol_full_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_all_source_kol_full_1d_view`
**层级**: 未分类
**业务域**: advertising
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-10
**最后更新**: 2025-11-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| app_name | STRING | NULLABLE | - |
| post_id | STRING | NULLABLE | - |
| brief_type | STRING | NULLABLE | - |
| function_tag | STRING | NULLABLE | - |
| handle | STRING | NULLABLE | - |
| campaign | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| tier | STRING | NULLABLE | - |
| post_time | DATE | NULLABLE | %E4Y-%m-%d |
| post_link | STRING | NULLABLE | - |
| cost | STRING | NULLABLE | - |
| source | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_all_source_kol_full_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:51
**扫描工具**: scan_metadata_v2.py
