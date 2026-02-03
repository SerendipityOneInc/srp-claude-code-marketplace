# dim_favie_decofy_user_account_scd2_1d

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_decofy_user_account_scd2_1d`
**层级**: 未分类
**业务域**: decofy
**表类型**: TABLE
**行数**: 31,464 行
**大小**: 0.01 GB
**创建时间**: 2025-10-05
**最后更新**: 2026-01-30

---

## 📊 表说明

Decofy用户账号变更日志明细表，记录用户账号的设备、地理、应用等变更信息。end_date=9999-12-31 表示当前有效记录。

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| scd2_sk | STRING | REQUIRED | 系统主键，唯一标识一条记录 |
| start_date | DATE | NULLABLE | SCD2：本条记录生效的起始日期 |
| end_date | DATE | NULLABLE | SCD2：本条记录失效的截止日期，若为9999-12-31表示当前有效 |
| is_current | BOOLEAN | NULLABLE | SCD2：是否为当前最新记录，true为最新，false为历史 |
| updated_at | TIMESTAMP | NULLABLE | 更新时间，记录本条变更的最后更新时间 |
| created_at | TIMESTAMP | NULLABLE | 创建时间，记录本条变更的创建时间 |
| user_id | STRING | REQUIRED | 用户ID，唯一标识 |
| device_ids | STRING | REPEATED | 历史所有设备ID列表 |
| user_name | STRING | NULLABLE | 用户名 |
| user_email | STRING | NULLABLE | 用户邮箱 |
| user_type | INTEGER | NULLABLE | 用户类型：0-未注册，1-注册，2-注销 |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| first_access_info | RECORD | NULLABLE | 首次访问信息 |
| last_access_info | RECORD | NULLABLE | 最近访问信息 |
| first_geo_address | RECORD | NULLABLE | 账号注册时的地理位置信息 |
| permanent_geo_address | RECORD | NULLABLE | 常驻地理位置信息 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_decofy_user_account_scd2_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:56
**扫描工具**: scan_metadata_v2.py
