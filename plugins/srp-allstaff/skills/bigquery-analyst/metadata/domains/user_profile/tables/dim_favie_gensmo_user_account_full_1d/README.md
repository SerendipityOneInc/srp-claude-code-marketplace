# dim_favie_gensmo_user_account_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_full_1d`
**层级**: 未分类
**业务域**: other
**表类型**: TABLE
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-10
**最后更新**: 2025-12-11

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| user_name | STRING | NULLABLE | - |
| user_email | STRING | NULLABLE | - |
| user_phone | STRING | NULLABLE | - |
| user_type | INTEGER | NULLABLE | - |
| last_device_id | STRING | NULLABLE | - |
| device_ids | STRING | REPEATED | - |
| first_device_id | STRING | NULLABLE | - |
| updated_at | TIMESTAMP | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |
| is_internal_user | BOOLEAN | NULLABLE | - |
| is_bot_user | BOOLEAN | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:18
**扫描工具**: scan_metadata_v2.py
