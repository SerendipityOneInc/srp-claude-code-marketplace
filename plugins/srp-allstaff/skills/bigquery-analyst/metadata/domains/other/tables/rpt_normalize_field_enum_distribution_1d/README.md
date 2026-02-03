# rpt_normalize_field_enum_distribution_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_normalize_field_enum_distribution_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 29,817,317 行
**大小**: 2.89 GB
**创建时间**: 2026-01-28
**最后更新**: 2026-01-30

---

## 📊 表说明

归一化后字段枚举值分布统计表，按日期分区。v2版本新增 mention_ratio 支持数组字段正确的累计覆盖率计算

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| field_name | STRING | NULLABLE | 字段名称 |
| enum_value | STRING | NULLABLE | 归一化后的枚举值 |
| is_array_field | BOOLEAN | NULLABLE | 是否为数组字段（逗号分隔多值） |
| product_count | INTEGER | NULLABLE | 商品数量（包含该枚举值的商品数） |
| product_ratio | FLOAT | NULLABLE | 商品占比 (0-1)，分母为总商品数 |
| mention_count | INTEGER | NULLABLE | 提及次数（数组字段拆分后的行数） |
| mention_ratio | FLOAT | NULLABLE | 提及占比 (0-1)，分母为该字段总提及次数 |
| value_rank | INTEGER | NULLABLE | 排名（按商品数从大到小） |
| cumulative_product_ratio | FLOAT | NULLABLE | 商品累计占比 |
| cumulative_mention_ratio | FLOAT | NULLABLE | 提及累计占比 |
| created_at | TIMESTAMP | NULLABLE | 记录创建时间 |
| dt | DATE | NULLABLE | 统计日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_normalize_field_enum_distribution_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:04
**扫描工具**: scan_metadata_v2.py
