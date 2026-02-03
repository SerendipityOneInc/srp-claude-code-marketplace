# dws_gensmo_user_tryon_duration_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_tryon_duration_inc_1d`
**层级**: DWS (汇总层)
**业务域**: tryon
**表类型**: TABLE
**行数**: 476,600 行
**大小**: 0.06 GB
**创建时间**: 2025-09-09
**最后更新**: 2025-10-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期；分区 |
| device_id | STRING | NULLABLE | 设备ID |
| tryon_complete_interval | INTEGER | NULLABLE | 试穿完成时间间隔 |
| user_group | STRING | NULLABLE | 用户组 |
| user_tenure_type | STRING | NULLABLE | 用户任期类型 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| country_name | STRING | NULLABLE | 国家名称 |
| app_version | STRING | NULLABLE | 应用版本 |
| platform | STRING | NULLABLE | 平台 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_tryon_duration_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:22
**扫描工具**: scan_metadata_v2.py
