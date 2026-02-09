# dws_gensmo_refer_event_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_refer_event_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 21,608,236 行
**大小**: 3.62 GB
**创建时间**: 2025-08-07
**最后更新**: 2025-10-05

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| device_id | STRING | NULLABLE | 设备ID |
| user_tenure_type | STRING | NULLABLE | 是否新用户 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| user_country_name | STRING | NULLABLE | 用户国家 |
| refer | STRING | NULLABLE | 来源 |
| ap_name | STRING | NULLABLE | ap名称 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件方法 |
| event_action_type | STRING | NULLABLE | 事件行为类型 |
| pre_refer | STRING | NULLABLE | 上级来源 |
| pre_refer_ap_name | STRING | NULLABLE | 上级ap名称 |
| pre_refer_event_name | STRING | NULLABLE | 上级事件名称 |
| pre_refer_event_method | STRING | NULLABLE | 上级事件方法 |
| pre_refer_event_action_type | STRING | NULLABLE | 上级事件行为类型 |
| next_refer | STRING | NULLABLE | 下级来源 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | app版本 |
| web_version | STRING | NULLABLE | native版本 |
| event_version | STRING | NULLABLE | 事件版本 |
| event_cnt | INTEGER | NULLABLE | 事件数 |
| dt | DATE | NULLABLE | 分区，日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gensmo_refer_event_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:05
**扫描工具**: scan_metadata_v2.py
