# dim_try_on_user_task_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_try_on_user_task_view`
**层级**: 未分类
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |
| last_updated | INTEGER | NULLABLE | - |
| publish_time | TIMESTAMP | NULLABLE | - |
| detail_title | STRING | NULLABLE | - |
| detail_tag | STRING | NULLABLE | - |
| detail_description | STRING | NULLABLE | - |
| garment_type | STRING | NULLABLE | - |
| model_id | STRING | NULLABLE | - |
| model_type | STRING | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| mid_images | STRING | NULLABLE | - |
| try_on_cover_image | STRING | NULLABLE | - |
| try_on_mid_image | STRING | NULLABLE | - |
| try_on_original_url | STRING | NULLABLE | - |
| try_on_task_id | STRING | NULLABLE | - |
| try_on_url | STRING | NULLABLE | - |
| avatar_url | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| created_user_id | STRING | NULLABLE | - |
| user_image_tag | STRING | NULLABLE | - |
| user_image_url | STRING | NULLABLE | - |
| is_vibe | BOOLEAN | NULLABLE | - |
| is_feed | BOOLEAN | NULLABLE | - |
| use_default_model | BOOLEAN | NULLABLE | - |
| is_clone_task | BOOLEAN | NULLABLE | - |
| source | STRING | NULLABLE | - |
| liked_count | INTEGER | NULLABLE | - |
| remix | INTEGER | NULLABLE | - |
| saved_count | INTEGER | NULLABLE | - |
| shared_count | INTEGER | NULLABLE | - |
| score | STRING | NULLABLE | - |
| products | STRING | NULLABLE | - |
| outfit_description | STRING | NULLABLE | - |
| moodboards | JSON | NULLABLE | - |
| query | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| status | STRING | NULLABLE | - |
| type | STRING | NULLABLE | - |
| video_try_on_mode | STRING | NULLABLE | - |
| videos_url | JSON | REPEATED | - |
| f_source | STRING | NULLABLE | - |
| f_version | STRING | NULLABLE | - |
| from_feed | STRING | NULLABLE | - |
| publisher | STRING | NULLABLE | - |
| tryon_router | STRING | NULLABLE | - |
| moderation_status | STRING | NULLABLE | - |
| cover_image_list | JSON | REPEATED | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_try_on_user_task_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:48
**扫描工具**: scan_metadata_v2.py
