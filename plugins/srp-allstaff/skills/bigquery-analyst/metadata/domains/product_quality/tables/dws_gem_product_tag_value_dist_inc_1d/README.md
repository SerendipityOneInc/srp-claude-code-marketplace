# dws_gem_product_tag_value_dist_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_product_tag_value_dist_inc_1d`
**层级**: DWS (汇总层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 679,850 行
**大小**: 0.04 GB
**创建时间**: 2026-01-25
**最后更新**: 2026-01-25

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 事件发生日期 |
| site | STRING | NULLABLE | 商品来源网站（如 us.princesspolly.com） |
| collage_category | STRING | NULLABLE | 商品类别（Top/Bottom/One-Piece等13类+null） |
| tag | STRING | NULLABLE | 标签名称（枚举：occasion, material） |
| tag_value | STRING | NULLABLE | 标签的具体取值（如 'Casual', 'Cotton' 等，未聚合的原始值） |
| sku_cnt | INTEGER | NULLABLE | 在当前维度下，具有相应标签值的 SKU 去重数量 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_product_tag_value_dist_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:59
**扫描工具**: scan_metadata_v2.py
