# rpt_favie_feed_user_operation_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_feed_user_operation_inc_1d`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: TABLE
**行数**: 131,737 行
**大小**: 0.02 GB
**创建时间**: 2025-08-07
**最后更新**: 2025-08-07

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| event_date | DATE | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| country | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| operating_system | STRING | NULLABLE | - |
| is_new_user | BOOLEAN | NULLABLE | - |
| first_device_id | STRING | NULLABLE | - |
| user_view_cnt | INTEGER | NULLABLE | - |
| user_click_cnt | INTEGER | NULLABLE | - |
| user_share_cnt | INTEGER | NULLABLE | - |
| user_try_on_cnt | INTEGER | NULLABLE | - |
| user_remix_cnt | INTEGER | NULLABLE | - |
| save_cnt | INTEGER | NULLABLE | - |
| product_click_cnt | INTEGER | NULLABLE | - |
| product_link_click_cnt | INTEGER | NULLABLE | - |
| duration | FLOAT | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_feed_user_operation_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:59
**扫描工具**: scan_metadata_v2.py
