# dim_favie_mapping_raw_brand

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_mapping_raw_brand`
**层级**: 未分类
**业务域**: other
**表类型**: TABLE
**行数**: 175,175 行
**大小**: 0.01 GB
**创建时间**: 2025-07-21
**最后更新**: 2025-11-08

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| raw_brand | STRING | NULLABLE | 爬虫数据中的原始品牌 |
| category | STRING | NULLABLE | 官网品牌所属的类目 |
| official_brand | STRING | NULLABLE | 官方品牌 |
| status | INTEGER | NULLABLE | 该映射关系的状态，1是生效；-1是失效 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_mapping_raw_brand`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:23
**扫描工具**: scan_metadata_v2.py
