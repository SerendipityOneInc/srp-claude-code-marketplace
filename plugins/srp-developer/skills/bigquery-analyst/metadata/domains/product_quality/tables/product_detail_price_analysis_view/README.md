# product_detail_price_analysis_view

**表全名**: `srpproduct-dc37e.favie_dw.product_detail_price_analysis_view`
**层级**: 未分类
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-06
**最后更新**: 2025-02-06

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| link | STRING | NULLABLE | - |
| rrp | STRING | NULLABLE | - |
| price | INTEGER | NULLABLE | - |
| avg_price | FLOAT | NULLABLE | - |
| f_historical_prices | STRING | NULLABLE | - |
| change_rate | FLOAT | NULLABLE | - |
| updates_at | DATE | NULLABLE | - |
| dt | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d` (dwd_favie_product_detail_full_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.product_detail_price_analysis_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:07
**扫描工具**: scan_metadata_v2.py
