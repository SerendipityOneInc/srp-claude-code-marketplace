# rpt_favie_media_image_dqc_metrics_site_inc_1h

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_dqc_metrics_site_inc_1h`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-22
**最后更新**: 2025-02-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | - |
| f_url_cnt | INTEGER | REQUIRED | - |
| f_url_uniq_cnt | INTEGER | REQUIRED | - |
| f_url_null_cnt | INTEGER | REQUIRED | - |
| site_null_cnt | INTEGER | REQUIRED | - |
| format_null_cnt | INTEGER | REQUIRED | - |
| width_null_cnt | INTEGER | REQUIRED | - |
| width_not_gt_0_cnt | INTEGER | REQUIRED | - |
| height_null_cnt | INTEGER | REQUIRED | - |
| height_not_gt_0_cnt | INTEGER | REQUIRED | - |
| error_code_null_cnt | INTEGER | REQUIRED | - |
| error_code_not_200_cnt | INTEGER | REQUIRED | - |
| size_type_null_cnt | INTEGER | REQUIRED | - |
| source_type_null_cnt | INTEGER | REQUIRED | - |
| source_type_invalid_enum_cnt | INTEGER | REQUIRED | - |
| source_id_null_cnt | INTEGER | REQUIRED | - |
| category_null_cnt | INTEGER | REQUIRED | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_dqc_metrics_site_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:50
**扫描工具**: scan_metadata_v2.py
