# dim_ad_google_creative_youtube_video_info_full

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_google_creative_youtube_video_info_full`
**层级**: 未分类
**业务域**: advertising
**表类型**: TABLE
**行数**: 449 行
**大小**: 0.00 GB
**创建时间**: 2025-11-27
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| video_url | STRING | NULLABLE | 原始视频URL |
| video_id | STRING | NULLABLE | 解析出的视频ID |
| video_name | STRING | NULLABLE | 视频标题 |
| author_name | STRING | NULLABLE | YouTube频道名称 |
| video_created_at | STRING | NULLABLE | 视频上传日期 |
| processed_at | TIMESTAMP | NULLABLE | 数据更新时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_google_creative_youtube_video_info_full`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:58
**扫描工具**: scan_metadata_v2.py
