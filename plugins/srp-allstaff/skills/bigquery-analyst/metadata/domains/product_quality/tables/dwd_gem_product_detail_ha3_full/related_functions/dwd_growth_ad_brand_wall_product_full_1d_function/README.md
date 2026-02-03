# dwd_growth_ad_brand_wall_product_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_growth_ad_brand_wall_product_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-09-17
**最后更新**: 2025-09-17

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_full` (dwd_gem_product_detail_ha3_full)

---

## 💻 函数定义

```sql
SELECT  
id
,title
,description
,availability
,condition
,price
,link
,image_link
,a.brand
,sale_price
,item_group_id
,status
,color
,gender
FROM
(
	
SELECT  
    f_sku_id as id 
    ,title as title 
    ,case when description ='' or description =' ' then title else description  end as description 
    ,"in stock" as availability
    ,"new" as condition 
    ,CONCAT(FORMAT('%.2f', base_price / 100.0), ' USD') as price
    ,concat('https://gensmo.onelink.me/038u/m09d7uoa?deep_link_value=gensmo%3A%2F%2Fbrand%2Flist%3Fbrand%3Darea%26product_id%3D',f_sku_id,'%26show_product%3Dtrue%26insert%3Dtrue') as link
    ,display_image  as image_link
    ,lower(norm_brand) as  brand
    ,case when base_price>local_price then (CONCAT(FORMAT('%.2f', local_price / 100.0), ' USD'))   else cast(null as string ) end as sale_price
    ,f_spu_id as item_group_id  
    ,"active" as status
    ,color_tag as color
    
 ,CASE
  WHEN REGEXP_CONTAINS(LOWER(gender_tag), r'(^|,)\s*unisex\s*(,|$)')
       OR (
         REGEXP_CONTAINS(LOWER(gender_tag), r'(^|,)\s*(female|woman|women)\s*(,|$)')
         AND REGEXP_CONTAINS(LOWER(gender_tag), r'(^|,)\s*(male|man|men)\s*(,|$)')
       )
    THEN 'unisex'
  WHEN REGEXP_CONTAINS(LOWER(gender_tag), r'(^|,)\s*(female|woman|women)\s*(,|$)')
       AND NOT REGEXP_CONTAINS(LOWER(gender_tag), r'(^|,)\s*(male|man|men)\s*(,|$)')
    THEN 'female'
  WHEN REGEXP_CONTAINS(LOWER(gender_tag), r'(^|,)\s*(male|man|men)\s*(,|$)')
       AND NOT REGEXP_CONTAINS(LOWER(gender_tag), r'(^|,)\s*(female|woman|women)\s*(,|$)')
    THEN 'male'
  ELSE NULL end as gender
	FROM `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_full`
	WHERE cmd = 'add' -- 必须是add状态
	AND is_brand_site = '1' -- 是品牌官网商品 
     and local_price >0 
     and local_price <10000
     and local_currency =0
     and base_currency=0
     
     and brand is not null
     and title is not null 
     and description is not null 
     
     and base_price is not null 
     and link is not null
     and display_image is not null 
    
     and display_score=1
) a
  JOIN `favie_dw.dim_gensmo_brand_wall_view` b
  ON lower(trim(a.brand)) = lower(trim(b.brand))
 join (
  
  
  select f_sku_id
from favie_dw.dwd_favie_product_detail_full_1d a
where  dt= (select max(dt) from favie_dw.dwd_favie_product_detail_full_1d  where dt>='2025-09-01')
and dt>'2025-09-01'
and 
DATE_DIFF(dt_param,DATE(TIMESTAMP_SECONDS(SAFE_CAST( f_updates_at as int64)), "UTC") ,DAY)<=7

) c 
on a.id=c.f_sku_id
```

---

**文档生成**: 2026-01-30 13:41:34
**扫描工具**: scan_functions.py
