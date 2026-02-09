# dwd_favie_gensmo_membership_process_node_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_process_node_inc_1d`
**层级**: DWD (明细层)
**业务域**: points_membership
**表类型**: TABLE
**行数**: 211,675 行
**大小**: 0.03 GB
**创建时间**: 2026-01-04
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期，事件发生的日期 |
| user_id | STRING | NULLABLE | 用户ID，已登录用户的唯一标识 |
| device_id | STRING | NULLABLE | 设备ID，设备的唯一标识符 |
| process_node_id | STRING | NULLABLE | 会员流程节点ID，唯一标识每个流程节点 |
| process_node_name | STRING | NULLABLE | 会员流程节点，如注册、赚取积分、消耗积分等 |
| process_node_type | STRING | NULLABLE | 节点类型，赚取积分类型，消耗积分类型等 |
| process_node_status | STRING | NULLABLE | 节点状态，如成功、失败等 |
| process_node_time | TIMESTAMP | NULLABLE | 节点发生时间 |
| process_node_points | INTEGER | NULLABLE | 节点涉及的积分数值 |
| process_node_point_type | STRING | NULLABLE | 积分类型，如Daily积分、永久积分 |
| earn_seq | INTEGER | NULLABLE | 赚取积分节点序列号/顺序 |
| earn_group | STRING | NULLABLE | 赚取积分分组标识 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_process_node_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:58
**扫描工具**: scan_metadata_v2.py
