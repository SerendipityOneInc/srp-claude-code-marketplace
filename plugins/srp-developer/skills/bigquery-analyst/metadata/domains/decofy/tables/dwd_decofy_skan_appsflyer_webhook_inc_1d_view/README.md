# dwd_decofy_skan_appsflyer_webhook_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_decofy_skan_appsflyer_webhook_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: decofy
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-08-04
**最后更新**: 2025-08-04

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| skad_version | STRING | NULLABLE | - |
| skad_ad_network_id | STRING | NULLABLE | - |
| fidelity_type | INTEGER | NULLABLE | - |
| did_win | BOOLEAN | NULLABLE | - |
| timestamp | STRING | NULLABLE | - |
| skad_campaign_id | STRING | NULLABLE | - |
| event_type | STRING | NULLABLE | - |
| _sdc_table_version | INTEGER | NULLABLE | - |
| skad_transaction_id | STRING | NULLABLE | - |
| _sdc_received_at | TIMESTAMP | NULLABLE | - |
| _sdc_sequence | INTEGER | NULLABLE | - |
| skad_attribution_signature | STRING | NULLABLE | - |
| __sdc_primary_key | STRING | NULLABLE | - |
| skad_redownload | BOOLEAN | NULLABLE | - |
| app_id | STRING | NULLABLE | - |
| _sdc_batched_at | TIMESTAMP | NULLABLE | - |
| skad_app_id | STRING | NULLABLE | - |
| ad_network_adset_id | STRING | NULLABLE | - |
| ad_network_campaign_id | STRING | NULLABLE | - |
| ad_network_adset_name | STRING | NULLABLE | - |
| ip | STRING | NULLABLE | - |
| ad_network_campaign_name | STRING | NULLABLE | - |
| ad_network_timestamp | STRING | NULLABLE | - |
| skad_conversion_value | INTEGER | NULLABLE | - |
| skad_source_app_id | STRING | NULLABLE | - |
| event_uuid | STRING | NULLABLE | - |
| install_type | STRING | NULLABLE | - |
| install_date | STRING | NULLABLE | - |
| skad_fidelity_type | INTEGER | NULLABLE | - |
| skad_mode | STRING | NULLABLE | - |
| skad_postback_sequence_index | INTEGER | NULLABLE | - |
| media_source | STRING | NULLABLE | - |
| measurement_window | INTEGER | NULLABLE | - |
| af_attribution_flag | BOOLEAN | NULLABLE | - |
| skad_ambiguous_event | BOOLEAN | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| skad_revenue | FLOAT | NULLABLE | - |
| max_revenue | FLOAT | NULLABLE | - |
| min_time_post_install | INTEGER | NULLABLE | - |
| max_time_post_install | INTEGER | NULLABLE | - |
| min_revenue | FLOAT | NULLABLE | - |
| max_event_counter | INTEGER | NULLABLE | - |
| min_event_counter | INTEGER | NULLABLE | - |
| source_app_id | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.skan_appsflyer_decofy2.data` (data)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_decofy_skan_appsflyer_webhook_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:10
**扫描工具**: scan_metadata_v2.py
