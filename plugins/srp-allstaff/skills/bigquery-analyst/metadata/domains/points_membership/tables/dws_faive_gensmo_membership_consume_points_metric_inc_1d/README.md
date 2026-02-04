# dws_faive_gensmo_membership_consume_points_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_faive_gensmo_membership_consume_points_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: points_membership
**表类型**: TABLE
**行数**: 487,844 行
**大小**: 0.07 GB
**创建时间**: 2025-12-31
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 指标数据日期 |
| platform | STRING | NULLABLE | 平台类型（iOS、Android 等） |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 用户所属国家名称 |
| user_login_type | STRING | NULLABLE | 用户登录类型（匿名、注册等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类（新用户、老用户） |
| user_group | STRING | NULLABLE | 用户分组分类 |
| device_id | STRING | NULLABLE | 设备唯一标识 |
| consume_type | STRING | NULLABLE | 积分消耗类型，Tryon、video等 |
| consume_points_user_cnt | INTEGER | NULLABLE | 对应积分类型用户标识，用户有上述消耗积分行为的记为1，否则为0 |
| consume_ponits_task_cnt | INTEGER | NULLABLE | 对应积分类型用户消耗积分次数，对符合上述维度组合的，对process_node_id计数 |
| consume_ponits_points_amt | INTEGER | NULLABLE | 对应积分类型用户消耗积分数量，对符合上述维度组合的，对process_node_points求和 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_faive_gensmo_membership_consume_points_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:29
**扫描工具**: scan_metadata_v2.py
