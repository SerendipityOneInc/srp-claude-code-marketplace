# dim_gem_appsflyer_history_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_history_inc_1d`
**层级**: 未分类
**业务域**: gem
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-16
**最后更新**: 2025-06-16

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| type | STRING | NULLABLE | - |
| Attributed_Touch_Type | STRING | NULLABLE | - |
| Attributed_Touch_Time | STRING | NULLABLE | - |
| Install_Time | TIMESTAMP | NULLABLE | - |
| Event_Time | TIMESTAMP | NULLABLE | - |
| Event_Name | STRING | NULLABLE | - |
| Event_Value | STRING | NULLABLE | - |
| Event_Revenue | STRING | NULLABLE | - |
| Event_Revenue_Currency | STRING | NULLABLE | - |
| Event_Revenue_USD | STRING | NULLABLE | - |
| Cost_Model | STRING | NULLABLE | - |
| Cost_Value | STRING | NULLABLE | - |
| Cost_Currency | STRING | NULLABLE | - |
| Event_Source | STRING | NULLABLE | - |
| Partner | STRING | NULLABLE | - |
| Media_Source | STRING | NULLABLE | - |
| Channel | STRING | NULLABLE | - |
| Campaign | STRING | NULLABLE | - |
| Campaign_ID | STRING | NULLABLE | - |
| Adset | STRING | NULLABLE | - |
| Adset_ID | STRING | NULLABLE | - |
| Ad | STRING | NULLABLE | - |
| Ad_ID | STRING | NULLABLE | - |
| Ad_Type | STRING | NULLABLE | - |
| Site_ID | STRING | NULLABLE | - |
| Region | STRING | NULLABLE | - |
| Country_Code | STRING | NULLABLE | - |
| State | STRING | NULLABLE | - |
| City | STRING | NULLABLE | - |
| Postal_Code | STRING | NULLABLE | - |
| DMA | STRING | NULLABLE | - |
| IP | STRING | NULLABLE | - |
| Operator | STRING | NULLABLE | - |
| Carrier | STRING | NULLABLE | - |
| Language | STRING | NULLABLE | - |
| AppsFlyer_ID | STRING | NULLABLE | - |
| Customer_User_ID | STRING | NULLABLE | - |
| Android_ID | STRING | NULLABLE | - |
| Advertising_ID | STRING | NULLABLE | - |
| IMEI | STRING | NULLABLE | - |
| IDFA | STRING | NULLABLE | - |
| IDFV | STRING | NULLABLE | - |
| Device_Category | STRING | NULLABLE | - |
| Platform | STRING | NULLABLE | - |
| OS_Version | STRING | NULLABLE | - |
| App_Version | STRING | NULLABLE | - |
| SDK_Version | STRING | NULLABLE | - |
| App_ID | STRING | NULLABLE | - |
| App_Name | STRING | NULLABLE | - |
| Is_Retargeting | BOOLEAN | NULLABLE | - |
| Retargeting_Conversion_Type | STRING | NULLABLE | - |
| Is_Primary_Attribution | STRING | NULLABLE | - |
| Attribution_Lookback | STRING | NULLABLE | - |
| Reengagement_Window | STRING | NULLABLE | - |
| Match_Type | STRING | NULLABLE | - |
| User_Agent | STRING | NULLABLE | - |
| HTTP_Referrer | STRING | NULLABLE | - |
| Original_URL | STRING | NULLABLE | - |
| Device_Model | STRING | NULLABLE | - |
| Store_Product_Page | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_history_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:47
**扫描工具**: scan_metadata_v2.py
