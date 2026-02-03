# dws_gensmo_user_activity_profile_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_activity_profile_inc_1d`
**层级**: DWS (汇总层)
**业务域**: user_behavior
**表类型**: TABLE
**行数**: 1,530,587 行
**大小**: 0.46 GB
**创建时间**: 2025-10-21
**最后更新**: 2026-01-30

---

## 📊 表说明

Gensmo用户活跃行为宽表，聚合用户当天行为类型及关键功能使用情况

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| device_id | STRING | NULLABLE | 设备ID，当前活跃设备 |
| appsflyer_id | STRING | NULLABLE | Appsflyer追踪ID |
| user_ids | STRING | REPEATED | 用户ID列表，包含当天登录的所有用户ID |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| user_type | STRING | NULLABLE | 用户类型 |
| user_tenure_type | STRING | NULLABLE | 用户在职时长类型 |
| user_tenure_segment | STRING | NULLABLE | 用户在职时长细分 |
| user_login_type | STRING | NULLABLE | 用户登录类型，login表示当天有登录，guest表示当天未登录 |
| user_created_at | TIMESTAMP | NULLABLE | 用户创建时间 |
| first_event_timestamp | TIMESTAMP | NULLABLE | 首次访问时间 |
| last_event_timestamp | TIMESTAMP | NULLABLE | 最近访问时间 |
| geo_address | RECORD | NULLABLE | 地理位置信息 |
| app_info | RECORD | NULLABLE | 应用信息 |
| user_duration | FLOAT | NULLABLE | 当天用户总停留时长，单位秒 |
| common_actions | RECORD | REPEATED | 当天内的行为类型及计数 |
| key_functions | RECORD | REPEATED | 当天内的key功能类型及计数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_activity_profile_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:14
**扫描工具**: scan_metadata_v2.py
