# rpt_favie_gensmo_replica_chain_view

**表全名**: `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_replica_chain_view`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| pic_0 | STRING | NULLABLE | - |
| beh_0 | STRING | NULLABLE | - |
| prompt_1 | STRING | NULLABLE | - |
| pic_1 | STRING | NULLABLE | - |
| beh_1 | STRING | NULLABLE | - |
| prompt_2 | STRING | NULLABLE | - |
| pic_2 | STRING | NULLABLE | - |
| beh_2 | STRING | NULLABLE | - |
| prompt_3 | STRING | NULLABLE | - |
| pic_3 | STRING | NULLABLE | - |
| beh_3 | STRING | NULLABLE | - |
| prompt_4 | STRING | NULLABLE | - |
| pic_4 | STRING | NULLABLE | - |
| beh_4 | STRING | NULLABLE | - |
| prompt_5 | STRING | NULLABLE | - |
| pic_5 | STRING | NULLABLE | - |
| beh_5 | STRING | NULLABLE | - |
| prompt_6 | STRING | NULLABLE | - |
| pic_6 | STRING | NULLABLE | - |
| beh_6 | STRING | NULLABLE | - |
| prompt_7 | STRING | NULLABLE | - |
| pic_7 | STRING | NULLABLE | - |
| beh_7 | STRING | NULLABLE | - |
| prompt_8 | STRING | NULLABLE | - |
| pic_8 | STRING | NULLABLE | - |
| beh_8 | STRING | NULLABLE | - |
| prompt_9 | STRING | NULLABLE | - |
| pic_9 | STRING | NULLABLE | - |
| beh_9 | STRING | NULLABLE | - |
| prompt_10 | STRING | NULLABLE | - |
| pic_10 | STRING | NULLABLE | - |
| beh_10 | STRING | NULLABLE | - |
| prompt_11 | STRING | NULLABLE | - |
| pic_11 | STRING | NULLABLE | - |
| beh_11 | STRING | NULLABLE | - |
| prompt_12 | STRING | NULLABLE | - |
| pic_12 | STRING | NULLABLE | - |
| beh_12 | STRING | NULLABLE | - |
| prompt_13 | STRING | NULLABLE | - |
| pic_13 | STRING | NULLABLE | - |
| beh_13 | STRING | NULLABLE | - |
| prompt_14 | STRING | NULLABLE | - |
| pic_14 | STRING | NULLABLE | - |
| beh_14 | STRING | NULLABLE | - |
| prompt_15 | STRING | NULLABLE | - |
| pic_15 | STRING | NULLABLE | - |
| beh_15 | STRING | NULLABLE | - |
| prompt_16 | STRING | NULLABLE | - |
| pic_16 | STRING | NULLABLE | - |
| beh_16 | STRING | NULLABLE | - |
| prompt_17 | STRING | NULLABLE | - |
| pic_17 | STRING | NULLABLE | - |
| beh_17 | STRING | NULLABLE | - |
| prompt_18 | STRING | NULLABLE | - |
| pic_18 | STRING | NULLABLE | - |
| beh_18 | STRING | NULLABLE | - |
| prompt_19 | STRING | NULLABLE | - |
| pic_19 | STRING | NULLABLE | - |
| beh_19 | STRING | NULLABLE | - |
| prompt_20 | STRING | NULLABLE | - |
| pic_20 | STRING | NULLABLE | - |
| beh_20 | STRING | NULLABLE | - |
| prompt_21 | STRING | NULLABLE | - |
| pic_21 | STRING | NULLABLE | - |
| beh_21 | STRING | NULLABLE | - |
| prompt_22 | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` (dim_gem_user_replica_view)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_replica_chain_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:14
**扫描工具**: scan_metadata_v2.py
