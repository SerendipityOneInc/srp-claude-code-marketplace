# rpt_gensmo_refer_click_user_penetration_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 153,900,195 行
**大小**: 26.52 GB
**创建时间**: 2025-12-17
**最后更新**: 2026-01-30

---

## 📊 表说明

Gensmo refer点击用户渗透率报表

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期 |
| refer | STRING | NULLABLE | 引荐来源/来源页面 |
| ap_name | STRING | NULLABLE | 埋点名称 |
| user_group | STRING | NULLABLE | 用户分组 |
| country_name | STRING | NULLABLE | 国家名称 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| user_tenure_type | STRING | NULLABLE | 用户生命周期类型 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| ad_id | STRING | NULLABLE | 广告ID |
| pv_user_cnt | INTEGER | NULLABLE | 页面浏览用户数 |
| click_user_cnt | INTEGER | NULLABLE | 点击用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:12
**扫描工具**: scan_metadata_v2.py
