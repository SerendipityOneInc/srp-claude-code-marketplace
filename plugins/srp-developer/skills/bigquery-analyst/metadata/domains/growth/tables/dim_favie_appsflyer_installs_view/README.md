# dim_favie_appsflyer_installs_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_installs_view`
**层级**: 未分类
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-05-30
**最后更新**: 2025-05-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| appsflyer_id | STRING | NULLABLE | - |
| app_id | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_set_id | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| ad_media_source | STRING | NULLABLE | - |
| ad_channel | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| event_time | TIMESTAMP | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.gensmo_appsflyer_andriod.in_app_events` (in_app_events)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_installs_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:51
**扫描工具**: scan_metadata_v2.py
