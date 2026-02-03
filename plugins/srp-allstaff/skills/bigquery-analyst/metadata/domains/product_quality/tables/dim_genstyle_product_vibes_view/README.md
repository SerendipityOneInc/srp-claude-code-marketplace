# dim_genstyle_product_vibes_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_genstyle_product_vibes_view`
**层级**: 未分类
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| business | STRING | NULLABLE | - |
| business_product_id | STRING | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |
| deleted_at | TIMESTAMP | NULLABLE | - |
| offline_task_id | STRING | NULLABLE | - |
| product_vibe_id | STRING | NULLABLE | - |
| products | JSON | NULLABLE | - |
| rejection_reason | STRING | NULLABLE | - |
| review_note | STRING | NULLABLE | - |
| status | STRING | NULLABLE | - |
| try_on_image_url | STRING | NULLABLE | - |
| updated_at | TIMESTAMP | NULLABLE | - |
| vibe_image_url | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_genstyle_product_vibes_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:27
**扫描工具**: scan_metadata_v2.py
