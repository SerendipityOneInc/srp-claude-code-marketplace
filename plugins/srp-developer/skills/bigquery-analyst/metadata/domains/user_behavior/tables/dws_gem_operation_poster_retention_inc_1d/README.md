# dws_gem_operation_poster_retention_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_poster_retention_inc_1d`
**层级**: DWS (汇总层)
**业务域**: user_behavior
**表类型**: TABLE
**行数**: 60,496 行
**大小**: 0.01 GB
**创建时间**: 2025-09-10
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分组日期（dt） |
| user_media_source | STRING | NULLABLE | 用户媒体来源 |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| user_type | STRING | NULLABLE | 用户类型：new_user / old_user |
| user_tenure_type | STRING | NULLABLE | 用户任期类型（如新用户/老用户分层） |
| login_type | STRING | NULLABLE | 用户登录类型 |
| platform | STRING | NULLABLE | 平台，如 iOS/Android |
| app_version | STRING | NULLABLE | 用户的应用版本 |
| active_users | INTEGER | NULLABLE | 活跃用户数 |
| d1_retained_users | INTEGER | NULLABLE | D1留存用户数（去重） |
| d7_retained_users | INTEGER | NULLABLE | D7留存用户数（去重） |
| lt7 | INTEGER | NULLABLE | 1~7天累计回访次数 |
| active_post_users | INTEGER | NULLABLE | 主动发帖用户数 |
| passive_post_users | INTEGER | NULLABLE | 被动发帖用户数 |
| no_post_users | INTEGER | NULLABLE | 未发帖用户数 |
| active_post_d1_retained | INTEGER | NULLABLE | 主动发帖D1留存用户数 |
| passive_post_d1_retained | INTEGER | NULLABLE | 被动发帖D1留存用户数 |
| no_post_d1_retained | INTEGER | NULLABLE | 未发帖D1留存用户数 |
| active_post_d7_retained | INTEGER | NULLABLE | 主动发帖D7留存用户数 |
| passive_post_d7_retained | INTEGER | NULLABLE | 被动发帖D7留存用户数 |
| no_post_d7_retained | INTEGER | NULLABLE | 未发帖D7留存用户数 |
| active_post_lt7 | INTEGER | NULLABLE | 主动发帖LT7 |
| passive_post_lt7 | INTEGER | NULLABLE | 被动发帖LT7 |
| no_post_lt7 | INTEGER | NULLABLE | 未发帖LT7 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_operation_poster_retention_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:53
**扫描工具**: scan_metadata_v2.py
