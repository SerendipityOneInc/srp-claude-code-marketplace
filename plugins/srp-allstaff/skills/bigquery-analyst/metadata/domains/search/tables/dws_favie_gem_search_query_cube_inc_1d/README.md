# dws_favie_gem_search_query_cube_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_search_query_cube_inc_1d`
**层级**: DWS (汇总层)
**业务域**: search
**表类型**: TABLE
**行数**: 104,204 行
**大小**: 0.02 GB
**创建时间**: 2025-10-08
**最后更新**: 2025-10-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| raw_query | STRING | NULLABLE | - |
| qr_query | STRING | NULLABLE | - |
| qp_query | STRING | NULLABLE | - |
| query_modality | STRING | NULLABLE | - |
| query_source | STRING | NULLABLE | - |
| query_intention_level1 | STRING | NULLABLE | - |
| query_intention_level2 | STRING | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| raw_query_word_amt | INTEGER | NULLABLE | - |
| qr_query_word_amt | INTEGER | NULLABLE | - |
| qp_query_word_amt | INTEGER | NULLABLE | - |
| query_cnt | INTEGER | NULLABLE | - |
| query_user_uniq_cnt | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gem_search_query_cube_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:40
**扫描工具**: scan_metadata_v2.py
