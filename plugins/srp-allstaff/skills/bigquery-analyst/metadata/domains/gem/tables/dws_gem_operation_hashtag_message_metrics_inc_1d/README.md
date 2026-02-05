# dws_gem_operation_hashtag_message_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_hashtag_message_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: gem
**表类型**: TABLE
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-09-29
**最后更新**: 2025-09-29

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 统计日期 |
| user_id | STRING | NULLABLE | 用户ID |
| device_id | STRING | NULLABLE | 设备ID |
| event_item_item_id | STRING | NULLABLE | Hashtag ID |
| count_hashtag | INTEGER | NULLABLE | 该设备/用户在当天点击该Hashtag的次数 |
| user_group | STRING | NULLABLE | 用户分群 |
| country_name | STRING | NULLABLE | 国家/地区 |
| platform | STRING | NULLABLE | 平台/端 |
| app_version | STRING | NULLABLE | APP版本 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| user_tenure_type | STRING | NULLABLE | 用户新老类型 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_operation_hashtag_message_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:52
**扫描工具**: scan_metadata_v2.py
