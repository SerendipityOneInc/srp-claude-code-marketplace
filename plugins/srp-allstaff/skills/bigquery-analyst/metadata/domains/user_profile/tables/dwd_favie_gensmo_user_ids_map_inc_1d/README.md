# dwd_favie_gensmo_user_ids_map_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: TABLE
**行数**: 1,401,786 行
**大小**: 0.12 GB
**创建时间**: 2025-08-16
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| user_id | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:02
**扫描工具**: scan_metadata_v2.py
