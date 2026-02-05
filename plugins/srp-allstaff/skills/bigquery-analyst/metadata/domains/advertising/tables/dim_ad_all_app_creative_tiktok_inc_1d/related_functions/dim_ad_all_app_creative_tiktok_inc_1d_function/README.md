# dim_ad_all_app_creative_tiktok_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_tiktok_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-07-04
**最后更新**: 2025-07-04

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
SELECT  dt
         ,'Tiktok'                                                                 AS source
         ,CASE WHEN LOWER(b.name) LIKE 'gensmo%' THEN 'Gensmo'
               WHEN LOWER(b.name) LIKE 'decofy%' THEN 'Decofy'  ELSE 'UNKNOWN' END AS app_name
         ,advertiser_id                                                            AS account_id
         ,b.name                                                                   AS account_name
         ,image_id                                                                 AS external_creative_id
         ,file_name                                                                AS external_creative_name
         ,image_url                                                                AS external_creative_url
         ,'image'                                                                  AS creative_type
         ,CAST(NULL AS STRING)                                                     AS internal_creative_id
         ,format
         ,height
         ,width
         ,size
         ,updated_at
         ,created_at
         ,CAST(NULL AS STRING)                                                     AS upload_r2_process_at
  FROM
  (
    SELECT  Date(created_at)                                             AS dt
           ,image_id
           ,advertiser_id
           ,height
           ,size
           ,width
           ,image_url
           ,file_name
           ,signature
           ,displayable
           ,material_id
           ,format
           ,is_carousel_usable
           ,created_at
           ,_fivetran_synced
           ,ROW_NUMBER() OVER (PARTITION BY image_id ORDER BY created_at ASC ) AS rk
           ,MAX(updated_at) OVER (PARTITION BY image_id )                AS updated_at
    FROM `srpproduct-dc37e.fivetran_tiktok_ads.image_history`
    WHERE image_url IS NOT NULL
    AND image_id IS NOT NULL 
  ) a
  LEFT JOIN `srpproduct-dc37e.fivetran_tiktok_ads.advertiser` b
  ON CAST(a.advertiser_id AS STRING) = CAST(b.id AS STRING)
  WHERE rk = 1 
  AND dt = dt_param
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
