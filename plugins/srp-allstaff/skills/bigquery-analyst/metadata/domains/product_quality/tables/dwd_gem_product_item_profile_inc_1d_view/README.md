# dwd_gem_product_item_profile_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_item_profile_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2026-01-05
**最后更新**: 2026-01-05

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| alg_description | STRING | NULLABLE | - |
| model_version | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_product_item_profile_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:14:11
**扫描工具**: scan_metadata_v2.py
