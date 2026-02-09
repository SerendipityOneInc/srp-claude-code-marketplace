CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_product_structured_normalized_inc_1d_view`
AS SELECT
        dt,
        f_sku_id,
        enhanced_title,
        product_item as product_tag,
        color as color_tag,
        ARRAY_TO_STRING(
            ARRAY(SELECT TRIM(element) FROM UNNEST(split(material, ',')) AS element), 
            '\x1D') as material_tag,
        demographic,
        ARRAY_TO_STRING(
            ARRAY(SELECT TRIM(element) FROM UNNEST(split(season, ',')) AS element), 
            '\x1D') as season_tag,
        `length`,
        ARRAY_TO_STRING(
            ARRAY(SELECT TRIM(element) FROM UNNEST(split(closure, ',')) AS element), 
            '\x1D') as closure,
        fit_type,
        ARRAY_TO_STRING(
            ARRAY(SELECT TRIM(element) FROM UNNEST(split(`function`, ',')) AS element), 
            '\x1D') as `function`,
        neckline,
        pattern as pattern_tag,
        ARRAY_TO_STRING(
            ARRAY(SELECT TRIM(element) FROM UNNEST(split(style, ',')) AS element), 
            '\x1D') as style_tag,
        sleeve_length,
        sleeve_style,
        shape,
        ARRAY_TO_STRING(
            ARRAY(SELECT TRIM(element) FROM UNNEST(split(features, ',')) AS element), 
            '\x1D') as features,
        ARRAY_TO_STRING(
            ARRAY(SELECT TRIM(element) FROM UNNEST(split(occasion, ',')) AS element), 
            '\x1D') as occasion_tag,
        color_family,
        color_tone,
        color_saturation,
        ARRAY_TO_STRING(
            [
            product_item,
            color,
            material,
            demographic,
            season,
            `length`,
            closure,
            fit_type,
            `function`,
            neckline,
            pattern,
            style,
            sleeve_length,
            sleeve_style,
            shape,
            features,
            occasion,
            color_family,
            color_tone,
            color_saturation
            ],
            ','
        ) as tag_text_info
    FROM `favie_algo.dwd_gem_product_structured_normalized_inc_1d`;