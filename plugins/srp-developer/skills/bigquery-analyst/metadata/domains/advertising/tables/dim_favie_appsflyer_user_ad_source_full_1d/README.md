# dim_favie_appsflyer_user_ad_source_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_user_ad_source_full_1d`
**层级**: 未分类
**业务域**: advertising
**表类型**: TABLE
**行数**: 4,193,571 行
**大小**: 1.10 GB
**创建时间**: 2025-08-14
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 快照日期 |
| created_date | DATE | NULLABLE | 创建日期 |
| appsflyer_id | STRING | NULLABLE | 广告平台用户ID |
| source | STRING | NULLABLE | 广告来源 |
| channel | STRING | NULLABLE | 广告渠道 |
| platform | STRING | NULLABLE | 平台 |
| campaign_id | STRING | NULLABLE | 广告活动ID |
| campaign_name | STRING | NULLABLE | 广告活动名称 |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_group_name | STRING | NULLABLE | 广告组名称 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_name | STRING | NULLABLE | 广告名称 |
| country_code | STRING | NULLABLE | 国家代码 |
| event_name | STRING | NULLABLE | 事件名称 |
| app_name | STRING | NULLABLE | 应用名称 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_user_ad_source_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:53
**扫描工具**: scan_metadata_v2.py
