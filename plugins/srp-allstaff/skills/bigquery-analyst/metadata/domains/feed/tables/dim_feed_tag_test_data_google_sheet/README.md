# dim_feed_tag_test_data_google_sheet

**表全名**: `srpproduct-dc37e.favie_dw.dim_feed_tag_test_data_google_sheet`
**层级**: 未分类
**业务域**: feed
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-09
**最后更新**: 2025-06-09

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
| string_field_4 | STRING | NULLABLE | - |
| string_field_5 | STRING | NULLABLE | - |
| string_field_6 | STRING | NULLABLE | - |
| string_field_7 | STRING | NULLABLE | - |
| string_field_8 | STRING | NULLABLE | - |
| string_field_9 | STRING | NULLABLE | - |
| string_field_10 | STRING | NULLABLE | - |
| string_field_11 | STRING | NULLABLE | - |
| string_field_12 | STRING | NULLABLE | - |
| string_field_13 | STRING | NULLABLE | - |
| string_field_14 | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_feed_tag_test_data_google_sheet`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:38
**扫描工具**: scan_metadata_v2.py
