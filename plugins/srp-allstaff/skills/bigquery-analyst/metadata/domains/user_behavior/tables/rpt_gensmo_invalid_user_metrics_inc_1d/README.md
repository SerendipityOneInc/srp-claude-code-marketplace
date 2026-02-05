# rpt_gensmo_invalid_user_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 35,543 行
**大小**: 0.00 GB
**创建时间**: 2025-09-24
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | REQUIRED | - |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| geo_country_name | STRING | NULLABLE | 国家 |
| event_name | STRING | NULLABLE | 事件名称 |
| event_method | STRING | NULLABLE | 事件触发方式 |
| invalid_user_cnt | INTEGER | NULLABLE | 无效用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:59
**扫描工具**: scan_metadata_v2.py
