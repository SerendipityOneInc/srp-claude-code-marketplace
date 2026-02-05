# rpt_decofy_subscribe_notification_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_notification_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 2,916 行
**大小**: 0.00 GB
**创建时间**: 2025-09-05
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区字段，格式YYYY-MM-DD |
| country_name | STRING | NULLABLE | 国家或地区名称 |
| platform | STRING | NULLABLE | 用户平台，如 iOS、Android、Web |
| app_version | STRING | NULLABLE | 应用版本号 |
| user_group | STRING | NULLABLE | 用户分群标签 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| product_id | STRING | NULLABLE | 订阅产品ID |
| simple_product_id | STRING | NULLABLE | 简化产品ID |
| subscribe_disable_notification_cnt | INTEGER | NULLABLE | 订阅禁用通知次数 |
| subscribe_refund_notification_cnt | INTEGER | NULLABLE | 订阅退款通知次数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_notification_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:06
**扫描工具**: scan_metadata_v2.py
