# dwd_favie_webpage_reddit_comments_flat_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_webpage_reddit_comments_flat_inc_1d`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2026-01-15
**最后更新**: 2026-01-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| md5_id | STRING | NULLABLE | - |
| depth | INTEGER | NULLABLE | - |
| oid | STRING | NULLABLE | - |
| parent_id | STRING | NULLABLE | - |
| post_id | STRING | NULLABLE | - |
| url | STRING | NULLABLE | - |
| host | STRING | NULLABLE | - |
| favicon | STRING | NULLABLE | - |
| language | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| author | STRING | NULLABLE | - |
| keywords | RECORD | NULLABLE | - |
| robots | RECORD | NULLABLE | - |
| content | STRING | NULLABLE | - |
| content_type | STRING | NULLABLE | - |
| excerpt | STRING | NULLABLE | - |
| comments | RECORD | REQUIRED | - |
| subtitles | RECORD | NULLABLE | - |
| images | RECORD | NULLABLE | - |
| videos | RECORD | NULLABLE | - |
| references | RECORD | NULLABLE | - |
| json_lds | RECORD | NULLABLE | - |
| open_graphs | RECORD | NULLABLE | - |
| twitter_cards | RECORD | NULLABLE | - |
| page_type | STRING | NULLABLE | - |
| child_count | INTEGER | NULLABLE | - |
| is_admin_takedown | BOOLEAN | NULLABLE | - |
| is_removed | BOOLEAN | NULLABLE | - |
| is_nsfw | BOOLEAN | NULLABLE | - |
| score | FLOAT | NULLABLE | - |
| is_stickied | BOOLEAN | NULLABLE | - |
| awardings | RECORD | NULLABLE | - |
| treatment_tags | RECORD | NULLABLE | - |
| distinguished_as | STRING | NULLABLE | - |
| moderation_info | STRING | NULLABLE | - |
| created_at | INTEGER | NULLABLE | - |
| edited_at | INTEGER | NULLABLE | - |
| crawl_time | STRING | NULLABLE | - |
| fingerprint_id | INTEGER | NULLABLE | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_webpage_reddit_comments_flat_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:12:01
**扫描工具**: scan_metadata_v2.py
