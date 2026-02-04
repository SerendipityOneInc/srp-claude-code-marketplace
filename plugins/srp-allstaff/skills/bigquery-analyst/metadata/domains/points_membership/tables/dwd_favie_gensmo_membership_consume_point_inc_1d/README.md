# dwd_favie_gensmo_membership_consume_point_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d`
**层级**: DWD (明细层)
**业务域**: points_membership
**表类型**: TABLE
**行数**: 114,274 行
**大小**: 0.02 GB
**创建时间**: 2025-12-28
**最后更新**: 2026-01-30

---

## 📊 表说明

**业务含义**: 记录用户每日积分消耗明细，包括消耗类型、消耗积分数、消耗状态等信息。

**数据范围**: 2025-12-28 至今

**更新频率**: 每日增量更新 (inc_1d)

**数据延迟**: 约 8 小时（DWD 层特性）

**重要字段说明**:
- `consume_type`: 积分消耗类型，常见值包括：
  - `try_on_couple` - 情侣装试穿
  - `try_on_video` - 视频试穿
  - `try_on_hd` - 高清试穿
  - `avatar_refine` - 头像精修
  - `background_remove` - 背景移除
  - 等其他功能类型

- `consume_status`: 积分消耗状态，可能值：
  - `consumed` - 已成功消耗（推荐过滤条件）
  - `pending` - 待处理
  - `failed` - 消耗失败
  - `cancelled` - 已取消

**使用建议**:
- ✅ 查询时必须过滤 `consume_status = 'consumed'` 以避免统计未完成的消耗
- ✅ 必须包含 `dt` 分区过滤以控制成本
- ⚠️ DWD 层为明细数据，数据量较大，建议限制时间范围（如最近 7-30 天）

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期，表示事件发生的日期 |
| user_id | STRING | NULLABLE | 用户ID，已登录用户的唯一标识符 |
| device_id | STRING | NULLABLE | 设备ID，设备的唯一标识符 |
| consume_id | STRING | NULLABLE | 积分消耗记录ID |
| consume_type | STRING | NULLABLE | 积分消耗类型，Tryon、video等 |
| consume_points | INTEGER | NULLABLE | 消耗的积分总数 |
| consume_status | STRING | NULLABLE | 积分消耗状态，如成功、失败等 |
| consume_time | TIMESTAMP | NULLABLE | 积分消耗时间戳 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:55
**扫描工具**: scan_metadata_v2.py
