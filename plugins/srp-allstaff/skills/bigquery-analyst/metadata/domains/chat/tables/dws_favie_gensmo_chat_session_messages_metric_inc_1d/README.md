# dws_favie_gensmo_chat_session_messages_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 39,522,748 行
**大小**: 10.44 GB
**创建时间**: 2025-10-31
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 被创建的日期 |
| chat_session_id | STRING | NULLABLE | 会话id |
| message_type | STRING | NULLABLE | 信息类型 |
| message_visibility | STRING | NULLABLE | 是否是用户可见的 |
| user_id | STRING | NULLABLE | 发起会话的用户id |
| device_id | STRING | NULLABLE | 设备id |
| user_role | STRING | NULLABLE | 发送信息的角色 |
| user_group | STRING | NULLABLE | 用户组 |
| country_name | STRING | NULLABLE | 所在国家 |
| platform | STRING | NULLABLE | 应用平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| user_tenure_type | STRING | NULLABLE | 用户活跃类型(新/老用户) |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告id |
| ad_group_id | STRING | NULLABLE | 广告组id |
| ad_campaign_id | STRING | NULLABLE | 广告计划id |
| msg_cnt | INTEGER | NULLABLE | 信息条数 |
| search_query_intention | STRING | NULLABLE | 搜索查询意图/目的 |
| search_query_type | STRING | NULLABLE | 搜索查询类型(图文情况) |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:55
**扫描工具**: scan_metadata_v2.py
