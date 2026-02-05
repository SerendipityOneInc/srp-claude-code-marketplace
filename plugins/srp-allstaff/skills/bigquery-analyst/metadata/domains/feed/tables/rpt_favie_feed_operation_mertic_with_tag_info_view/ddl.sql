CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_feed_operation_mertic_with_tag_info_view`
AS SELECT 
  e.event_date,
  e.collage_id,
  e.category,
  e.image_url,
  e.created_date,
  e.created_user_id,
  e.collage_description,
  e.collage_title,
  e.app_version,
  e.platform,
  e.operating_system,
  e.is_feed,
  tag.Style1, tag.Style2,
  tag.Occasion1, tag.Occasion2,
  tag.BodySize1, tag.BodySize2,
  tag.BodyShape1, tag.BodyShape2,
  tag.Height1, tag.Height2,
  tag.Color, tag.Weather, tag.Temperature, tag.Gender, tag.Age,
  e.pv_list,
  e.pv_click,
  e.uv_list,
  e.uv_click,
  e.share_cnt,
  e.detail_try_on,
  e.list_try_on,
  e.remix_cnt,
  e.save_cnt

FROM `srpproduct-dc37e.favie_rpt.rpt_favie_feed_operation_30d` e
LEFT JOIN `srpproduct-dc37e.favie_rpt.rpt_favie_moodboard_tag_full_agg_view` tag
  ON e.collage_id = tag.moodboard_id;