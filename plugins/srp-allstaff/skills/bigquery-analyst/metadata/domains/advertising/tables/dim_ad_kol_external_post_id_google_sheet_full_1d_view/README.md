# dim_ad_kol_external_post_id_google_sheet_full_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_kol_external_post_id_google_sheet_full_1d_view`
**层级**: 未分类
**业务域**: advertising
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-11
**最后更新**: 2025-11-11

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| app_name | STRING | NULLABLE | 应用名称 |
| post_id | STRING | NULLABLE | 帖子ID |
| brief_type | STRING | NULLABLE | Brief类型 |
| function_tag | STRING | NULLABLE | 功能标签 |
| handle | STRING | NULLABLE | 账号Handle |
| campaign | STRING | NULLABLE | Campaign |
| platform | STRING | NULLABLE | 平台 |
| tier | STRING | NULLABLE | 层级 |
| post_time | STRING | NULLABLE | 发帖时间 |
| post_link | STRING | NULLABLE | 帖子链接 |
| cost | FLOAT | NULLABLE | 合同成本 |
| source | STRING | NULLABLE | 数据源 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_kol_external_post_id_google_sheet_full_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:04
**扫描工具**: scan_metadata_v2.py
