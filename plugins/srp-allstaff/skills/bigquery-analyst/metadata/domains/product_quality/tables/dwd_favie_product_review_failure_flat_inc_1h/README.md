# dwd_favie_product_review_failure_flat_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_review_failure_flat_inc_1h`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-01-09
**最后更新**: 2025-01-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_review_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| spu_id | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| review_id | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| body | STRING | NULLABLE | - |
| body_html | STRING | NULLABLE | - |
| link | STRING | NULLABLE | - |
| images | STRING | NULLABLE | - |
| f_images | STRING | NULLABLE | - |
| videos | STRING | NULLABLE | - |
| f_videos | STRING | NULLABLE | - |
| rating | FLOAT | NULLABLE | - |
| date_raw | STRING | NULLABLE | - |
| date_utc | STRING | NULLABLE | - |
| author_name | STRING | NULLABLE | - |
| author_id | STRING | NULLABLE | - |
| author_url | STRING | NULLABLE | - |
| vine_program | BOOLEAN | NULLABLE | - |
| verified_purchase | BOOLEAN | NULLABLE | - |
| review_country | STRING | NULLABLE | - |
| is_global_review | BOOLEAN | NULLABLE | - |
| position | INTEGER | NULLABLE | - |
| helpful_votes | INTEGER | NULLABLE | - |
| unhelpful_votes | INTEGER | NULLABLE | - |
| stark_tag | INTEGER | NULLABLE | - |
| stark_tags | STRING | NULLABLE | - |
| f_meta | STRING | NULLABLE | - |
| f_updates_at | STRING | NULLABLE | - |
| f_creates_at | STRING | NULLABLE | - |
| f_system_tags | STRING | NULLABLE | - |
| f_image_list | STRING | NULLABLE | - |
| f_status | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_review_failure_flat_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:44
**扫描工具**: scan_metadata_v2.py
