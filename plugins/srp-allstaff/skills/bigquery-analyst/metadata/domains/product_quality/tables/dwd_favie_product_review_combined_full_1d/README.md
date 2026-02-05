# dwd_favie_product_review_combined_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 25,339,063 行
**大小**: 116.83 GB
**创建时间**: 2026-01-07
**最后更新**: 2026-01-26

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| f_spu_id | STRING | NULLABLE | 商品SPU |
| combined_title_body | STRING | NULLABLE | 商品标题和评论内容拼接 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:43
**扫描工具**: scan_metadata_v2.py
