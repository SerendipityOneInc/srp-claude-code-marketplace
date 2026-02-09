# dwd_gem_product_index_merge_config_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_index_merge_config_inc_1d`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 29 行
**大小**: 0.00 GB
**创建时间**: 2026-01-14
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| biz | STRING | NULLABLE | - |
| index_env | STRING | NULLABLE | - |
| merge_mode | STRING | NULLABLE | - |
| model_config | STRING | NULLABLE | - |
| updated_at | TIMESTAMP | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_product_index_merge_config_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:14:07
**扫描工具**: scan_metadata_v2.py
