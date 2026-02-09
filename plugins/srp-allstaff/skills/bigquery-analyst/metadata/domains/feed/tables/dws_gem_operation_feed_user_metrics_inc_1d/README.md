# dws_gem_operation_feed_user_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_feed_user_metrics_inc_1d`
**层级**: DWS (汇总层)
**业务域**: feed
**表类型**: TABLE
**行数**: 103,079,457 行
**大小**: 27.64 GB
**创建时间**: 2025-10-17
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 事件发生日期（分区字段） |
| item_type | STRING | NULLABLE | item类型 |
| device_id | STRING | NULLABLE | 设备ID |
| refer | STRING | NULLABLE | 来源页面 |
| feed_type | STRING | NULLABLE | feed类型 |
| production_type | STRING | NULLABLE | feed生产类型 |
| user_group | STRING | NULLABLE | 用户分组 |
| country_name | STRING | NULLABLE | 国家名称 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| user_login_type | STRING | NULLABLE | 登录类型 |
| user_tenure_type | STRING | NULLABLE | 新老用户 |
| user_media_source | STRING | NULLABLE | 用户渠道来源 |
| feed_view_pv_cnt | INTEGER | NULLABLE | 浏览PV：select_item + true_view_trigger |
| feed_click_pv_cnt | INTEGER | NULLABLE | 点击PV：enter_feed_detail |
| feed_like_click_pv_cnt | INTEGER | NULLABLE | 喜欢点击次数 |
| feed_try_on_pv_cnt | INTEGER | NULLABLE | try_on点击次数 |
| feed_try_on_trigger_pv_cnt | INTEGER | NULLABLE | try_on_trigger点击次数 |
| feed_remix_see_it_on_me_pv_cnt | INTEGER | NULLABLE | remix/see it on me 点击次数 |
| feed_comment_pv_cnt | INTEGER | NULLABLE | 评论点击次数 |
| feed_detail_click_pv_cnt | INTEGER | NULLABLE | 外部 feed_detail 点击次数 |
| feed_save_pv_cnt | INTEGER | NULLABLE | 收藏点击次数 |
| feed_product_external_jump_pv_cnt | INTEGER | NULLABLE | 商品外部跳转点击次数 |
| feed_product_click_pv_cnt | INTEGER | NULLABLE | 商品详情点击次数 |
| feed_share_pv_cnt | INTEGER | NULLABLE | 分享点击次数 |
| feed_screen_shot_pv_cnt | INTEGER | NULLABLE | 截图次数 |
| feed_hashtag_click_pv_cnt | INTEGER | NULLABLE | 话题点击次数 |
| feed_editor_pick_view_pv_cnt | INTEGER | NULLABLE | 编辑精选曝光次数 |
| feed_editor_pick_click_pv_cnt | INTEGER | NULLABLE | 编辑精选点击次数 |
| follow_click_cnt | INTEGER | NULLABLE | 关注博主次数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_operation_feed_user_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:50
**扫描工具**: scan_metadata_v2.py
