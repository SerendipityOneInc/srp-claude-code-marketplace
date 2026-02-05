# favie_product_detail_bigtable_external

**表全名**: `srpproduct-dc37e.favie_dw.favie_product_detail_bigtable_external`
**层级**: 未分类
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-10
**最后更新**: 2025-02-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| rowkey | STRING | NULLABLE | - |
| m_base | RECORD | NULLABLE | - |
| m_variants | RECORD | NULLABLE | - |
| m_sale | RECORD | NULLABLE | - |
| m_raw | RECORD | NULLABLE | - |
| m_his | RECORD | NULLABLE | - |
| m_media | RECORD | NULLABLE | - |
| m_sys | RECORD | NULLABLE | - |
| m_desc | RECORD | NULLABLE | - |
| m_attr | RECORD | NULLABLE | - |
| e_tag | RECORD | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.favie_product_detail_bigtable_external`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:46
**扫描工具**: scan_metadata_v2.py
