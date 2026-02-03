# rpt_webpage_quality_source_update_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_webpage_quality_source_update_inc_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 6,172 行
**大小**: 0.00 GB
**创建时间**: 2024-12-13
**最后更新**: 2025-12-17

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| parser_name | STRING | NULLABLE | 爬虫名称 |
| source_type | STRING | NULLABLE | 数据源类型 |
| domain | STRING | NULLABLE | 站点 |
| dt | DATE | NULLABLE | 日期 |
| total_update_times | INTEGER | NULLABLE | 总更新次数 |
| effective_update_times | INTEGER | NULLABLE | 有效更新次数 |
| ineffective_update_times | INTEGER | NULLABLE | 无效更新次数 |
| update_url_cnt | INTEGER | NULLABLE | 更新URL数 |
| new_added_url_cnt | INTEGER | NULLABLE | 新增URL数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_webpage_quality_source_update_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:24
**扫描工具**: scan_metadata_v2.py
