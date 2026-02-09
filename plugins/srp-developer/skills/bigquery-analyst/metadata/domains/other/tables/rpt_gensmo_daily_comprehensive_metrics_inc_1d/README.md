# rpt_gensmo_daily_comprehensive_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 304 行
**大小**: 0.00 GB
**创建时间**: 2025-08-27
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | REQUIRED | - |
| dau | INTEGER | NULLABLE | - |
| new_user_cnt | INTEGER | NULLABLE | - |
| old_user_cnt | INTEGER | NULLABLE | - |
| mau | INTEGER | NULLABLE | - |
| wnu_count | INTEGER | NULLABLE | - |
| us_user | INTEGER | NULLABLE | - |
| non_us_user | INTEGER | NULLABLE | - |
| android_user | INTEGER | NULLABLE | - |
| ios_user | INTEGER | NULLABLE | - |
| male_user_cnt | INTEGER | NULLABLE | - |
| female_user_cnt | INTEGER | NULLABLE | - |
| search_uv | INTEGER | NULLABLE | - |
| try_on_uv | INTEGER | NULLABLE | - |
| search_pv | INTEGER | NULLABLE | - |
| try_on_pv | INTEGER | NULLABLE | - |
| login_user_cnt | INTEGER | NULLABLE | - |
| install_cnt | INTEGER | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |
| d1_retention_cnt | INTEGER | NULLABLE | - |
| d1_to_d7_retention_cnt | INTEGER | NULLABLE | - |
| w1_retention_cnt | INTEGER | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |
| updated_at | TIMESTAMP | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:52
**扫描工具**: scan_metadata_v2.py
