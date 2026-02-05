# rpt_favie_feed_operation_mertic_with_tag_info_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_feed_operation_mertic_with_tag_info_view`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-15
**最后更新**: 2025-07-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| event_date | DATE | NULLABLE | - |
| collage_id | STRING | NULLABLE | - |
| category | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| created_date | DATE | NULLABLE | - |
| created_user_id | STRING | NULLABLE | - |
| collage_description | STRING | NULLABLE | - |
| collage_title | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| operating_system | STRING | NULLABLE | - |
| is_feed | BOOLEAN | NULLABLE | - |
| Style1 | STRING | NULLABLE | - |
| Style2 | STRING | NULLABLE | - |
| Occasion1 | STRING | NULLABLE | - |
| Occasion2 | STRING | NULLABLE | - |
| BodySize1 | STRING | NULLABLE | - |
| BodySize2 | STRING | NULLABLE | - |
| BodyShape1 | STRING | NULLABLE | - |
| BodyShape2 | STRING | NULLABLE | - |
| Height1 | STRING | NULLABLE | - |
| Height2 | STRING | NULLABLE | - |
| Color | STRING | NULLABLE | - |
| Weather | STRING | NULLABLE | - |
| Temperature | STRING | NULLABLE | - |
| Gender | STRING | NULLABLE | - |
| Age | STRING | NULLABLE | - |
| pv_list | INTEGER | NULLABLE | - |
| pv_click | INTEGER | NULLABLE | - |
| uv_list | INTEGER | NULLABLE | - |
| uv_click | INTEGER | NULLABLE | - |
| share_cnt | INTEGER | NULLABLE | - |
| detail_try_on | INTEGER | NULLABLE | - |
| list_try_on | INTEGER | NULLABLE | - |
| remix_cnt | INTEGER | NULLABLE | - |
| save_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_rpt.rpt_favie_moodboard_tag_full_agg_view` (rpt_favie_moodboard_tag_full_agg_view)
- `srpproduct-dc37e.favie_rpt.rpt_favie_feed_operation_30d` (rpt_favie_feed_operation_30d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_feed_operation_mertic_with_tag_info_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:56
**扫描工具**: scan_metadata_v2.py
