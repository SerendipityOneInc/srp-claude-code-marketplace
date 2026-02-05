# dws_gem_operation_feed_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_feed_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: feed
**表类型**: TABLE
**行数**: 31,818,120 行
**大小**: 10.74 GB
**创建时间**: 2025-09-29
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 统计日期（按事件日期） |
| refer | STRING | NULLABLE | 来源/渠道 |
| collage_id | STRING | NULLABLE | 拼贴/作品ID |
| collage_title | STRING | NULLABLE | 拼贴标题 |
| collage_description | STRING | NULLABLE | 拼贴描述 |
| image_url | STRING | NULLABLE | 拼贴图片链接 |
| is_feed | BOOLEAN | NULLABLE | 是否为feed数据 |
| production_type | STRING | NULLABLE | 内外部用户 |
| collage_type | STRING | NULLABLE | 拼贴分类 |
| created_user_id | STRING | NULLABLE | 作品创建者ID |
| user_id | STRING | NULLABLE | 用户ID |
| user_name | STRING | NULLABLE | 用户名 |
| user_email | STRING | NULLABLE | 用户邮箱 |
| user_tenure_type | STRING | NULLABLE | 用户类型：新用户/老用户 |
| country_name | STRING | NULLABLE | 用户国家 |
| app_version | STRING | NULLABLE | 用户App版本 |
| platform | STRING | NULLABLE | 用户平台 |
| login_type | STRING | NULLABLE | 登录方式 |
| feed_view_pv | INTEGER | NULLABLE | feed浏览次数 |
| feed_click_pv | INTEGER | NULLABLE | feed点击次数 |
| feed_view_uv | INTEGER | NULLABLE | feed浏览用户数 |
| feed_click_uv | INTEGER | NULLABLE | feed点击用户数 |
| feed_save_cnt | INTEGER | NULLABLE | feed收藏次数 |
| feed_like_cnt | INTEGER | NULLABLE | feed点赞次数 |
| feed_try_on_cnt | INTEGER | NULLABLE | feed试穿次数 |
| product_external_click_cnt | INTEGER | NULLABLE | 商品外部跳转次数 |
| product_detail_click_cnt | INTEGER | NULLABLE | 商品详情点击次数 |
| feed_comment_cnt | INTEGER | NULLABLE | feed评论次数 |
| feed_saved_count | INTEGER | NULLABLE | feed累计收藏数 |
| feed_liked_count | INTEGER | NULLABLE | feed累计点赞数 |
| feed_shared_count | INTEGER | NULLABLE | feed累计分享数 |
| feed_remix | INTEGER | NULLABLE | feed remix数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_operation_feed_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:48
**扫描工具**: scan_metadata_v2.py
