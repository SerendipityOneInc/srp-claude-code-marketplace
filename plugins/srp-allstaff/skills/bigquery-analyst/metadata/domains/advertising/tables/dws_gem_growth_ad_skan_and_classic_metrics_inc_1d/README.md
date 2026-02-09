# dws_gem_growth_ad_skan_and_classic_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: advertising
**表类型**: TABLE
**行数**: 129,729 行
**大小**: 0.05 GB
**创建时间**: 2025-10-31
**最后更新**: 2026-01-30

---

## 📊 表说明

Gensmo广告SKAN和Classic归因指标增量表，包含广告花费、转化、用户行为等指标

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | REQUIRED | 数据日期 |
| source | STRING | NULLABLE | 广告来源：Meta Ads、Google Ads、TikTok Ads等 |
| platform | STRING | NULLABLE | 平台：IOS、ANDROID |
| app_name | STRING | NULLABLE | 应用名称：Gensmo |
| account_id | STRING | NULLABLE | 广告账户ID |
| account_name | STRING | NULLABLE | 广告账户名称 |
| campaign_id | STRING | NULLABLE | 广告活动ID |
| campaign_name | STRING | NULLABLE | 广告活动名称 |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_group_name | STRING | NULLABLE | 广告组名称 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_name | STRING | NULLABLE | 广告名称 |
| ad_category | STRING | NULLABLE | 广告类别 |
| country_code | STRING | NULLABLE | 国家代码 |
| channel | STRING | NULLABLE | 渠道：ON_LINE、SKAN |
| attribution_method | STRING | NULLABLE | 归因方法：SKAN、CLASSIC、BOTH |
| account_put_type | STRING | NULLABLE | 账户投放类型 |
| account_open_agency | STRING | NULLABLE | 账户开户代理 |
| impression | FLOAT | NULLABLE | 曝光数 |
| click | FLOAT | NULLABLE | 点击数 |
| conversion | FLOAT | NULLABLE | 转化数 |
| cost | FLOAT | NULLABLE | 花费 |
| install_cnt | FLOAT | NULLABLE | 安装数 |
| new_user_cnt | FLOAT | NULLABLE | 新用户数 |
| d0_active_cnt | FLOAT | NULLABLE | D0活跃用户数 |
| d1_retention_cnt | FLOAT | NULLABLE | D1留存用户数 |
| lt7_cnt | FLOAT | NULLABLE | LT7（7天生命周期价值）用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:35
**扫描工具**: scan_metadata_v2.py
