# rpt_favie_product_sample_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_sample_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 314,474 行
**大小**: 1.77 GB
**创建时间**: 2024-11-13
**最后更新**: 2025-11-18

---

## 📊 表说明

所属业务库: 商品详情库  
所属数仓层级: RPT层(分析层)
分区字段: dt（字段格式 yyyy-MM-dd）
更新策略: 每日更新
模型主键: domain
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）: 永久
用途: >
  此表是针对于每日商品详情全量表的抽检,以更好更直观的观测数据的质量

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| domain | STRING | NULLABLE | 域名 |
| product_link | STRING | NULLABLE | 商品链接 |
| product_title | STRING | NULLABLE | 商品标题 |
| product_image | STRING | NULLABLE | 商品图片 |
| product_data | STRING | NULLABLE | 商品数据 |
| dt | DATE | NULLABLE | 分区，日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_sample_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:30
**扫描工具**: scan_metadata_v2.py
