# dws_favie_gensmo_chat_session_messages_metric_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d_view`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-14
**最后更新**: 2025-11-14

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| chat_session_id | STRING | NULLABLE | - |
| user_group | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| message_type | STRING | NULLABLE | - |
| message_subtype | STRING | NULLABLE | - |
| message_visibility | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| user_role | STRING | NULLABLE | - |
| msg_cnt | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:57
**扫描工具**: scan_metadata_v2.py
