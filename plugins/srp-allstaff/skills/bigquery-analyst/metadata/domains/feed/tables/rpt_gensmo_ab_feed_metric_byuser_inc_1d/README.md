# rpt_gensmo_ab_feed_metric_byuser_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: TABLE
**行数**: 9,051,317 行
**大小**: 1.42 GB
**创建时间**: 2025-07-04
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区 |
| device_id | STRING | NULLABLE | 设备id |
| user_tenure_type | STRING | NULLABLE | 用户新老类型 |
| user_login_type | STRING | NULLABLE | 用户登录类型 |
| country_name | STRING | NULLABLE | 国家名 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | app版本 |
| ab_project_name | STRING | NULLABLE | ab实验名称 |
| ab_router_id | STRING | NULLABLE | ab分组id |
| ab_router_name | STRING | NULLABLE | ab分组名称 |
| user_feed_stay_interval | FLOAT | NULLABLE | 用户feed_detail和home页停留总时长 |
| user_feed_true_view | INTEGER | NULLABLE | 用户feed_detail的真实曝光数 |
| user_content_consumption | INTEGER | NULLABLE | 用户内容消费数 |
| user_ctr | FLOAT | NULLABLE | 用户点击率 |
| refer | STRING | NULLABLE | 来源 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:19
**扫描工具**: scan_metadata_v2.py
