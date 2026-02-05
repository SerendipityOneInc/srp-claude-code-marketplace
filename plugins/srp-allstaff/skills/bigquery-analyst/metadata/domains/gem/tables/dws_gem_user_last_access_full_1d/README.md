# dws_gem_user_last_access_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_user_last_access_full_1d`
**层级**: DWS (汇总层)
**业务域**: gem
**表类型**: TABLE
**行数**: 458,071 行
**大小**: 0.25 GB
**创建时间**: 2025-09-23
**最后更新**: 2025-09-26

---

## 📊 表说明

Gensmo用户最后访问信息表，记录每个用户最后一次访问的日期及当时的完整用户特征，用于用户活跃度分析、流失用户识别和用户画像分析

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| last_access_date | DATE | NULLABLE | 用户最后访问日期 |
| device_id | STRING | NULLABLE | 设备ID，当前活跃设备 |
| first_device_id | STRING | NULLABLE | 首次登录设备ID |
| appsflyer_id | STRING | NULLABLE | Appsflyer追踪ID |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| user_type | STRING | NULLABLE | 用户类型，如register、unregister、deregister |
| user_tenure_type | STRING | NULLABLE | 用户生命周期类型，如new、old |
| created_at | TIMESTAMP | NULLABLE | 用户创建时间 |
| last_day_feature | RECORD | NULLABLE | 最后一次访问当天的用户特征 |
| last_30_days_feature | RECORD | NULLABLE | 最后一次访问时的30天用户特征 |
| updated_at | TIMESTAMP | NULLABLE | 记录更新时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_user_last_access_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:03
**扫描工具**: scan_metadata_v2.py
