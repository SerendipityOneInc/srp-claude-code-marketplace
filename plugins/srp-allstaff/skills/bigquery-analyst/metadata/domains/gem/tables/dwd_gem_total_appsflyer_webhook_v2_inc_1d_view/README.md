# dwd_gem_total_appsflyer_webhook_v2_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_total_appsflyer_webhook_v2_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-17
**最后更新**: 2025-10-17

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| source | STRING | NULLABLE | - |
| channel | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| media_source | STRING | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| campaign_id | STRING | NULLABLE | - |
| ad_group_name | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| event_time | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_total_appsflyer_webhook_v2_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:14:28
**扫描工具**: scan_metadata_v2.py
