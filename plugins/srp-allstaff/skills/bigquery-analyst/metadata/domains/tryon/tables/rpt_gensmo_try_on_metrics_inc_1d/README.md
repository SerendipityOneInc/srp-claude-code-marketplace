# rpt_gensmo_try_on_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_try_on_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 24,990 行
**大小**: 0.00 GB
**创建时间**: 2025-04-27
**最后更新**: 2025-06-17

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| user_tenure_type | STRING | NULLABLE | 是否新用户 |
| user_country_name | STRING | NULLABLE | 用户30日内最常使用所在国家 |
| platform | STRING | NULLABLE | 用户当日使用最多的平台 |
| app_version | STRING | NULLABLE | 用户当日使用最多的app版本号 |
| try_on_complete_d1_cnt | INTEGER | NULLABLE | 日完成TryOn次数 |
| try_on_complete_user_d1_cnt | INTEGER | NULLABLE | 日完成TryOn用户数 |
| try_on_d1_cnt | INTEGER | NULLABLE | 日发起TryOn次数 |
| try_on_user_d1_cnt | INTEGER | NULLABLE | 日发起TryOn用户数 |
| active_user_d1_cnt | INTEGER | NULLABLE | 日活跃用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_try_on_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:23
**扫描工具**: scan_metadata_v2.py
