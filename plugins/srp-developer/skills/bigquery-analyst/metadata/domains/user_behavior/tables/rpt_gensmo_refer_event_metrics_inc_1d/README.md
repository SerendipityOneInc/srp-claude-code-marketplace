# rpt_gensmo_refer_event_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_event_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 3,904 行
**大小**: 0.00 GB
**创建时间**: 2025-04-12
**最后更新**: 2025-04-12

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| refer | STRING | NULLABLE | 来源 |
| pre_refer | STRING | NULLABLE | 上级来源 |
| ap_name | STRING | NULLABLE | ap名称 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件方法 |
| event_action_type | STRING | NULLABLE | 事件行为类型 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | app版本 |
| native_version | STRING | NULLABLE | native版本 |
| event_cnt | INTEGER | NULLABLE | 事件数 |
| event_user_cnt | INTEGER | NULLABLE | 事件访客数 |
| dt | DATE | NULLABLE | 分区，日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_event_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:16
**扫描工具**: scan_metadata_v2.py
