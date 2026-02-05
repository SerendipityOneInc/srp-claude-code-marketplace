# dim_site_mut_google_sheet

**表全名**: `srpproduct-dc37e.favie_dw.dim_site_mut_google_sheet`
**层级**: 未分类
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-30
**最后更新**: 2025-10-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site_domain | STRING | NULLABLE | - |
| site_tier | STRING | NULLABLE | - |
| rank | STRING | NULLABLE | - |
| estimated_sku_num | INTEGER | NULLABLE | - |
| categories | STRING | NULLABLE | - |
| site_type | STRING | NULLABLE | - |
| parser_type | STRING | NULLABLE | - |
| country_region | STRING | NULLABLE | - |
| launch_date | DATE | NULLABLE | %m/%d/%E4Y |
| update_date | DATE | NULLABLE | %m/%d/%E4Y |
| label | STRING | NULLABLE | - |
| data_quality_config_json | STRING | NULLABLE | - |
| refresh_interval | STRING | NULLABLE | - |
| archive_interval | INTEGER | NULLABLE | - |
| index_config | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_site_mut_google_sheet`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:37
**扫描工具**: scan_metadata_v2.py
