# rpt_gensmo_action_penetration_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_action_penetration_view`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-23
**最后更新**: 2025-07-23

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| user_group | STRING | NULLABLE | - |
| event_action_type | STRING | NULLABLE | - |
| event_action_user_cnt | INTEGER | NULLABLE | - |
| active_user_d1_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d` (rpt_gensmo_user_active_metrics_inc_1d)
- `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_general_ap_metrics_inc_1d` (rpt_gensmo_refer_general_ap_metrics_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_action_penetration_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:39
**扫描工具**: scan_metadata_v2.py
