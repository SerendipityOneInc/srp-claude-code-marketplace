# ads_gem_ha3_sync_statistics_1d

**表全名**: `srpproduct-dc37e.favie_dw.ads_gem_ha3_sync_statistics_1d`
**层级**: 未分类
**业务域**: advertising
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-13
**最后更新**: 2025-07-13

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | - |
| add_commands | INTEGER | NULLABLE | - |
| delete_commands | INTEGER | NULLABLE | - |
| total_commands | INTEGER | NULLABLE | - |
| created_at | TIMESTAMP | REQUIRED | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.ads_gem_ha3_sync_statistics_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:29
**扫描工具**: scan_metadata_v2.py
