# rpt_favie_product_detail_dqc_price_abnormal_inc_1h

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_dqc_price_abnormal_inc_1h`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-22
**最后更新**: 2025-02-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| site | STRING | REQUIRED | - |
| shop_site | STRING | REQUIRED | - |
| link | STRING | NULLABLE | - |
| price | STRING | NULLABLE | - |
| f_historical_prices | STRING | NULLABLE | - |
| price_reason_result | RECORD | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_dqc_price_abnormal_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:07
**扫描工具**: scan_metadata_v2.py
