# rpt_favie_gensmo_channel_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 38,918 行
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
| dt | DATE | NULLABLE | 指标数据日期 |
| platform | STRING | NULLABLE | 平台类型（iOS、Android 等） |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 用户所属国家名称 |
| user_login_type | STRING | NULLABLE | 用户登录类型（匿名、注册等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类（新用户、老用户） |
| user_group | STRING | NULLABLE | 用户分组分类 |
| item_task_gen_pv_cnt | INTEGER | NULLABLE | channel发起任务数 |
| item_task_complete_pv_cnt | INTEGER | NULLABLE | channel完成浏览次数 |
| item_task_complete_item_cnt | INTEGER | NULLABLE | channel完成的Item数量 |
| item_task_list_pv_cnt | INTEGER | NULLABLE | channel任务列表浏览次数 |
| item_task_list_item_cnt | INTEGER | NULLABLE | channel任务列表Item数量 |
| item_task_detail_pv_cnt | INTEGER | NULLABLE | channel任务详情浏览次数 |
| item_task_detail_item_cnt | INTEGER | NULLABLE | channel任务详情Item数量 |
| item_task_save_cnt | INTEGER | NULLABLE | channel任务收藏次数 |
| item_task_save_item_cnt | INTEGER | NULLABLE | channel任务收藏Item数量 |
| item_task_unsave_cnt | INTEGER | NULLABLE | channel任务取消收藏次数 |
| item_task_unsave_item_cnt | INTEGER | NULLABLE | channel任务取消收藏Item数量 |
| item_task_like_cnt | INTEGER | NULLABLE | channel任务点赞次数 |
| item_task_like_item_cnt | INTEGER | NULLABLE | channel任务点赞Item数量 |
| item_task_cancel_like_cnt | INTEGER | NULLABLE | channel任务取消点赞次数 |
| item_task_cancel_like_item_cnt | INTEGER | NULLABLE | channel任务取消点赞Item数量 |
| item_task_share_cnt | INTEGER | NULLABLE | channel任务分享次数 |
| item_task_share_item_cnt | INTEGER | NULLABLE | channel任务分享Item数量 |
| item_task_download_cnt | INTEGER | NULLABLE | channel任务下载次数 |
| item_task_download_item_cnt | INTEGER | NULLABLE | channel任务下载Item数量 |
| item_task_external_jump_cnt | INTEGER | NULLABLE | channel任务外跳次数 |
| item_task_external_jump_item_cnt | INTEGER | NULLABLE | channel任务外跳Item数量 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:03
**扫描工具**: scan_metadata_v2.py
