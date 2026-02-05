# dim_feed_collage_full_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view`
**层级**: 未分类
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-31
**最后更新**: 2025-07-31

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| collage_id | STRING | NULLABLE | - |
| created_date | DATE | NULLABLE | - |
| created_user_id | STRING | NULLABLE | - |
| collage_title | STRING | NULLABLE | - |
| collage_description | STRING | NULLABLE | - |
| category | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| publisher | STRING | NULLABLE | - |
| is_feed | BOOLEAN | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dim_try_on_task_view` (dim_try_on_task_view)
- `srpproduct-dc37e.favie_dw.dim_moodboard_view` (dim_moodboard_view)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:31
**扫描工具**: scan_metadata_v2.py
