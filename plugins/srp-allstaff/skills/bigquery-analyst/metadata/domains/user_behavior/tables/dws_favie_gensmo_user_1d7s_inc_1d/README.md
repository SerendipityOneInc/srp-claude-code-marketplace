# dws_favie_gensmo_user_1d7s_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_1d7s_inc_1d`
**层级**: DWS (汇总层)
**业务域**: other
**表类型**: TABLE
**行数**: 7,176 行
**大小**: 0.00 GB
**创建时间**: 2025-09-16
**最后更新**: 2025-09-16

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| base_dt | DATE | NULLABLE | 日期，分区字段，格式YYYY-MM-DD |
| user_login_type | STRING | NULLABLE | 用户登录类型（登陆、未登陆） |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| function_type | STRING | NULLABLE | 用户回访深度行为类型 |
| active_user_cnt | INTEGER | NULLABLE | 基准日活跃数 |
| revisit_user_cnt | INTEGER | NULLABLE | 至少 1 次回访数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_1d7s_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:14
**扫描工具**: scan_metadata_v2.py
