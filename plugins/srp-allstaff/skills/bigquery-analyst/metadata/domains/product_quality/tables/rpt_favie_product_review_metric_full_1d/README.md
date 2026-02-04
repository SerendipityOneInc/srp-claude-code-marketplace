# rpt_favie_product_review_metric_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-11-20
**最后更新**: 2024-12-25

---

## 📊 表说明

所属业务库: 商品详情库  
所属数仓层级: RPT层(分析层)
分区字段: dt（字段格式 yyyy-MM-dd）
主题域:数据质量
更新策略: 每日更新
模型主键: site,shop_site
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）:永久
用途: >
  此表是针对于每日评论全量快照表,以站点维度进行对数据质量分析

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | 站点 |
| total_review_num | INTEGER | REQUIRED | 总评论数 |
| daily_new_review_num | INTEGER | REQUIRED | 每日新增评论数 |
| daily_update_review_num | INTEGER | REQUIRED | 每日更新评论数 |
| daily_spider_update_review_num | INTEGER | REQUIRED | 每日爬虫更新评论数 |
| total_spu_num_with_review | INTEGER | REQUIRED | 带有评论的spu数 |
| spu_num_with_review_count_ge_10 | INTEGER | REQUIRED | 带有大于等于10条评论的spu数 |
| dt | STRING | NULLABLE | 日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:24
**扫描工具**: scan_metadata_v2.py
