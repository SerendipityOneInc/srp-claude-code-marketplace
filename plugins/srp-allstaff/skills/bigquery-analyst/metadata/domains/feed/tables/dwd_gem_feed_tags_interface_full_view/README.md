# dwd_gem_feed_tags_interface_full_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_interface_full_view`
**层级**: DWD (明细层)
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-02
**最后更新**: 2025-07-02

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| moodboard_id | STRING | NULLABLE | - |
| tag_value | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_interface_full_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:12:25
**扫描工具**: scan_metadata_v2.py
