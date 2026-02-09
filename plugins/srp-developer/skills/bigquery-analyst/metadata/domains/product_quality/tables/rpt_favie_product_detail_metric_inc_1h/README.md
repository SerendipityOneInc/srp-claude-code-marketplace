# rpt_favie_product_detail_metric_inc_1h

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_metric_inc_1h`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-11-19
**最后更新**: 2024-12-25

---

## 📊 表说明

所属业务库: 商品详情库  
所属数仓层级: RPT层(分析层)
分区字段: dt,hour（字段格式 yyyy-MM-dd）
更新策略: 每日更新
模型主键: site
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）:永久
用途: >
  此表是对于每小时商品详情表以站点维度进行分析的数据表

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | 站点 |
| total_product_num | INTEGER | REQUIRED | 总商品数 |
| product_category_success_num | INTEGER | REQUIRED | 类目映射成功的商品数 |
| product_image_success_num | INTEGER | REQUIRED | 有图片的商品数 |
| product_review_success_num | INTEGER | REQUIRED | 有评论的商品数 |
| update_product_num | INTEGER | REQUIRED | 更新的商品数 |
| spider_update_product_num | INTEGER | REQUIRED | 爬虫更新的商品数 |
| dt | STRING | NULLABLE | 日期 |
| hour | STRING | NULLABLE | 小时 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_metric_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:14
**扫描工具**: scan_metadata_v2.py
