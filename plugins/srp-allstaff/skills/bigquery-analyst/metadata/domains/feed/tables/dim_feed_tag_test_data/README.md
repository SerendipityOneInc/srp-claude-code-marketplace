# dim_feed_tag_test_data

**表全名**: `srpproduct-dc37e.favie_dw.dim_feed_tag_test_data`
**层级**: 未分类
**业务域**: feed
**表类型**: TABLE
**行数**: 269 行
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
| moodboard_id | STRING | NULLABLE | - |
| style_one | STRING | NULLABLE | - |
| style_two | STRING | NULLABLE | - |
| occasion_one | STRING | NULLABLE | - |
| occasion_two | STRING | NULLABLE | - |
| color | STRING | NULLABLE | - |
| weather | STRING | NULLABLE | - |
| temperature | STRING | NULLABLE | - |
| age | STRING | NULLABLE | - |
| body_shape | STRING | NULLABLE | - |
| body_size | STRING | NULLABLE | - |
| height | STRING | NULLABLE | - |
| tagger | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_feed_tag_test_data`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:36
**扫描工具**: scan_metadata_v2.py
