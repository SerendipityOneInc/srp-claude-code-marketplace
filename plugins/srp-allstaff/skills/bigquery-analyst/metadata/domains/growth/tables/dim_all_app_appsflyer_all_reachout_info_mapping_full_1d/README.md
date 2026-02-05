# dim_all_app_appsflyer_all_reachout_info_mapping_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dim_all_app_appsflyer_all_reachout_info_mapping_full_1d`
**层级**: 未分类
**业务域**: other
**表类型**: TABLE
**行数**: 86,764,386 行
**大小**: 11.31 GB
**创建时间**: 2025-10-27
**最后更新**: 2026-01-30

---

## 📊 表说明

appsflyer id与触达信息归因,每天包含全量数据

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | REQUIRED | 全量日期 |
| app_name | STRING | NULLABLE | 应用名称：Gensmo、Decofy |
| event_name | STRING | NULLABLE | appsflyer触达的事件名称 |
| appsflyer_id | STRING | NULLABLE | appsflyer_id |
| source | STRING | NULLABLE | 所有触达来源 |
| account_id | STRING | NULLABLE | 广告账户ID,如果为非广告信息,则为upper(event_name) |
| campaign_id | STRING | NULLABLE | 广告活动ID,如果为非广告信息,则为upper(event_name) |
| ad_group_id | STRING | NULLABLE | 广告组ID,如果为非广告信息,则为upper(event_name) |
| ad_id | STRING | NULLABLE | 广告ID,如果为非广告信息,则为upper(event_name) |
| event_order_seq | INTEGER | NULLABLE | appsflyer触达的事件顺序,按照时间正序排列 |
| event_dt | DATE | NULLABLE | 处理更新时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_all_app_appsflyer_all_reachout_info_mapping_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:20
**扫描工具**: scan_metadata_v2.py
