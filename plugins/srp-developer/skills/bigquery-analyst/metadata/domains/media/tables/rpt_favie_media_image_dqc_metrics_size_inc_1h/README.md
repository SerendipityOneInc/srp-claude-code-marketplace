# rpt_favie_media_image_dqc_metrics_size_inc_1h

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_dqc_metrics_size_inc_1h`
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
| site | STRING | REQUIRED | - |
| size_type | STRING | REQUIRED | - |
| f_url_cnt | INTEGER | REQUIRED | - |
| total_f_url_cnt | INTEGER | REQUIRED | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_dqc_metrics_size_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:54
**扫描工具**: scan_metadata_v2.py
