# rpt_favie_product_review_metric_full_1w

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_full_1w`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 528 行
**大小**: 0.00 GB
**创建时间**: 2025-12-17
**最后更新**: 2026-01-26

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | 站点 |
| total_review_num | INTEGER | NULLABLE | 总评论数 |
| weekly_new_review_num | INTEGER | NULLABLE | 每周新增评论数 |
| weekly_update_review_num | INTEGER | NULLABLE | 每周更新评论数 |
| total_spu_num_with_review | INTEGER | NULLABLE | 有评论的SPU总数 |
| spu_num_with_review_count_ge_10 | INTEGER | NULLABLE | 评论数>=10的SPU数 |
| dt | DATE | NULLABLE | 日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_full_1w`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:26
**扫描工具**: scan_metadata_v2.py
