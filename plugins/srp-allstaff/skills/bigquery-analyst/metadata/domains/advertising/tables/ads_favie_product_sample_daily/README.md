# ads_favie_product_sample_daily

**表全名**: `srpproduct-dc37e.favie_dw.ads_favie_product_sample_daily`
**层级**: 未分类
**业务域**: advertising
**表类型**: TABLE
**行数**: 151,967 行
**大小**: 0.47 GB
**创建时间**: 2024-10-18
**最后更新**: 2024-12-04

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| domain | STRING | NULLABLE | 域名 |
| product_link | STRING | NULLABLE | 商品链接 |
| product_data | STRING | NULLABLE | 商品数据 |
| dt | DATE | NULLABLE | 分区，日期 |
| product_title | STRING | NULLABLE | 商品标题 |
| product_image | STRING | NULLABLE | 商品图片 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.ads_favie_product_sample_daily`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:25
**扫描工具**: scan_metadata_v2.py
