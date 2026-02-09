# dwd_favie_decofy_ab_active_users_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_ab_active_users_inc_1d`
**层级**: DWD (明细层)
**业务域**: user_behavior
**表类型**: TABLE
**行数**: 1,687,770 行
**大小**: 0.19 GB
**创建时间**: 2025-09-06
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| user_id | STRING | NULLABLE | 用户ID |
| ab_project | STRING | NULLABLE | AB测试项目 |
| ab_router | STRING | NULLABLE | AB测试路由 |
| ab_unique_id | STRING | NULLABLE | AB测试唯一ID |
| ab_start_date | DATE | NULLABLE | AB测试开始时间 |
| enter_ab_date | DATE | NULLABLE | 进入AB测试时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_ab_active_users_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:24
**扫描工具**: scan_metadata_v2.py
