# rpt_favie_product_detail_quality_source_update_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_quality_source_update_inc_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 2,166,983 行
**大小**: 0.21 GB
**创建时间**: 2024-12-13
**最后更新**: 2025-12-16

---

## 📊 表说明

所属业务库: 商品详情库  
所属数仓层级: RPT层(分析层)
分区字段: dt（字段格式 yyyy-MM-dd）
主题域:数据质量
更新策略: 每日更新
模型主键: parser_name,source_type,site,shop_site
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）: 永久
用途: >
  此表是针对于每日商品成功变更增量表和每日商品增量失败变更增量表分析每一个爬虫产生数据的质量以及对全量商品详情库的数据质量的影响

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| parser_name | STRING | NULLABLE | 爬虫名称 |
| source_type | STRING | NULLABLE | 数据源类型 |
| site | STRING | NULLABLE | 站点 |
| shop_site | STRING | NULLABLE | 店铺站点 |
| dt | DATE | NULLABLE | 日期 |
| total_update_times | INTEGER | NULLABLE | 总更新次数 |
| effective_update_times | INTEGER | NULLABLE | 有效更新次数 |
| ineffective_update_times | INTEGER | NULLABLE | 无效更新次数 |
| update_sku_cnt | INTEGER | NULLABLE | 更新SKU数 |
| new_added_sku_cnt | INTEGER | NULLABLE | 新增SKU数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_quality_source_update_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:19
**扫描工具**: scan_metadata_v2.py
