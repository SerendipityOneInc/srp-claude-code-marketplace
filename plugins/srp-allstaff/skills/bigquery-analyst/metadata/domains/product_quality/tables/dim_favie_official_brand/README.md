# dim_favie_official_brand

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_official_brand`
**层级**: 未分类
**业务域**: other
**表类型**: TABLE
**行数**: 153,437 行
**大小**: 0.03 GB
**创建时间**: 2025-07-21
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| id | STRING | NULLABLE | 官方品牌维表的唯一标识符，初始是按estimated_sku_num从大到小排序后的自动编号 |
| official_brand | STRING | NULLABLE | 标准化后的官方品牌名称，用于统一管理多个raw_brand |
| category | STRING | NULLABLE | 品牌所属的行业类目，用于区分不同类行业下的同名品牌 |
| website | STRING | NULLABLE | 品牌的官方网站URL |
| description | STRING | NULLABLE | 品牌的详细描述信息 |
| estimated_sku_num | INTEGER | NULLABLE | 初始的该品牌下预估的SKU数量 |
| parent_id | STRING | NULLABLE | 父级品牌的ID |
| parent_official_brand | STRING | NULLABLE | 父级品牌的official_brand名称，与parent_id配合使用，提供更直观的层级关系表示 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_official_brand`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:27
**扫描工具**: scan_metadata_v2.py
