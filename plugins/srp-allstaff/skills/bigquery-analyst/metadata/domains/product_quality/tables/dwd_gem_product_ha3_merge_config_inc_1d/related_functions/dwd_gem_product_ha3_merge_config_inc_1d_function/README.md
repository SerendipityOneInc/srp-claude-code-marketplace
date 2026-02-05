# dwd_gem_product_ha3_merge_config_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_ha3_merge_config_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2026-01-12
**最后更新**: 2026-01-12

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| product_index_config_json | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH active_config AS (
        SELECT
            cfg,
            SAFE_CAST(JSON_VALUE(cfg, '$.valid_from') AS DATE) AS valid_from_date,
            (
                SELECT ARRAY_AGG(json_value(day_str))
                FROM UNNEST(JSON_QUERY_ARRAY(cfg, '$.full_merge_days')) AS day_str
            ) AS full_merge_days
        FROM UNNEST(JSON_QUERY_ARRAY(product_index_config_json)) AS cfg
        -- 筛选出已经开始生效的配置
        WHERE SAFE_CAST(JSON_VALUE(cfg, '$.valid_from') AS DATE) <= dt_param
        -- 获取最新的一个
        ORDER BY SAFE_CAST(JSON_VALUE(cfg, '$.valid_from') AS DATE) DESC
        LIMIT 1
    ),
    final_data as(
        SELECT
            dt_param AS dt,
            full_merge_days,
            -- 根据生效的配置来决定运行模式
            CASE
                -- 如果今天是指定的“全量合并日”...
                WHEN LPAD(CAST(EXTRACT(DAY FROM dt_param) AS STRING), 2, '0') IN UNNEST(full_merge_days) THEN 'full'
                -- 或者今天是新配置生效的第一天（也需要全量运行）...
                WHEN dt_param = valid_from_date THEN 'full'
                -- 否则，保持默认的增量模式。
                ELSE 'inc'
            END AS merge_mode,
            struct(
                JSON_VALUE(cfg, '$.collage_category_model_version') AS collage_category_model_version,
                JSON_VALUE(cfg, '$.product_enhanced_category_model_version') AS product_enhanced_category_model_version,
                JSON_VALUE(cfg, '$.product_enhanced_title_model_version') AS product_enhanced_title_model_version,
                JSON_VALUE(cfg, '$.product_image_score_model_version') AS product_image_score_model_version,
                JSON_VALUE(cfg, '$.product_item_profile_model_version') AS product_item_profile_model_version
            ) as model_config
        FROM active_config
    )

    select 
        dt,
        full_merge_days,
        merge_mode,
        model_config,
    from final_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
