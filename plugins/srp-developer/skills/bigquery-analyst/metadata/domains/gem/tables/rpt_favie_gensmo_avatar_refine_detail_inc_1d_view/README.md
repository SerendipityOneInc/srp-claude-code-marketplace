# rpt_favie_gensmo_avatar_refine_detail_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_avatar_refine_detail_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| replica_task_id | STRING | NULLABLE | - |
| source_replica_task_id | STRING | NULLABLE | - |
| user_image_url | STRING | NULLABLE | - |
| source_replica_model_url | STRING | NULLABLE | - |
| replica_model_url | STRING | NULLABLE | - |
| user_prompt | STRING | NULLABLE | - |
| seq_order | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_avatar_refine_detail_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:12
**扫描工具**: scan_metadata_v2.py
