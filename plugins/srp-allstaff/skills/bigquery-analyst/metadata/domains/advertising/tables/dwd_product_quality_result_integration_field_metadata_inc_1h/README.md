# dwd_product_quality_result_integration_field_metadata_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_product_quality_result_integration_field_metadata_inc_1h`
**层级**: DWD (明细层)
**业务域**: advertising
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

---

## 📊 表说明

商品数据质量检查 Field 级别元数据表（外表），支持精确的优先级控制和白名单过滤

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |
| host | STRING | NULLABLE | - |
| key | STRING | NULLABLE | - |
| url | STRING | NULLABLE | - |
| field | STRING | NULLABLE | - |
| field_priority | STRING | NULLABLE | - |
| extracted_value | STRING | NULLABLE | - |
| crawler_value | STRING | NULLABLE | - |
| reason | STRING | NULLABLE | - |
| parser_name | STRING | NULLABLE | - |
| attributes | STRING | NULLABLE | - |
| task_link | STRING | NULLABLE | - |
| r2_url | STRING | NULLABLE | - |
| website_status | STRING | NULLABLE | - |
| is_whitelisted | BOOLEAN | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_product_quality_result_integration_field_metadata_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:55
**扫描工具**: scan_metadata_v2.py
