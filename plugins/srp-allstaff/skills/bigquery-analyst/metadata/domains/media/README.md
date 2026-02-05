# 媒体资源

**业务域**: media
**最后更新**: 2026-01-30
**表数量**: 24 张

---

## 📊 业务概述

图片、视频、网页等媒体资源的管理和分析

**关键词**: 图片, 视频, 媒体, image, video

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_favie_image_format_distribution_review_full_1d` | RPT | --- |
| `rpt_favie_image_pixel_distribution_review_full_1d` | RPT | --- |
| `rpt_favie_media_image_dqc_metrics_site_inc_1h` | RPT | --- |
| `dwd_favie_media_image_check_result_1d` | DWD | --- |
| `dwd_favie_media_image_check_result_error_data` | DWD | --- |
| `dwd_favie_media_image_flat_inc_1h` | DWD | --- |


更多表请参见 [TABLES.md](./TABLES.md)

---

## 💡 常见查询场景

### 场景 1: (待补充)

**需求**: 待补充业务需求

**推荐表**: 待补充

**示例 SQL**:
```sql
-- 待补充查询示例
SELECT
  dt,
  COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dwd.table_name`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC
```

---

## 🔗 相关资源

- [表清单](./TABLES.md) - 完整表列表
- [通用函数](./common_functions/) - 可复用的查询函数

---

**文档生成**: 2026-01-30 15:33:23
**维护者**: Data Platform Team
