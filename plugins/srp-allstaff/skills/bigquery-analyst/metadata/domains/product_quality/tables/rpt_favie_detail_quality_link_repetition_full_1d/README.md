# rpt_favie_detail_quality_link_repetition_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_detail_quality_link_repetition_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 27,630,241,109 行
**大小**: 4308.32 GB
**创建时间**: 2024-12-26
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| link | STRING | NULLABLE | 链接 |
| site | STRING | NULLABLE | 站点 |
| shop_site | STRING | NULLABLE | 店铺站点 |
| repetition_f_sku_id_cnt | INTEGER | NULLABLE | 重复商品数 |
| repetition_f_sku_id_list | STRING | REPEATED | 重复商品列表 |
| dt | DATE | NULLABLE | 日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_detail_quality_link_repetition_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:50
**扫描工具**: scan_metadata_v2.py
