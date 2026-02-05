# dim_gem_onesignal_push_status_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_onesignal_push_status_view`
**层级**: 未分类
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| adm_big_picture | STRING | NULLABLE | - |
| adm_group | STRING | NULLABLE | - |
| adm_large_icon | STRING | NULLABLE | - |
| adm_small_icon | STRING | NULLABLE | - |
| adm_sound | STRING | NULLABLE | - |
| alexa_display_title | STRING | NULLABLE | - |
| alexa_ssml | STRING | NULLABLE | - |
| amazon_background_data | STRING | NULLABLE | - |
| android_accent_color | STRING | NULLABLE | - |
| android_group | STRING | NULLABLE | - |
| android_group_message | STRING | NULLABLE | - |
| android_led_color | STRING | NULLABLE | - |
| android_sound | STRING | NULLABLE | - |
| android_visibility | INTEGER | NULLABLE | - |
| apns_alert | STRING | NULLABLE | - |
| app_id | STRING | NULLABLE | - |
| app_url | STRING | NULLABLE | - |
| big_picture | STRING | NULLABLE | - |
| buttons | STRING | NULLABLE | - |
| canceled | BOOLEAN | NULLABLE | - |
| chrome_big_picture | STRING | NULLABLE | - |
| chrome_icon | STRING | NULLABLE | - |
| chrome_web_badge | STRING | NULLABLE | - |
| chrome_web_icon | STRING | NULLABLE | - |
| chrome_web_image | STRING | NULLABLE | - |
| completed_at | TIMESTAMP | NULLABLE | - |
| content_available | STRING | NULLABLE | - |
| contents | STRING | NULLABLE | - |
| converted | INTEGER | NULLABLE | - |
| data_field | STRING | NULLABLE | - |
| delayed_option | STRING | NULLABLE | - |
| delivery_time_of_day | STRING | NULLABLE | - |
| email_click_tracking_disabled | BOOLEAN | NULLABLE | - |
| email_from_address | STRING | NULLABLE | - |
| email_from_name | STRING | NULLABLE | - |
| email_preheader | STRING | NULLABLE | - |
| email_reply_to_address | STRING | NULLABLE | - |
| email_subject | STRING | NULLABLE | - |
| errored | INTEGER | NULLABLE | - |
| excluded_segments | STRING | REPEATED | - |
| failed | INTEGER | NULLABLE | - |
| fcap_group_ids | STRING | NULLABLE | - |
| fcap_status | STRING | NULLABLE | - |
| fetched_at | TIMESTAMP | NULLABLE | - |
| filters | STRING | NULLABLE | - |
| firefox_icon | STRING | NULLABLE | - |
| global_image | STRING | NULLABLE | - |
| headings | STRING | NULLABLE | - |
| huawei_accent_color | STRING | NULLABLE | - |
| huawei_bi_tag | STRING | NULLABLE | - |
| huawei_big_picture | STRING | NULLABLE | - |
| huawei_category | STRING | NULLABLE | - |
| huawei_channel_id | STRING | NULLABLE | - |
| huawei_existing_channel_id | STRING | NULLABLE | - |
| huawei_group | STRING | NULLABLE | - |
| huawei_group_message | STRING | NULLABLE | - |
| huawei_large_icon | STRING | NULLABLE | - |
| huawei_led_color | STRING | NULLABLE | - |
| huawei_msg_type | STRING | NULLABLE | - |
| huawei_small_icon | STRING | NULLABLE | - |
| huawei_sound | STRING | NULLABLE | - |
| huawei_visibility | STRING | NULLABLE | - |
| id | STRING | NULLABLE | - |
| include_aliases | STRING | NULLABLE | - |
| include_external_user_ids | STRING | REPEATED | - |
| include_player_ids | STRING | REPEATED | - |
| include_unsubscribed | BOOLEAN | NULLABLE | - |
| included_segments | STRING | REPEATED | - |
| ios_attachments | STRING | NULLABLE | - |
| ios_badgeCount | INTEGER | NULLABLE | - |
| ios_badgeType | STRING | NULLABLE | - |
| ios_category | STRING | NULLABLE | - |
| ios_interruption_level | STRING | NULLABLE | - |
| ios_relevance_score | INTEGER | NULLABLE | - |
| ios_sound | STRING | NULLABLE | - |
| isAdm | BOOLEAN | NULLABLE | - |
| isAlexa | BOOLEAN | NULLABLE | - |
| isAndroid | BOOLEAN | NULLABLE | - |
| isChrome | BOOLEAN | NULLABLE | - |
| isChromeWeb | BOOLEAN | NULLABLE | - |
| isEdge | BOOLEAN | NULLABLE | - |
| isEmail | BOOLEAN | NULLABLE | - |
| isFirefox | BOOLEAN | NULLABLE | - |
| isHuawei | BOOLEAN | NULLABLE | - |
| isIos | BOOLEAN | NULLABLE | - |
| isSMS | BOOLEAN | NULLABLE | - |
| isSafari | BOOLEAN | NULLABLE | - |
| isWP | BOOLEAN | NULLABLE | - |
| isWP_WNS | BOOLEAN | NULLABLE | - |
| large_icon | STRING | NULLABLE | - |
| name | STRING | NULLABLE | - |
| platform_delivery_stats | STRING | NULLABLE | - |
| priority | INTEGER | NULLABLE | - |
| queued_at | INTEGER | NULLABLE | - |
| received | INTEGER | NULLABLE | - |
| remaining | INTEGER | NULLABLE | - |
| send_after | INTEGER | NULLABLE | - |
| small_icon | STRING | NULLABLE | - |
| sms_from | STRING | NULLABLE | - |
| sms_media_urls | STRING | REPEATED | - |
| spoken_text | STRING | NULLABLE | - |
| subtitle | STRING | NULLABLE | - |
| successful | INTEGER | NULLABLE | - |
| tags | STRING | NULLABLE | - |
| target_content_identifier | STRING | NULLABLE | - |
| template_id | STRING | NULLABLE | - |
| thread_id | STRING | NULLABLE | - |
| throttle_rate_per_minute | INTEGER | NULLABLE | - |
| ttl | INTEGER | NULLABLE | - |
| url | STRING | NULLABLE | - |
| web_buttons | STRING | NULLABLE | - |
| web_push_topic | STRING | NULLABLE | - |
| web_url | STRING | NULLABLE | - |
| wp_sound | STRING | NULLABLE | - |
| wp_wns_sound | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.copilot_gem_onesignal_push_status` (copilot_gem_onesignal_push_status)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_onesignal_push_status_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:03
**扫描工具**: scan_metadata_v2.py
