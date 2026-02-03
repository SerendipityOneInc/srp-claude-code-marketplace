# dwd_gem_images_embedding_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_images_embedding_full_1d`
**层级**: DWD (明细层)
**业务域**: gem
**表类型**: TABLE
**行数**: 45,202,765 行
**大小**: 96.65 GB
**创建时间**: 2025-12-09
**最后更新**: 2026-01-18

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| f_url | STRING | NULLABLE | - |
| target_image_id | STRING | NULLABLE | - |
| embedding | FLOAT | REPEATED | - |
| emb_update_time | TIMESTAMP | NULLABLE | - |
| emb_update_date | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_images_embedding_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:12:38
**扫描工具**: scan_metadata_v2.py
