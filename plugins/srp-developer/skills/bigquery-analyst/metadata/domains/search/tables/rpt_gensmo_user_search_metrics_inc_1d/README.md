# rpt_gensmo_user_search_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_search_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: TABLE
**行数**: 1,578,218 行
**大小**: 0.23 GB
**创建时间**: 2025-07-15
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区 |
| user_tenure_type | STRING | NULLABLE | 用户新老类型 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| country_name | STRING | NULLABLE | 国家名 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | app版本 |
| user_group | STRING | NULLABLE | 用户分组 |
| search_trigger_pv_cnt | INTEGER | NULLABLE | 发起collage生成的pv数 |
| search_boot_page_view_pv_cnt | INTEGER | NULLABLE | search_boot页曝光pv |
| search_boot_polish_pv_cnt | INTEGER | NULLABLE | search_boot页polish功能点击数 |
| search_boot_focus_pv_cnt | INTEGER | NULLABLE | search_boot页InputBox Focus点击数 |
| search_trigger_user_cnt | INTEGER | NULLABLE | 发起collage生成的用户数 |
| search_boot_page_view_user_cnt | INTEGER | NULLABLE | search_boot页曝光用户数 |
| search_boot_polish_user_cnt | INTEGER | NULLABLE | search_boot页polish功能点击用户数 |
| search_boot_focus_user_cnt | INTEGER | NULLABLE | search_boot页InputBox Focus点击用户数 |
| DAU | INTEGER | NULLABLE | 日活跃用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_search_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:45
**扫描工具**: scan_metadata_v2.py
