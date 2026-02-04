# dws_faive_gensmo_membership_points_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_faive_gensmo_membership_points_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: points_membership
**表类型**: TABLE
**行数**: 1,305,943 行
**大小**: 0.31 GB
**创建时间**: 2026-01-04
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
| earn_points_user_cnt | INTEGER | NULLABLE | 获取过积分行为的用户标识 |
| earn_points_task_cnt | INTEGER | NULLABLE | 获取积分次数 |
| earn_points_points_amt | INTEGER | NULLABLE | 获取积分数量 |
| earn_points_not_checkin_user_cnt | INTEGER | NULLABLE | 通过主动完成任务获取积分行为的用户标识（不含被动checkin） |
| earn_points_not_checkin_task_cnt | INTEGER | NULLABLE | 通过主动完成任务获取积分次数（不含被动checkin） |
| earn_points_not_checkin_points_amt | INTEGER | NULLABLE | 通过主动完成任务获取积分数量（不含被动checkin） |
| earn_points_transaction_user_cnt | INTEGER | NULLABLE | 通过充值获取积分行为的用户标识 |
| earn_points_transaction_task_cnt | INTEGER | NULLABLE | 通过充值获取积分次数 |
| earn_points_transaction_points_amt | INTEGER | NULLABLE | 通过充值获取积分数量 |
| consume_points_user_cnt | INTEGER | NULLABLE | 消耗过积分行为的用户标识 |
| consume_points_task_cnt | INTEGER | NULLABLE | 消耗积分次数 |
| consume_points_points_amt | INTEGER | NULLABLE | 消耗积分数量 |
| net_points_change | INTEGER | NULLABLE | 净积分流=当日获取积分-当日消耗积分 |
| consume_points_ge_task_claimed_user_cnt | INTEGER | NULLABLE | 用户当日消耗积分大于等于完成daily任务可获取的积分上限（目前登录10分+3次分享3分共13分）的用户标识 |
| consume_points_ge_checkin_user_cnt | INTEGER | NULLABLE | 用户当日消耗积分大于等于每日登录可获取的积分（目前登录为10分）的用户标识 |
| hit_limit_user_cnt | INTEGER | NULLABLE | 撞线用户标识 |
| points_expired | INTEGER | NULLABLE | 当日到期扣除积分 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_faive_gensmo_membership_points_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:33
**扫描工具**: scan_metadata_v2.py
