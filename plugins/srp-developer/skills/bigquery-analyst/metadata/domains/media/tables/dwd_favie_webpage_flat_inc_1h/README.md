# dwd_favie_webpage_flat_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_webpage_flat_inc_1h`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-24
**最后更新**: 2025-02-24

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| md5_id | STRING | NULLABLE | - |
| url | STRING | NULLABLE | - |
| host | STRING | NULLABLE | - |
| domain | STRING | NULLABLE | - |
| f_fingerprint | INTEGER | NULLABLE | - |
| favicon | STRING | NULLABLE | - |
| language | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| author | STRING | NULLABLE | - |
| keywords | STRING | NULLABLE | - |
| robots | STRING | NULLABLE | - |
| content | STRING | NULLABLE | - |
| content_type | STRING | NULLABLE | - |
| excerpt | STRING | NULLABLE | - |
| comments | STRING | NULLABLE | - |
| subtitles | STRING | NULLABLE | - |
| images | STRING | NULLABLE | - |
| f_images | STRING | NULLABLE | - |
| videos | STRING | NULLABLE | - |
| f_videos | STRING | NULLABLE | - |
| references | STRING | NULLABLE | - |
| json_lds | STRING | NULLABLE | - |
| open_graphs | STRING | NULLABLE | - |
| twitter_cards | STRING | NULLABLE | - |
| page_type | STRING | NULLABLE | - |
| f_meta | STRING | NULLABLE | - |
| create_time | STRING | NULLABLE | - |
| update_time | STRING | NULLABLE | - |
| f_status | STRING | NULLABLE | - |
| ext_data | STRING | NULLABLE | - |
| products | STRING | NULLABLE | - |
| f_system_tags | STRING | NULLABLE | - |
| f_image_list | STRING | NULLABLE | - |
| author_v1 | STRING | NULLABLE | - |
| comments_v1 | STRING | NULLABLE | - |
| subtitles_v1 | STRING | NULLABLE | - |
| review_summary | STRING | NULLABLE | - |
| webpage_create_time | STRING | NULLABLE | - |
| upvotes_count | INTEGER | NULLABLE | - |
| downvotes_count | INTEGER | NULLABLE | - |
| views_count | INTEGER | NULLABLE | - |
| comments_total | INTEGER | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_webpage_flat_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:57
**扫描工具**: scan_metadata_v2.py
