# dwd_favie_product_detail_gen_image_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_gen_image_inc_1d`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 66,683 行
**大小**: 0.03 GB
**创建时间**: 2025-09-26
**最后更新**: 2025-09-26

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | 商品SKU ID |
| f_image_list | STRING | NULLABLE | 商品图片列表，JSON字符串 |
| f_meta | STRING | NULLABLE | 商品元信息，JSON字符串 |
| dt | DATE | NULLABLE | 数据日期，格式yyyy-MM-dd |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_gen_image_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:32
**扫描工具**: scan_metadata_v2.py
