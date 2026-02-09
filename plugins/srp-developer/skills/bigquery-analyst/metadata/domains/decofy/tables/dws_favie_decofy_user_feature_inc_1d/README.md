# dws_favie_decofy_user_feature_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_decofy_user_feature_inc_1d`
**层级**: DWS (汇总层)
**业务域**: decofy
**表类型**: TABLE
**行数**: 25,944 行
**大小**: 0.01 GB
**创建时间**: 2025-10-05
**最后更新**: 2026-01-30

---

## 📊 表说明

Decofy用户特征宽表，聚合用户近一天与近30天的地理、活跃、行为等特征信息

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| user_id | STRING | NULLABLE | 用户ID |
| first_device_id | STRING | NULLABLE | 首次登录设备ID |
| first_appsflyer_id | STRING | NULLABLE | Appsflyer追踪ID |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| user_type | STRING | NULLABLE | 用户类型，如register、unregister、deregister |
| user_tenure_type | STRING | NULLABLE | 用户生命周期类型，如new、active、expired |
| created_at | TIMESTAMP | NULLABLE | 用户创建时间 |
| last_day_feature | RECORD | NULLABLE | 最近一天用户特征 |
| last_30_days_feature | RECORD | NULLABLE | 最近30天用户特征 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_decofy_user_feature_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:36
**扫描工具**: scan_metadata_v2.py
