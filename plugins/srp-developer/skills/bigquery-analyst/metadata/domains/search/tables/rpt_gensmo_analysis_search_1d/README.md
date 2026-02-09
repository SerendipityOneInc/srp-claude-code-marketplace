# rpt_gensmo_analysis_search_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_1d`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: TABLE
**行数**: 3,374,979 行
**大小**: 0.72 GB
**创建时间**: 2025-07-03
**最后更新**: 2025-08-20

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期 |
| platform | STRING | NULLABLE | 用户所使用的平台 |
| app_version | STRING | NULLABLE | 应用程序版本 |
| country_name | STRING | NULLABLE | 用户所在国家 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| user_tenure_type | STRING | NULLABLE | 用户使用期限类型 |
| user_group | STRING | NULLABLE | 用户群体类别 |
| device_id | STRING | NULLABLE | 设备标识符 |
| query_input_inspo | STRING | NULLABLE | 查询输入或点击金刚位 |
| query_input_type | STRING | NULLABLE | 查询输入类型 |
| search_type | STRING | NULLABLE | 搜索类型 |
| user_count | INTEGER | NULLABLE | 用户计数 |
| load_finish_count | INTEGER | NULLABLE | 完成加载计数 |
| agg_load_finish | STRING | NULLABLE | 加载完成信息 |
| agg_error_block | STRING | NULLABLE | 错误阻塞信息 |
| agg_login_block | STRING | NULLABLE | 登录阻塞信息 |
| first_collage_gen_position | INTEGER | NULLABLE | 第一次 collage_gen 出现的位置 |
| second_collage_gen_position | INTEGER | NULLABLE | 第二次 collage_gen 出现的位置 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:42
**扫描工具**: scan_metadata_v2.py
