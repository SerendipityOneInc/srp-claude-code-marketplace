# dwd_favie_gensmo_user_recap_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_recap_inc_1d`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: TABLE
**行数**: 15,142,786 行
**大小**: 7.11 GB
**创建时间**: 2025-05-15
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| user_id | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |
| event_type | STRING | NULLABLE | - |
| event_timestamp | TIMESTAMP | NULLABLE | - |
| session_id | STRING | NULLABLE | - |
| item_name | STRING | REPEATED | - |
| item_id | STRING | REPEATED | - |
| item_type | STRING | REPEATED | - |
| item_index | INTEGER | REPEATED | - |
| image_url | STRING | REPEATED | - |
| moodboard_content | STRING | REPEATED | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_recap_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:04
**扫描工具**: scan_metadata_v2.py
