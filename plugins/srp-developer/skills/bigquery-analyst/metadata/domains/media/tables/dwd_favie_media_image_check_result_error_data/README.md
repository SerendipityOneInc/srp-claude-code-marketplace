# dwd_favie_media_image_check_result_error_data

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_media_image_check_result_error_data`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: TABLE
**行数**: 12,344 行
**大小**: 0.00 GB
**创建时间**: 2025-08-21
**最后更新**: 2025-08-21

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| url | STRING | NULLABLE | - |
| f_url | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_media_image_check_result_error_data`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:09
**扫描工具**: scan_metadata_v2.py
