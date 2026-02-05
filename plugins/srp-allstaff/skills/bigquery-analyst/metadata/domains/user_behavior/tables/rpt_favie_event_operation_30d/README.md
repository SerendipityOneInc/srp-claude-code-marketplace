# rpt_favie_event_operation_30d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_event_operation_30d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 114,776,519 行
**大小**: 41.65 GB
**创建时间**: 2026-01-29
**最后更新**: 2026-01-29

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| item | RECORD | NULLABLE | - |
| collage_id | STRING | NULLABLE | - |
| created_date | DATE | NULLABLE | - |
| created_user_id | STRING | NULLABLE | - |
| collage_title | STRING | NULLABLE | - |
| collage_description | STRING | NULLABLE | - |
| category | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| publisher | STRING | NULLABLE | - |
| is_feed | BOOLEAN | NULLABLE | - |
| event_date | DATE | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| user_pseudo_id | STRING | NULLABLE | - |
| refer | STRING | NULLABLE | - |
| ap_name | STRING | NULLABLE | - |
| event_action_type | STRING | NULLABLE | - |
| method | STRING | NULLABLE | - |
| operating_system | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| country | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |
| first_device_id | STRING | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| user_created_date | DATE | NULLABLE | - |
| is_new_user | BOOLEAN | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_event_operation_30d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:52
**扫描工具**: scan_metadata_v2.py
