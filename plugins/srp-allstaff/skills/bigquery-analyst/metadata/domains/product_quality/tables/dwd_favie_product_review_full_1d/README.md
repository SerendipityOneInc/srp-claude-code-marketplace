# dwd_favie_product_review_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_review_full_1d`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-12-10
**最后更新**: 2024-12-26

---

## 📊 表说明

所属业务库: 商品详情库  
所属数仓层级: DWD层
分区字段: dt（字段格式 yyyy-MM-dd）
更新策略: 每日全量更新
模型主键: f_review_id
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）: 7天
用途: >
  此表是评价库的全量明细数据,每天更新全量数据, 使用dt= {yesterday} 即可查询昨日全量快照,除非有特定需求否则不要选取多天

保持字段含义一致的表集合:
 - favie_dw.dwd_favie_product_review_flat_inc_1h 
 - favie_dw.dwd_favie_product_review_full_1d

 以上表的字段含义、字段名称、字段数量保持一致,在查询字段含义时,如果所目标表没有的字段说明,可以查询表集合的字段含义

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

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_review_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:48
**扫描工具**: scan_metadata_v2.py
