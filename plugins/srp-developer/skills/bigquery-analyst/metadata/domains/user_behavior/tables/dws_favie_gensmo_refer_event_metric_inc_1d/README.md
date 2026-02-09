# dws_favie_gensmo_refer_event_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_refer_event_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 11,896 行
**大小**: 0.00 GB
**创建时间**: 2025-11-07
**最后更新**: 2025-11-07

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期 |
| refer | STRING | NULLABLE | 页面名 |
| ap_name | STRING | NULLABLE | 交互点名称 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件方法 |
| event_action_type | STRING | NULLABLE | 事件行为类型 |
| item_type | STRING | NULLABLE | item类型 |
| app_version | STRING | NULLABLE | 应用版本 |
| platform | STRING | NULLABLE | 平台 |
| event_cnt | INTEGER | NULLABLE | 事件发生次数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_refer_event_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:03
**扫描工具**: scan_metadata_v2.py
