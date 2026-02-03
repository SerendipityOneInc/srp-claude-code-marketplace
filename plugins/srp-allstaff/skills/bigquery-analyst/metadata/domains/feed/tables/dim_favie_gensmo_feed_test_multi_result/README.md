# dim_favie_gensmo_feed_test_multi_result

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_test_multi_result`
**层级**: 未分类
**业务域**: feed
**表类型**: TABLE
**行数**: 90 行
**大小**: 0.00 GB
**创建时间**: 2025-05-22
**最后更新**: 2025-05-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| moodboard_tags | RECORD | REPEATED | - |
| products | RECORD | REPEATED | - |
| moodboard_image_url | STRING | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_test_multi_result`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:07
**扫描工具**: scan_metadata_v2.py
