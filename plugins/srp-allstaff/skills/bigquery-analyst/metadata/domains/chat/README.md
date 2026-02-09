# 聊天对话

**业务域**: chat
**最后更新**: 2026-01-30
**表数量**: 6 张

---

## 📊 业务概述

用户聊天会话、消息记录、AI对话分析

**关键词**: 聊天, chat, 对话

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_favie_gensmo_session_behavior_1d` | RPT | --- |
| `dws_favie_gensmo_chat_session_messages_metric_inc_1d` | DWS | --- |
| `dws_favie_gensmo_chat_session_messages_metric_inc_1d_view` | DWS | --- |
| `dwd_favie_gensmo_chat_session_messages_inc_1d` | DWD | --- |
| `dim_chat_session_messages_view` | DIM | --- |
| `dim_chat_sessions_view` | DIM | --- |


更多表请参见 [TABLES.md](./TABLES.md)

---

## 💡 常见查询场景

### 场景 1: (待补充)

**需求**: 待补充业务需求

**推荐表**: 待补充

**示例 SQL**:
```sql
-- 待补充查询示例
SELECT
  dt,
  COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dwd.table_name`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC
```

---

## 🔗 相关资源

- [表清单](./TABLES.md) - 完整表列表
- [通用函数](./common_functions/) - 可复用的查询函数

---

**文档生成**: 2026-01-30 15:33:23
**维护者**: Data Platform Team
