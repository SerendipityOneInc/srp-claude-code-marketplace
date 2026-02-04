# rpt_decofy_user_retention_metrics_inc_1w

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_user_retention_metrics_inc_1w`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: TABLE
**行数**: 8,370 行
**大小**: 0.00 GB
**创建时间**: 2025-07-27
**最后更新**: 2026-01-28

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| week_end_dt | DATE | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| user_group | STRING | NULLABLE | - |
| retention_user_w1_cnt | INTEGER | NULLABLE | - |
| active_user_cnt | INTEGER | NULLABLE | - |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_user_retention_metrics_inc_1w`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:37
**扫描工具**: scan_metadata_v2.py
