# dws_gensmo_tob_group_trace_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 9,612 行
**大小**: 0.00 GB
**创建时间**: 2026-01-23
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| site | STRING | NULLABLE | 站点 |
| country | STRING | NULLABLE | 国家 |
| impid | STRING | NULLABLE | 曝光ID |
| exp_id | STRING | NULLABLE | 实验ID |
| vibe_list | RECORD | REPEATED | Vibe ID |
| product_id | STRING | NULLABLE | 商品ID |
| product_url | STRING | NULLABLE | 商品链接 |
| product_image_url | STRING | NULLABLE | 商品图片链接 |
| show_cnt | INTEGER | NULLABLE | 展示次数 |
| click_cnt | INTEGER | NULLABLE | 点击次数 |
| unique_click_cnt | INTEGER | NULLABLE | 去重点击次数 |
| unique_click_product_cnt | INTEGER | NULLABLE | 去重点击商品次数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:12
**扫描工具**: scan_metadata_v2.py
