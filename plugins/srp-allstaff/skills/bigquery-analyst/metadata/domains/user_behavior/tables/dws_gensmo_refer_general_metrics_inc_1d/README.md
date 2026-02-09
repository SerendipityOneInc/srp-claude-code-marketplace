# dws_gensmo_refer_general_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_refer_general_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 30,227,674 行
**大小**: 3.73 GB
**创建时间**: 2025-06-04
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| device_id | STRING | NULLABLE | 设备ID |
| refer | STRING | NULLABLE | 页面名称 |
| ap_name | STRING | NULLABLE | AP名称 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件方法 |
| event_action_type | STRING | NULLABLE | 动作类型 |
| data_name | STRING | NULLABLE | 数据名称 |
| data_value | FLOAT | NULLABLE | 数据值 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gensmo_refer_general_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:07
**扫描工具**: scan_metadata_v2.py
