# rpt_gem_search_item_merge_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_search_item_merge_inc_1d`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: TABLE
**行数**: 7,519,167 行
**大小**: 4.24 GB
**创建时间**: 2025-08-27
**最后更新**: 2025-08-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 统计日期（按事件发生日期） |
| trace_id | STRING | NULLABLE | 搜索 trace_id |
| search_image | STRING | NULLABLE | 用户上传或搜索的图片 URL |
| collage_number | INTEGER | NULLABLE | 拼贴编号（collage_number） |
| created_time | TIMESTAMP | NULLABLE | 事件发生时间 |
| product_main_image_url | STRING | NULLABLE | 匹配的商品主图 URL |
| created_date | DATE | NULLABLE | 事件发生日期，取自 created_time |
| product_image_info | STRING | NULLABLE | 商品图片的详细信息 JSON |
| best_view | INTEGER | NULLABLE | 商品图片是否最佳视角（0/1） |
| has_person | INTEGER | NULLABLE | 商品图片是否有人物（0/1） |
| is_bad | INTEGER | NULLABLE | 商品图片是否为低质（0/1） |
| is_clear_background | INTEGER | NULLABLE | 商品图片背景是否清晰（0/1） |
| is_relevant | INTEGER | NULLABLE | 商品图片是否相关（0/1） |
| is_nice_collage | BOOLEAN | NULLABLE | 是否为优质拼贴 |
| brand | STRING | NULLABLE | 商品品牌 |
| platform | STRING | NULLABLE | 商品平台 |
| link_host | STRING | NULLABLE | 商品链接域名 |
| intention | STRING | NULLABLE | 用户搜索意图 |
| user_id | STRING | NULLABLE | 用户 ID |
| region | STRING | NULLABLE | 用户地区 |
| product_search_engine | STRING | NULLABLE | 使用的商品搜索引擎 |
| route | STRING | NULLABLE | QR debug route |
| gender | STRING | NULLABLE | 用户性别 |
| device_id | STRING | NULLABLE | 设备 ID |
| f_version | STRING | NULLABLE | 客户端版本 |
| cf_ipcountry | STRING | NULLABLE | 客户端 IP 国家 |
| query | STRING | NULLABLE | 用户搜索 query |
| f_source | STRING | NULLABLE | 搜索来源 |
| search_latency | FLOAT | NULLABLE | 搜索延迟 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gem_search_item_merge_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:08
**扫描工具**: scan_metadata_v2.py
