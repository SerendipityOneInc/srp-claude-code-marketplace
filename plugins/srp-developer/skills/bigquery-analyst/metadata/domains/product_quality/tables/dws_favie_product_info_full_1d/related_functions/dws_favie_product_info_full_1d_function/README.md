# dws_favie_product_info_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_product_info_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2026-01-30
**最后更新**: 2026-01-30

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
WITH base_with_arrays AS (
        SELECT 
            -- 明确列出所有需要的字段
            f_sku_id,
            f_spu_id,
            site,
            link,
            brand,
            keywords,
            price,
            f_creates_at,
            attributes,
            seller  as sellers,
            best_seller_rank,
            review_summary,
            variants_str,
            f_system_tags,
            f_videos,
            f_categories,
            -- 一次性提取类目数组
            ARRAY(
                SELECT JSON_EXTRACT_SCALAR(cat, '$.name')
                FROM UNNEST(JSON_EXTRACT_ARRAY(f_categories)) AS cat
            ) AS category_array
        FROM `favie_dw.dwd_favie_product_detail_full_1d`
        WHERE dt IS NOT NULL 
            AND PARSE_DATE('%Y-%m-%d', dt) = dt_param
    )
    
    SELECT
        dt_param AS dt,
        
        -- 基础信息
        f_sku_id,
        keywords,
        f_spu_id,
        link,
        brand AS brand_name,
        site,
        SAFE_CAST(JSON_EXTRACT_SCALAR(price, '$.value') AS INT64) AS price,
        
        -- 上架时间
        DATE(TIMESTAMP_SECONDS(SAFE_CAST(f_creates_at AS INT64))) AS launch_date,
        
        -- 包装信息
        cast(null as FLOAT64) AS package_weight,
        cast(null as int64) AS package_dimensions,
        
        -- 卖家信息
        sellers,
        
        -- 类目层级（直接用数组索引，只需一次 UNNEST）
        IF(ARRAY_LENGTH(category_array) > 0, category_array[OFFSET(0)], NULL) AS category_level_1,
        IF(ARRAY_LENGTH(category_array) > 1, category_array[OFFSET(1)], NULL) AS category_level_2,
        IF(ARRAY_LENGTH(category_array) > 2, category_array[OFFSET(2)], NULL) AS category_level_3,
        IF(ARRAY_LENGTH(category_array) > 3, category_array[OFFSET(3)], NULL) AS category_level_4,
        IF(ARRAY_LENGTH(category_array) > 4, category_array[OFFSET(4)], NULL) AS category_level_5,
        IF(ARRAY_LENGTH(category_array) > 5, category_array[OFFSET(5)], NULL) AS category_level_6,
        IF(ARRAY_LENGTH(category_array) > 6, category_array[OFFSET(6)], NULL) AS category_level_7,
        IF(ARRAY_LENGTH(category_array) > 7, category_array[OFFSET(7)], NULL) AS category_level_8,
        IF(ARRAY_LENGTH(category_array) > 8, category_array[OFFSET(8)], NULL) AS category_level_9,
        IF(ARRAY_LENGTH(category_array) > 9, category_array[OFFSET(9)], NULL) AS category_level_10,
        
        -- 主图视频
        CASE WHEN f_videos IS NOT NULL AND f_videos != '[]' THEN TRUE ELSE FALSE END AS has_main_video,
        
        -- 商品标识
        cast(null as string) AS product_badges,
        
        -- FBA费用（待补充）
        CAST(NULL AS FLOAT64) AS fba_fee,
        
        -- 销量相关（待补充）
        CAST(NULL AS INT64) AS monthly_sale_cnt,
        CAST(NULL AS FLOAT64) AS monthly_sale_amt,
        CAST(NULL AS INT64) AS monthly_parent_sale_cnt,
        CAST(NULL AS FLOAT64) AS monthly_parent_sale_amt,
        CAST(NULL AS FLOAT64) AS monthly_sales_growth_rate,
        CAST(NULL AS FLOAT64) AS monthly_parent_sales_growth_rate,
        
        -- BSR排名
        SAFE_CAST(JSON_EXTRACT_SCALAR(best_seller_rank, '$[0].rank') AS INT64) AS big_category_bsr,
        SAFE_CAST(JSON_EXTRACT_SCALAR(best_seller_rank, '$[1].rank') AS INT64) AS small_category_bsr,
        
        -- BSR增长（待补充）
        CAST(NULL AS INT64) AS big_bsr_growth,
        CAST(NULL AS FLOAT64) AS big_bsr_growth_rate,
        CAST(NULL AS INT64) AS small_bsr_growth,
        CAST(NULL AS FLOAT64) AS small_bsr_growth_rate,
        
        -- 变体数
        COALESCE(
            ARRAY_LENGTH(SPLIT(REGEXP_REPLACE(variants_str, r'[\[\]"]', ''), ',')),
            0
        ) AS variant_cnt,
        
        -- 卖家数（待补充）
        CAST(NULL AS INT64) AS seller_cnt,
        
        -- 评分评论
        CAST(SAFE_CAST(JSON_EXTRACT_SCALAR(review_summary, '$.rating') AS FLOAT64) AS INT64) AS rating_amt,
        SAFE_CAST(JSON_EXTRACT_SCALAR(review_summary, '$.ratings_total') AS INT64) AS rating_cnt,
        SAFE_CAST(JSON_EXTRACT_SCALAR(review_summary, '$.ratings_total') AS INT64) AS review_cnt,
        
        -- 月评新增（待补充）
        CAST(NULL AS INT64) AS monthly_new_rating_cnt,
        CAST(NULL AS FLOAT64) AS monthly_rating_rate,
        
        -- Q&A数量（待补充）
        CAST(NULL AS INT64) AS qa_cnt,
        
        -- 毛利率（待补充）
        CAST(NULL AS FLOAT64) AS gross_margin_rate,
        
        -- LQS评分（待补充）
        CAST(NULL AS FLOAT64) AS listing_quality_score,
        
        -- 配送方式
        CASE 
            WHEN f_system_tags LIKE '%fba%' THEN 'FBA'
            WHEN f_system_tags LIKE '%fbm%' THEN 'FBM'
            WHEN f_system_tags LIKE '%amz%' THEN 'AMZ'
            ELSE NULL
        END AS fulfillment_type
        
    FROM base_with_arrays
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
