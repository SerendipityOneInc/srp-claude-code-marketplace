# dwd_favie_media_image_flat_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_media_image_flat_inc_1h`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-12-12
**最后更新**: 2024-12-12

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_url | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| url | STRING | NULLABLE | - |
| format | STRING | NULLABLE | - |
| text | STRING | NULLABLE | - |
| width | INTEGER | NULLABLE | - |
| height | INTEGER | NULLABLE | - |
| size | INTEGER | NULLABLE | - |
| category | STRING | NULLABLE | - |
| source_type | INTEGER | NULLABLE | - |
| source_id | STRING | NULLABLE | - |
| error | STRING | NULLABLE | - |
| error_code | STRING | NULLABLE | - |
| f_updates_at | STRING | NULLABLE | - |
| f_creates_at | STRING | NULLABLE | - |
| size_type | STRING | NULLABLE | - |
| color_mode | STRING | NULLABLE | - |
| exif | STRING | NULLABLE | - |
| frames | INTEGER | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_media_image_flat_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:11
**扫描工具**: scan_metadata_v2.py
