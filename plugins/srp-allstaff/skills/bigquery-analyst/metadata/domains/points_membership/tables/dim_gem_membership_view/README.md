# dim_gem_membership_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_membership_view`
**层级**: 未分类
**业务域**: points_membership
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-28
**最后更新**: 2025-12-28

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| checkin_days | INTEGER | NULLABLE | - |
| last_checkin_time | INTEGER | NULLABLE | - |
| last_updated | INTEGER | NULLABLE | - |
| local_country | STRING | NULLABLE | - |
| local_ip | STRING | NULLABLE | - |
| local_time_zone | STRING | NULLABLE | - |
| membership_expire_time | INTEGER | NULLABLE | - |
| membership_left_days | INTEGER | NULLABLE | - |
| membership_rule | STRING | NULLABLE | - |
| membership_type | STRING | NULLABLE | - |
| point_consume_records | JSON | REPEATED | - |
| point_earn_records | JSON | REPEATED | - |
| points_earned_today | INTEGER | NULLABLE | - |
| points_left_today | INTEGER | NULLABLE | - |
| points_permanent | INTEGER | NULLABLE | - |
| points_used_today | INTEGER | NULLABLE | - |
| subscription_expire_time | INTEGER | NULLABLE | - |
| total_points | INTEGER | NULLABLE | - |
| used_redeem_codes | JSON | REPEATED | - |
| user_id | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.copilot_gem_membership` (copilot_gem_membership)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_membership_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:00
**扫描工具**: scan_metadata_v2.py
