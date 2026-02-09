# rpt_favie_gensmo_channel_metric_with_dau_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_with_dau_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 102,605 行
**大小**: 0.01 GB
**创建时间**: 2025-07-10
**最后更新**: 2025-07-10

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
| user_login_type | STRING | NULLABLE | 用户登录类型，如手机号、微信授权等 |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类，如新用户、老用户 |
| user_group | STRING | NULLABLE | 用户分群标签 |
| active_user_d1_cnt | INTEGER | NULLABLE | 日活跃用户数 |
| channel_user_cnt | INTEGER | NULLABLE | channel用户数量 |
| user_channel_cnt | INTEGER | NULLABLE | 用户channel数量 |
| item_task_gen_user_cnt | INTEGER | NULLABLE | channel任务开始用户数 |
| item_task_complete_user_cnt | INTEGER | NULLABLE | channel任务完成用户数 |
| item_task_detail_user_cnt | INTEGER | NULLABLE | channel任务详情用户数 |
| item_task_save_user_cnt | INTEGER | NULLABLE | channel任务收藏用户数 |
| item_task_unsave_user_cnt | INTEGER | NULLABLE | channel任务取消收藏用户数 |
| item_task_like_user_cnt | INTEGER | NULLABLE | channel任务点赞用户数 |
| item_task_cancel_like_user_cnt | INTEGER | NULLABLE | channel任务取消点赞用户数 |
| item_task_share_user_cnt | INTEGER | NULLABLE | channel任务分享用户数 |
| item_task_download_user_cnt | INTEGER | NULLABLE | channel任务下载用户数 |
| item_task_external_jump_user_cnt | INTEGER | NULLABLE | channel任务外跳用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_with_dau_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:06
**扫描工具**: scan_metadata_v2.py
