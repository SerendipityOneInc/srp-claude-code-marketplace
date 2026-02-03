# dwd_gem_operation_feed_full

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_operation_feed_full`
**层级**: DWD (明细层)
**业务域**: feed
**表类型**: TABLE
**行数**: 18,889,443 行
**大小**: 7.36 GB
**创建时间**: 2025-09-29
**最后更新**: 2025-12-11

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| collage_id | STRING | NULLABLE | collage 唯一ID；moodboard_id/try_on_task_id |
| created_date | DATETIME | NULLABLE | collage创建日期 |
| created_at | TIMESTAMP | NULLABLE | collage创建时间，精确到秒 |
| created_user_id | STRING | NULLABLE | collage创建用户ID |
| collage_title | STRING | NULLABLE | collage标题/推理reasoning |
| collage_description | STRING | NULLABLE | collage描述 |
| category | STRING | NULLABLE | with_cover_feed/similar_collage/general_collage/try_on |
| image_url | STRING | NULLABLE | 封面或试穿图片URL |
| publisher | STRING | NULLABLE | 发布者 |
| is_feed | BOOLEAN | NULLABLE | 是否信息流内容（已筛选为 TRUE） |
| is_onboard | BOOLEAN | NULLABLE | 是否onboard |
| moderation_status | STRING | NULLABLE | 审核状态 |
| liked_count | INTEGER | NULLABLE | lick_count |
| saved_count | INTEGER | NULLABLE | save_count |
| shared_count | INTEGER | NULLABLE | share_co unt |
| remix | INTEGER | NULLABLE | remix |
| hashtags | JSON | REPEATED | hashtag |
| tag_dt | DATETIME | NULLABLE | 标签表(dwd_gem_feed_tags_full_1d_view)中该ID的最近日期 |
| style_one_tags | STRING | REPEATED | - |
| style_two_tags | STRING | REPEATED | - |
| occasion_one_tags | STRING | REPEATED | - |
| occasion_two_tags | STRING | REPEATED | - |
| color_tags | STRING | REPEATED | - |
| weather_tags | STRING | REPEATED | - |
| temperature_tags | STRING | REPEATED | - |
| gender_tags | STRING | REPEATED | - |
| age_tags | STRING | REPEATED | - |
| body_size_tags | STRING | REPEATED | - |
| body_shape_tags | STRING | REPEATED | - |
| height_tags | STRING | REPEATED | - |
| is_UGC | BOOLEAN | NULLABLE | created_user_id 字符长度>5 |
| is_duplicate_image | BOOLEAN | NULLABLE | whether image_url appears more than once |
| production_type | STRING | NULLABLE | 生产类型 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_operation_feed_full`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:13:16
**扫描工具**: scan_metadata_v2.py
