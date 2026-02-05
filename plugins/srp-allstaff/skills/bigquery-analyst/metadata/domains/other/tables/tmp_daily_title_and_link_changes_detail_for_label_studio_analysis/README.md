# tmp_daily_title_and_link_changes_detail_for_label_studio_analysis

**表全名**: `srpproduct-dc37e.favie_dw.tmp_daily_title_and_link_changes_detail_for_label_studio_analysis`
**层级**: 未分类
**业务域**: other
**表类型**: TABLE
**行数**: 39,809,130 行
**大小**: 14.16 GB
**创建时间**: 2025-09-10
**最后更新**: 2025-09-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| current_title | STRING | NULLABLE | - |
| current_link | STRING | NULLABLE | - |
| previous_title | STRING | NULLABLE | - |
| previous_link | STRING | NULLABLE | - |
| title_change_type | STRING | NULLABLE | - |
| link_change_flag | STRING | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.tmp_daily_title_and_link_changes_detail_for_label_studio_analysis`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:22
**扫描工具**: scan_metadata_v2.py
