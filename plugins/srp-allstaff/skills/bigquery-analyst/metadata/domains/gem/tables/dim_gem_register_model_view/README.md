# dim_gem_register_model_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_register_model_view`
**层级**: 未分类
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2026-01-06
**最后更新**: 2026-01-06

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |
| created_timestamp | STRING | NULLABLE | - |
| model_id | STRING | NULLABLE | - |
| model_url | STRING | NULLABLE | - |
| caption_prompt | STRING | NULLABLE | - |
| original_model_id | STRING | NULLABLE | - |
| original_model_url | STRING | NULLABLE | - |
| age_group | STRING | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| glasses | STRING | NULLABLE | - |
| race | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| user_image_url | STRING | NULLABLE | - |
| underwear_avatar_url | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.gem` (gem)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_register_model_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:05
**扫描工具**: scan_metadata_v2.py
