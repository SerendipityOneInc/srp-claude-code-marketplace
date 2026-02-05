# dws_gem_growth_creative_ad_skan_classic_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_growth_creative_ad_skan_classic_inc_1d`
**层级**: DWS (汇总层)
**业务域**: advertising
**表类型**: TABLE
**行数**: 73,992 行
**大小**: 0.05 GB
**创建时间**: 2025-12-01
**最后更新**: 2026-01-30

---

## 📊 表说明

Gensmo广告创意维度的SKAN和Classic归因指标增量表，包含创意级别的广告花费、转化、用户行为等指标

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
| country_code | STRING | NULLABLE | 国家代码 |
| ad_category | STRING | NULLABLE | 广告类别 |
| account_put_type | STRING | NULLABLE | 账户投放类型 |
| account_open_agency | STRING | NULLABLE | 账户开户代理 |
| attribution_method | STRING | NULLABLE | 归因方式：SKAN、CLASSIC、BOTH |
| creative_id | STRING | NULLABLE | 创意ID |
| creative_name | STRING | NULLABLE | 创意名称 |
| creative_type | STRING | NULLABLE | 创意类型：视频、图片等 |
| f_creative_id | STRING | NULLABLE | 统一创意ID |
| f_creative_name | STRING | NULLABLE | 统一创意名称 |
| f_creative_url | STRING | NULLABLE | 统一创意素材URL |
| f_creative_type | STRING | NULLABLE | 统一创意素材类型 |
| tag_source | STRING | NULLABLE | 标签来源 |
| creative_language_tag | STRING | NULLABLE | 创意语言标签 |
| creative_func_tag | STRING | NULLABLE | 创意功能标签 |
| creative_source_tag | STRING | NULLABLE | 创意来源标签 |
| creative_race_tag | STRING | NULLABLE | 创意种族标签 |
| creative_gender_tag | STRING | NULLABLE | 创意性别标签 |
| creative_created_at | DATE | NULLABLE | 创意创建时间 |
| google_youtube_video_id | STRING | NULLABLE | Google YouTube视频ID |
| google_youtube_video_title | STRING | NULLABLE | Google YouTube视频标题 |
| channel | STRING | NULLABLE | 渠道：ON_LINE、SKAN |
| creative_impression | FLOAT | NULLABLE | 创意维度的曝光数 |
| creative_click | FLOAT | NULLABLE | 创意维度的点击数 |
| creative_conversion | FLOAT | NULLABLE | 创意维度的转化数 |
| creative_cost | FLOAT | NULLABLE | 创意维度的花费 |
| impression | FLOAT | NULLABLE | 按权重分配后的曝光数 |
| click | FLOAT | NULLABLE | 按权重分配后的点击数 |
| conversion | FLOAT | NULLABLE | 按权重分配后的转化数 |
| cost | FLOAT | NULLABLE | 按权重分配后的花费 |
| creative_install_cnt | FLOAT | NULLABLE | 按权重分配后的安装数 |
| creative_new_user_cnt | FLOAT | NULLABLE | 按权重分配后的新用户数 |
| creative_d0_active_cnt | FLOAT | NULLABLE | 按权重分配后的D0活跃用户数 |
| creative_d1_retention_cnt | FLOAT | NULLABLE | 按权重分配后的D1留存用户数 |
| creative_lt7_cnt | FLOAT | NULLABLE | 按权重分配后的LT7用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_growth_creative_ad_skan_classic_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:44
**扫描工具**: scan_metadata_v2.py
