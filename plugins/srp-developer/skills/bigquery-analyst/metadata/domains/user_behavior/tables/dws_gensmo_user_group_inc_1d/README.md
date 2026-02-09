# dws_gensmo_user_group_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 15,130,696 行
**大小**: 3.30 GB
**创建时间**: 2025-11-07
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| user_group | STRING | NULLABLE | 分组名称 |
| device_id | STRING | NULLABLE | 设备ID |
| appsflyer_id | STRING | NULLABLE | Appsflyer追踪ID |
| user_activity_type | STRING | NULLABLE | 用户活跃类型：active, inactive |
| country_name | STRING | NULLABLE | 国家名称 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| user_tenure_segment | STRING | NULLABLE | 用户周期细分类型: New User(1 Day)/New User(2-7 Days)/New User(8-30 Days)/Old User |
| user_tenure_type | STRING | NULLABLE | 用户周期类型: New User/Old User |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| group_type | STRING | NULLABLE | 数据类型：prod_data, temp_data |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:20
**扫描工具**: scan_metadata_v2.py
