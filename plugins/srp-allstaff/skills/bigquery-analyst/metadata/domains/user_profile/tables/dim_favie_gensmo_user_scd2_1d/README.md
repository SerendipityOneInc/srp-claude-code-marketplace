# dim_favie_gensmo_user_scd2_1d

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_scd2_1d`
**层级**: 未分类
**业务域**: other
**表类型**: TABLE
**行数**: 2,548,532 行
**大小**: 0.72 GB
**创建时间**: 2025-10-23
**最后更新**: 2026-01-30

---

## 📊 表说明

Gensmo用户变更日志明细表，记录用户的账号信息，地理位置信息，访问信息等的变化，is_current=True 表示当前有效记录。

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| scd2_sk | STRING | REQUIRED | 系统主键，唯一标识一条记录 |
| start_date | DATE | NULLABLE | SCD2：本条记录生效的起始日期 |
| end_date | DATE | NULLABLE | SCD2：本条记录失效的截止日期，若为9999-12-31表示当前有效 |
| is_current | BOOLEAN | NULLABLE | SCD2：是否为当前最新记录，true为最新，false为历史 |
| created_at | TIMESTAMP | NULLABLE | 创建时间，记录本条变更的创建时间 |
| device_id | STRING | NULLABLE | 设备ID |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| user_type | STRING | NULLABLE | 用户类型: 未注册-unregistered,注册-registered,注销-deregistered |
| user_accounts | RECORD | REPEATED | 关联的账号列表 |
| first_access_info | RECORD | NULLABLE | - |
| last_access_info | RECORD | NULLABLE | 最近访问和登录信息 |
| first_geo_address | RECORD | NULLABLE | 首次地理位置信息 |
| permanent_geo_address | RECORD | NULLABLE | 常驻地理位置信息 |
| scd2_created_at | TIMESTAMP | NULLABLE | SCD2：记录本条变更的创建时间 |
| scd2_updated_at | TIMESTAMP | NULLABLE | 记录本条变更的处理时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_scd2_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:22
**扫描工具**: scan_metadata_v2.py
