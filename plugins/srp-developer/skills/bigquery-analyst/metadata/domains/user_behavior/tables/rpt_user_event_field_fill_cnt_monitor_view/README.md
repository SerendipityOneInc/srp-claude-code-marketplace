# rpt_user_event_field_fill_cnt_monitor_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_user_event_field_fill_cnt_monitor_view`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-04-27
**最后更新**: 2025-04-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| refer | STRING | NULLABLE | - |
| ap_name | STRING | NULLABLE | - |
| event_method | STRING | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| event_version | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| web_version | STRING | NULLABLE | - |
| field_name | STRING | NULLABLE | - |
| event_cnt | INTEGER | NULLABLE | - |
| fill_cnt | INTEGER | NULLABLE | - |
| default_cnt | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_user_event_field_fill_cnt_monitor_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:22
**扫描工具**: scan_metadata_v2.py
