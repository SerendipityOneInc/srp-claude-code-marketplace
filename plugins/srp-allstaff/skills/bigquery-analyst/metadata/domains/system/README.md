# 系统配置

**业务域**: system
**最后更新**: 2026-01-30
**表数量**: 10 张

---

## 📊 业务概述

系统配置、地区映射、技术支撑表

**关键词**: 配置, 系统, 映射

---

## 📋 核心表

| 表名 | 层级 | 说明 |
|------|------|------|
| `dwd_favie_city_weather_inc_1d` | DWD | --- |
| `dim_country_region` | DIM | --- |
| `dim_country_region_google_sheet` | DIM | --- |
| `dim_favie_user_google_sheet_config_mut_view` | DIM | --- |


更多表请参见 [TABLES.md](./TABLES.md)

---

## 💡 常见查询场景

### 场景 1: (待补充)

**需求**: 待补充业务需求

**推荐表**: 待补充

**示例 SQL**:
```sql
-- 待补充查询示例
SELECT
  dt,
  COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dwd.table_name`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC
```

---

## 🔗 相关资源

- [表清单](./TABLES.md) - 完整表列表
- [通用函数](./common_functions/) - 可复用的查询函数

---

**文档生成**: 2026-01-30 15:33:23
**维护者**: Data Platform Team
