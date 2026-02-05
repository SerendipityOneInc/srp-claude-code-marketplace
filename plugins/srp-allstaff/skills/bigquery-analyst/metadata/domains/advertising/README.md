# 广告投放

**业务域**: advertising
**最后更新**: 2026-01-30
**表数量**: 76 张

---

## 📊 业务概述

广告投放、ROI分析、渠道效果、成本归因

**关键词**: 广告, 投放, ROI, 成本

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `rpt_gem_growth_ad_kol_inc_1d_view` | RPT | --- |
| `dws_gem_growth_ad_inc_7d_agg_view` | DWS | --- |
| `dws_gem_growth_ad_skan_and_classic_metrics_inc_1d` | DWS | --- |
| `dws_gem_growth_ads_insights_country_full_view` | DWS | --- |
| `dwd_ad_tiktok_creative_full_1d_view` | DWD | --- |
| `dwd_all_app_appsflyer_webhook_including_non_ad_inc_1d_view` | DWD | --- |
| `dwd_gem_growth_ad_google_fivetran_by_ad_id_inc_1d_view` | DWD | --- |


更多表请参见 [TABLES.md](./TABLES.md)

---

## 💡 常见查询场景

### 场景 1: (待补充)

**需求**: 待补充业务需求

**推荐表**: 待补充

**示例 SQL**:
```sql
-- 待补充查询示例
SELECT
  dt,
  COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dwd.table_name`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC
```

---

## 🔗 相关资源

- [表清单](./TABLES.md) - 完整表列表
- [通用函数](./common_functions/) - 可复用的查询函数

---

**文档生成**: 2026-01-30 15:33:23
**维护者**: Data Platform Team
