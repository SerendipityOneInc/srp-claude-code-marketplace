CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_moodboard_tag_full_agg_view`
AS WITH parsed AS (
  SELECT
    moodboard_id,
    tag_value,
    JSON_EXTRACT_ARRAY(tag_value, '$.moodboard_tags') AS tags
  FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_interface_full_view`
),

exploded AS (
  SELECT
    moodboard_id,
    JSON_EXTRACT_SCALAR(tag, '$.Category') AS category,
    JSON_EXTRACT_ARRAY(tag, '$.Candidates') AS candidates
  FROM parsed, UNNEST(tags) AS tag
),

flattened AS (
  SELECT
    moodboard_id,
    category,
    JSON_EXTRACT_SCALAR(c, '$.Primary') AS primary,
    JSON_EXTRACT_SCALAR(c, '$.Secondary') AS secondary
  FROM exploded, UNNEST(candidates) AS c
),

-- 分组聚合字段整理
aggregated AS (
  SELECT
    moodboard_id,

    -- style
    STRING_AGG(IF(category = 'Style', primary, NULL), ',') AS Style1,
    STRING_AGG(IF(category = 'Style', secondary, NULL), ',') AS Style2,

    -- occasion
    STRING_AGG(IF(category = 'Occasion', primary, NULL), ',') AS Occasion1,
    STRING_AGG(IF(category = 'Occasion', secondary, NULL), ',') AS Occasion2,

    -- body_size
    STRING_AGG(IF(category = 'Body Size', primary, NULL), ',') AS BodySize1,
    STRING_AGG(IF(category = 'Body Size', secondary, NULL), ',') AS BodySize2,

    -- body_shape
    STRING_AGG(IF(category = 'Body Shape', primary, NULL), ',') AS BodyShape1,
    STRING_AGG(IF(category = 'Body Shape', secondary, NULL), ',') AS BodyShape2,

    -- height
    STRING_AGG(IF(category = 'Height', primary, NULL), ',') AS Height1,
    STRING_AGG(IF(category = 'Height', secondary, NULL), ',') AS Height2,

    -- 其余只有 Primary 的类
    STRING_AGG(IF(category = 'Color', primary, NULL), ',') AS Color,
    STRING_AGG(IF(category = 'Weather', primary, NULL), ',') AS Weather,
    STRING_AGG(IF(category = 'Temperature', primary, NULL), ',') AS Temperature,
    STRING_AGG(IF(category = 'Gender', primary, NULL), ',') AS Gender,
    STRING_AGG(IF(category = 'Age', primary, NULL), ',') AS Age

  FROM flattened
  GROUP BY moodboard_id
)

SELECT * FROM aggregated;