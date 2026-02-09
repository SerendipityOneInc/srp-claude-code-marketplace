# partition_record_table

**表全名**: `srpproduct-dc37e.favie_dw.partition_record_table`
**层级**: 未分类
**业务域**: other
**表类型**: TABLE
**行数**: 4,319 行
**大小**: 0.00 GB
**创建时间**: 2025-12-08
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期，表示事件发生的日期 |
| table_name | STRING | NULLABLE | 表名称，标识具体的数据表 |
| biz_condition | STRING | NULLABLE | 业务条件，描述数据所属的业务场景或条件 |
| created_at | TIMESTAMP | NULLABLE | 表创建时间，表示表的创建时间 |
| updated_at | TIMESTAMP | NULLABLE | 表更新时间，表示表的最后更新时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.partition_record_table`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:05
**扫描工具**: scan_metadata_v2.py
