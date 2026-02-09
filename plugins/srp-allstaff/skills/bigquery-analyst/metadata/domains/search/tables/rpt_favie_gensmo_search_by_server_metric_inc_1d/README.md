# rpt_favie_gensmo_search_by_server_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: TABLE
**行数**: 278,059 行
**大小**: 0.03 GB
**创建时间**: 2025-08-06
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区字段，格式YYYY-MM-DD |
| platform | STRING | NULLABLE | 用户平台，如 iOS、Android、Web |
| app_version | STRING | NULLABLE | 应用版本号 |
| country_name | STRING | NULLABLE | 国家或地区名称 |
| user_login_type | STRING | NULLABLE | 用户登录类型（登陆，未登陆） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类，如新用户、老用户 |
| user_group | STRING | NULLABLE | 用户分群标签 |
| collage_server_complete_task_cnt | INTEGER | NULLABLE | 搜索服务端完成Item数 |
| collage_server_complete_user_cnt | INTEGER | NULLABLE | 搜索服务端完成访问用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:25
**扫描工具**: scan_metadata_v2.py
