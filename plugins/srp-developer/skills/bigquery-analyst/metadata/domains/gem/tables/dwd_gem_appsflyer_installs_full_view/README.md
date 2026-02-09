# dwd_gem_appsflyer_installs_full_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_appsflyer_installs_full_view`
**层级**: DWD (明细层)
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-05-30
**最后更新**: 2025-05-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| appsflyer_id | STRING | NULLABLE | - |
| bundle_id | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| publisher_platform | STRING | NULLABLE | - |
| device | STRING | NULLABLE | - |
| device_version | STRING | NULLABLE | - |
| af_channel | STRING | NULLABLE | - |
| af_siteid | STRING | NULLABLE | - |
| af_sub_siteid | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| campaign_id | STRING | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| adset_id | STRING | NULLABLE | - |
| adset_name | STRING | NULLABLE | - |
| is_primary_attribution | BOOLEAN | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| sub_continent_code | STRING | NULLABLE | - |
| region_code | STRING | NULLABLE | - |
| city_name | STRING | NULLABLE | - |
| ip | STRING | NULLABLE | - |
| install_time | TIMESTAMP | NULLABLE | - |
| af_attribution_lookback | STRING | NULLABLE | - |
| is_retargeting | BOOLEAN | NULLABLE | - |
| media_source | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.gensmo_appsflyer.installs` (installs)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_appsflyer_installs_full_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:12:05
**扫描工具**: scan_metadata_v2.py
