# rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 304 行
**大小**: 0.00 GB
**创建时间**: 2025-08-28
**最后更新**: 2026-01-30

---

## 📊 表说明

Gensmo每日综合指标补充表，包含新用户行为数据和登录用户留存指标

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | REQUIRED | 报告日期 |
| new_user_search_uv | INTEGER | NULLABLE | 新用户搜索UV |
| new_user_try_on_uv | INTEGER | NULLABLE | 新用户试穿UV |
| new_user_search_pv | INTEGER | NULLABLE | 新用户搜索PV |
| new_user_try_on_pv | INTEGER | NULLABLE | 新用户试穿PV |
| login_new_user_cnt | INTEGER | NULLABLE | 登录新用户数 |
| login_d1_retention_cnt | INTEGER | NULLABLE | 登录用户D1留存数（次日更新） |
| login_d1_to_d7_retention_cnt | INTEGER | NULLABLE | 登录用户1D7S留存数（第8天更新） |
| login_w1_retention_cnt | INTEGER | NULLABLE | 登录用户W1留存数（第15天更新） |
| created_at | TIMESTAMP | NULLABLE | 创建时间 |
| updated_at | TIMESTAMP | NULLABLE | 更新时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_daily_comprehensive_metrics_supply_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:53
**扫描工具**: scan_metadata_v2.py
