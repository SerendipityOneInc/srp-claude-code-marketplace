CREATE VIEW `srpproduct-dc37e.favie_dw.dim_feed_tag_compare_result_view`
AS select 
    *,
    'llm<>Molly' as compare_group
  from favie_dw.dim_feed_tag_compare_function('llm','Molly')
  where tagger2_style1 is not null;