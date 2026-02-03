# dim_gem_appsflyer_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_inc_1d_view`
**层级**: 未分类
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-27
**最后更新**: 2025-06-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| idfv | STRING | NULLABLE | - |
| device_category | STRING | NULLABLE | - |
| customer_user_id | STRING | NULLABLE | - |
| bundle_id | STRING | NULLABLE | - |
| gp_broadcast_referrer | STRING | NULLABLE | - |
| event_source | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| city | STRING | NULLABLE | - |
| selected_currency | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| install_time_selected_timezone | STRING | NULLABLE | - |
| postal_code | STRING | NULLABLE | - |
| wifi | BOOLEAN | NULLABLE | - |
| install_time | STRING | NULLABLE | - |
| device_download_time_selected_timezone | STRING | NULLABLE | - |
| api_version | STRING | NULLABLE | - |
| is_retargeting | BOOLEAN | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| dma | STRING | NULLABLE | - |
| _sdc_table_version | INTEGER | NULLABLE | - |
| event_revenue_currency | STRING | NULLABLE | - |
| media_source | STRING | NULLABLE | - |
| region | STRING | NULLABLE | - |
| event_value | STRING | NULLABLE | - |
| ip | STRING | NULLABLE | - |
| event_time | STRING | NULLABLE | - |
| _sdc_received_at | TIMESTAMP | NULLABLE | - |
| _sdc_sequence | INTEGER | NULLABLE | - |
| __sdc_primary_key | STRING | NULLABLE | - |
| state | STRING | NULLABLE | - |
| device_type | STRING | NULLABLE | - |
| idfa | STRING | NULLABLE | - |
| device_download_time | STRING | NULLABLE | - |
| language | STRING | NULLABLE | - |
| app_id | STRING | NULLABLE | - |
| _sdc_batched_at | TIMESTAMP | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| os_version | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| selected_timezone | STRING | NULLABLE | - |
| user_agent | STRING | NULLABLE | - |
| is_primary_attribution | BOOLEAN | NULLABLE | - |
| sdk_version | STRING | NULLABLE | - |
| event_time_selected_timezone | STRING | NULLABLE | - |
| af_sub1 | STRING | NULLABLE | - |
| is_lat | BOOLEAN | NULLABLE | - |
| gp_install_begin | STRING | NULLABLE | - |
| device_model | STRING | NULLABLE | - |
| gp_referrer | STRING | NULLABLE | - |
| af_c_id | STRING | NULLABLE | - |
| attributed_touch_time_selected_timezone | STRING | NULLABLE | - |
| engagement_type | STRING | NULLABLE | - |
| operator | STRING | NULLABLE | - |
| attributed_touch_type | STRING | NULLABLE | - |
| af_attribution_lookback | STRING | NULLABLE | - |
| campaign_type | STRING | NULLABLE | - |
| af_adset_id | STRING | NULLABLE | - |
| conversion_type | STRING | NULLABLE | - |
| attributed_touch_time | STRING | NULLABLE | - |
| gp_click_time | STRING | NULLABLE | - |
| match_type | STRING | NULLABLE | - |
| event_type | STRING | NULLABLE | - |
| http_referrer | STRING | NULLABLE | - |
| af_sub5 | STRING | NULLABLE | - |
| af_prt | STRING | NULLABLE | - |
| campaign | STRING | NULLABLE | - |
| af_sub4 | STRING | NULLABLE | - |
| af_sub2 | STRING | NULLABLE | - |
| original_url | STRING | NULLABLE | - |
| att | STRING | NULLABLE | - |
| af_adset | STRING | NULLABLE | - |
| af_ad | STRING | NULLABLE | - |
| network_account_id | INTEGER | NULLABLE | - |
| network_account_id__st | STRING | NULLABLE | - |
| af_channel | STRING | NULLABLE | - |
| af_reengagement_window | STRING | NULLABLE | - |
| app_type | STRING | NULLABLE | - |
| af_siteid | STRING | NULLABLE | - |
| af_ad_type | STRING | NULLABLE | - |
| carrier | STRING | NULLABLE | - |
| af_sub_siteid | STRING | NULLABLE | - |
| advertising_id | STRING | NULLABLE | - |
| af_sub3 | STRING | NULLABLE | - |
| af_ad_id | STRING | NULLABLE | - |
| store_reinstall | STRING | NULLABLE | - |
| af_keywords | STRING | NULLABLE | - |
| keyword_id | STRING | NULLABLE | - |
| amazon_aid | STRING | NULLABLE | - |
| source | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.srp_user_growth_views.dwd_gem_appsflyer_webhook_inc_1d_view` (dwd_gem_appsflyer_webhook_inc_1d_view)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:49
**扫描工具**: scan_metadata_v2.py
