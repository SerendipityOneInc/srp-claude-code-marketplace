# dwd_gem_images_search_index_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_images_search_index_full_1d`
**层级**: DWD (明细层)
**业务域**: search
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-03-17
**最后更新**: 2025-03-17

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| target_image_id | STRING | NULLABLE | - |
| f_sku_id_list | RECORD | NULLABLE | - |
| embedding | RECORD | NULLABLE | - |
| is_good_object | INTEGER | NULLABLE | - |
| ocr_embedding | RECORD | NULLABLE | - |
| image_score | FLOAT | NULLABLE | - |
| f_image_bbox_list | RECORD | NULLABLE | - |
| model_meta | RECORD | NULLABLE | - |
| object_class | STRING | NULLABLE | - |
| object_tag_list | RECORD | NULLABLE | - |
| update_dt | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| model_version | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_images_search_index_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:13:11
**扫描工具**: scan_metadata_v2.py
