# rpt_favie_gensmo_session_behavior_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_session_behavior_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 96,764,527 行
**大小**: 20.90 GB
**创建时间**: 2025-07-22
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 指标数据日期 |
| session_id | STRING | NULLABLE | 会话 ID |
| user_uid | STRING | NULLABLE | 用户 UID |
| last_device_id | STRING | NULLABLE | 最后一次使用的设备 ID |
| message_type | STRING | NULLABLE | 会话消息类型（例如 search、tryon 等） |
| total_message_count | INTEGER | NULLABLE | 会话内消息总数 |
| search_query_count | INTEGER | NULLABLE | 搜索请求消息数 |
| search_res_count | INTEGER | NULLABLE | 搜索结果返回消息数 |
| tryon_query_count | INTEGER | NULLABLE | 试穿请求消息数 |
| tryon_res_count | INTEGER | NULLABLE | 试穿结果返回消息数 |
| tryon_changebg_query_count | INTEGER | NULLABLE | 换背景请求消息数 |
| tryon_changebg_res_count | INTEGER | NULLABLE | 换背景结果返回消息数 |
| session_start_count | INTEGER | NULLABLE | 会话启动消息数 |
| unexpect_error_count | INTEGER | NULLABLE | 意外错误消息数 |
| platform | STRING | NULLABLE | 平台（如 app/web） |
| app_version | STRING | NULLABLE | App 版本号 |
| country_name | STRING | NULLABLE | 用户所在国家 |
| user_login_type | STRING | NULLABLE | 用户登录类型（游客/注册用户） |
| user_tenure_type | STRING | NULLABLE | 用户新老类型（新客/老客） |
| user_group | STRING | NULLABLE | 用户分组标记（如实验组/对照组） |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_session_behavior_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:30
**扫描工具**: scan_metadata_v2.py
