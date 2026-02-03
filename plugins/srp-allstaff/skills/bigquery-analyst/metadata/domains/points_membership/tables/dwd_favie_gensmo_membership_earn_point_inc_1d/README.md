# dwd_favie_gensmo_membership_earn_point_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d`
**层级**: DWD (明细层)
**业务域**: points_membership
**表类型**: TABLE
**行数**: 87,978 行
**大小**: 0.01 GB
**创建时间**: 2025-12-28
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期，表示事件发生的日期 |
| user_id | STRING | NULLABLE | 用户ID，已登录用户的唯一标识符 |
| device_id | STRING | NULLABLE | 设备ID，设备的唯一标识符 |
| earn_id | STRING | NULLABLE | 积分获取记录ID |
| earn_type | STRING | NULLABLE | 积分获取方式，如签到、购买等 |
| earn_point_type | STRING | NULLABLE | 积分类型，如日常积分、永久积分等 |
| earn_points | INTEGER | NULLABLE | 获取的积分总数 |
| earn_time | TIMESTAMP | NULLABLE | 积分获取时间戳 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:57
**扫描工具**: scan_metadata_v2.py
