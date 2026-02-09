# dws_favie_gensmo_user_feature_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-21
**最后更新**: 2025-10-21

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| first_device_id | STRING | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| is_internal_user | BOOLEAN | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |
| last_day_feature | RECORD | NULLABLE | - |
| last_30_days_feature | RECORD | NULLABLE | - |
| last_access_at | TIMESTAMP | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:18
**扫描工具**: scan_metadata_v2.py
