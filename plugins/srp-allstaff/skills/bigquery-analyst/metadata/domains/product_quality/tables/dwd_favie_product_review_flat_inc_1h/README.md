# dwd_favie_product_review_flat_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_review_flat_inc_1h`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-12-10
**最后更新**: 2024-12-26

---

## 📊 表说明

所属业务库: 评价库  
所属数仓层级: DWD层
分区字段: dt,hour（dt字段格式:yyyy-MM-dd,hour 字段格式:HH）
更新策略: 每小时增量更新
模型主键:f_review_id
负责人:
- 庞宝辉
- 付继文
- 马汝钊  
生命周期（分区TTL）: 7天
用途: >
  此表是评价库的每小时增量明细更新数据

保持字段含义一致的表集合:
 - favie_dw.dwd_favie_product_review_flat_inc_1h 
 - favie_dw.dwd_favie_product_review_full_1d

 以上表的字段含义、字段名称、字段数量保持一致,在查询字段含义时,如果所目标表没有的字段说明,可以查询表集合的字段含义

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_review_id | STRING | NULLABLE | 评论id |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | 站点 |
| spu_id | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| review_id | STRING | NULLABLE | 评论id |
| title | STRING | NULLABLE | 标题 |
| body | STRING | NULLABLE | 评论体 |
| body_html | STRING | NULLABLE | 评论体的html内容 |
| link | STRING | NULLABLE | 链接 |
| images | STRING | NULLABLE | 图片信息 |
| f_images | STRING | NULLABLE | 图片信息 |
| videos | STRING | NULLABLE | 视频信息 |
| f_videos | STRING | NULLABLE | 视频信息 |
| rating | FLOAT | NULLABLE | 评价数量 |
| date_raw | STRING | NULLABLE | raw数据 |
| date_utc | STRING | NULLABLE | - |
| author_name | STRING | NULLABLE | 作者名称 |
| author_id | STRING | NULLABLE | 作者id |
| author_url | STRING | NULLABLE | 作者url |
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
| f_updates_at | STRING | NULLABLE | 更新时间 |
| f_creates_at | STRING | NULLABLE | 创建时间 |
| f_system_tags | STRING | NULLABLE | - |
| f_image_list | STRING | NULLABLE | - |
| f_status | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | 日期 |
| hour | STRING | NULLABLE | 小时 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_review_flat_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:46
**扫描工具**: scan_metadata_v2.py
