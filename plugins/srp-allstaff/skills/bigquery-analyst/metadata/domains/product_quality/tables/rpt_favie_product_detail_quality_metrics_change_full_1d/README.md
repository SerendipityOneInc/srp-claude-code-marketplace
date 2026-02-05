# rpt_favie_product_detail_quality_metrics_change_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_quality_metrics_change_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 5,528,909 行
**大小**: 1.88 GB
**创建时间**: 2024-12-25
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | 站点 |
| shop_site | STRING | NULLABLE | 店铺站点 |
| total_sku_cnt | INTEGER | NULLABLE | 总商品数 |
| title_change_cnt | INTEGER | NULLABLE | 标题变化商品数 |
| title_not_null_cnt | INTEGER | NULLABLE | 标题非空商品数 |
| title_fill_ratio | FLOAT | NULLABLE | 标题填充率 |
| title_change_ratio | FLOAT | NULLABLE | 标题变化率 |
| link_change_cnt | INTEGER | NULLABLE | 链接变化商品数 |
| link_not_null_cnt | INTEGER | NULLABLE | 链接非空商品数 |
| link_fill_ratio | FLOAT | NULLABLE | 链接填充率 |
| link_change_ratio | FLOAT | NULLABLE | 链接变化率 |
| description_change_cnt | INTEGER | NULLABLE | 描述变化商品数 |
| description_not_null_cnt | INTEGER | NULLABLE | 描述非空商品数 |
| description_fill_ratio | FLOAT | NULLABLE | 描述填充率 |
| description_change_ratio | FLOAT | NULLABLE | 描述变化率 |
| keywords_change_cnt | INTEGER | NULLABLE | 关键词变化商品数 |
| keywords_not_null_cnt | INTEGER | NULLABLE | 关键词非空商品数 |
| keywords_fill_ratio | FLOAT | NULLABLE | 关键词填充率 |
| keywords_change_ratio | FLOAT | NULLABLE | 关键词变化率 |
| spu_id_change_cnt | INTEGER | NULLABLE | SPU ID变化商品数 |
| spu_id_not_null_cnt | INTEGER | NULLABLE | SPU ID非空商品数 |
| spu_id_fill_ratio | FLOAT | NULLABLE | SPU ID填充率 |
| spu_id_change_ratio | FLOAT | NULLABLE | SPU ID变化率 |
| images_change_cnt | INTEGER | NULLABLE | 图片变化商品数 |
| images_not_null_cnt | INTEGER | NULLABLE | 图片非空商品数 |
| images_fill_ratio | FLOAT | NULLABLE | 图片填充率 |
| images_change_ratio | FLOAT | NULLABLE | 图片变化率 |
| attributes_change_cnt | INTEGER | NULLABLE | 属性变化商品数 |
| attributes_not_null_cnt | INTEGER | NULLABLE | 属性非空商品数 |
| attributes_fill_ratio | FLOAT | NULLABLE | 属性填充率 |
| attributes_change_ratio | FLOAT | NULLABLE | 属性变化率 |
| categories_change_cnt | INTEGER | NULLABLE | 类目变化商品数 |
| categories_not_null_cnt | INTEGER | NULLABLE | 类目非空商品数 |
| categories_fill_ratio | FLOAT | NULLABLE | 类目填充率 |
| categories_change_ratio | FLOAT | NULLABLE | 类目变化率 |
| specifications_change_cnt | INTEGER | NULLABLE | 规格变化商品数 |
| specifications_not_null_cnt | INTEGER | NULLABLE | 规格非空商品数 |
| specifications_fill_ratio | FLOAT | NULLABLE | 规格填充率 |
| specifications_change_ratio | FLOAT | NULLABLE | 规格变化率 |
| feature_bullets_change_cnt | INTEGER | NULLABLE | 特性点变化商品数 |
| feature_bullets_not_null_cnt | INTEGER | NULLABLE | 特性点非空商品数 |
| feature_bullets_fill_ratio | FLOAT | NULLABLE | 特性点填充率 |
| feature_bullets_change_ratio | FLOAT | NULLABLE | 特性点变化率 |
| dt | DATE | NULLABLE | 日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_quality_metrics_change_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:16
**扫描工具**: scan_metadata_v2.py
