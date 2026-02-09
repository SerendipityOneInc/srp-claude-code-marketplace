# dwd_favie_gensmo_chat_session_messages_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: TABLE
**行数**: 2,778,283 行
**大小**: 187.80 GB
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
| message_id | STRING | NULLABLE | id |
| message_type | STRING | NULLABLE | 信息类型 |
| message_visibility | STRING | NULLABLE | 是否是用户可见的 |
| message_value | JSON | NULLABLE | 信息的具体内容 |
| message_sent_at | TIMESTAMP | NULLABLE | 信息发出的时间 |
| user_id | STRING | NULLABLE | 发起会话的用户id |
| user_role | STRING | NULLABLE | 发送信息的角色 |
| created_at | TIMESTAMP | NULLABLE | 被创建的时间 |
| updated_at | TIMESTAMP | NULLABLE | 最后一次被更新的时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:47
**扫描工具**: scan_metadata_v2.py
