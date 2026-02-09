# dim_decofy_product_config

**表全名**: `srpproduct-dc37e.favie_dw.dim_decofy_product_config`
**层级**: 未分类
**业务域**: product_quality
**表类型**: TABLE
**行数**: 6 行
**大小**: 0.00 GB
**创建时间**: 2026-01-30
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| product_id | STRING | NULLABLE | - |
| simple_product_id | STRING | NULLABLE | - |
| period | INTEGER | NULLABLE | - |
| price_usd | INTEGER | NULLABLE | - |
| is_include_trial | INTEGER | NULLABLE | - |
| first_order_price_usd | INTEGER | NULLABLE | - |
| default_first_order_renewal_rate | FLOAT | NULLABLE | - |
| default_second_order_renewal_rate | FLOAT | NULLABLE | - |
| default_third_more_order_renewal_rate | FLOAT | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_decofy_product_config`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:36
**扫描工具**: scan_metadata_v2.py
