CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_feed_metrics_report_view`
AS select 
        dt
        ,platform
        ,app_version
        ,country_name
        ,user_login_type
        ,user_tenure_type
        ,user_group

        --Feed PV
        ,sum(if(ap_name like 'ap_dual_column_feed_%',feed_item_list_pv_cnt,0)) as feed_item_list_pv_cnt

        --Feed UV
        ,count(distinct if(ap_name like 'ap_dual_column_feed_%',feed_item_click_device_id,null)) as feed_item_click_user_cnt

        --CTR By Feed TAB
        ,sum(if(ap_name like 'ap_dual_column_feed_for_you_%',feed_item_click_cnt,0)) as for_you_feed_item_click_cnt
        ,sum(if(ap_name like 'ap_dual_column_feed_for_you_%',feed_item_view_pv_cnt,0)) as for_you_feed_item_view_pv_cnt

        ,sum(if(ap_name like 'ap_dual_column_feed_for_man_%',feed_item_click_cnt,0)) as for_man_feed_item_click_cnt
        ,sum(if(ap_name like 'ap_dual_column_feed_for_man_%',feed_item_view_pv_cnt,0)) as for_man_feed_item_view_pv_cnt

        ,sum(if(ap_name like 'ap_dual_column_feed_for_woman_%',feed_item_click_cnt,0)) as for_women_feed_item_click_cnt
        ,sum(if(ap_name like 'ap_dual_column_feed_for_woman_%',feed_item_view_pv_cnt,0)) as for_women_feed_item_view_pv_cnt


        ,sum(if(ap_name like 'ap_dual_column_feed_for_you_%' 
          or ap_name like 'ap_dual_column_feed_for_man_%'
          or ap_name like 'ap_dual_column_feed_for_woman_%'
          ,feed_item_click_cnt,0)) as feed_item_click_cnt
        ,sum(if(ap_name like 'ap_dual_column_feed_%',feed_item_view_pv_cnt,0)) as feed_item_view_pv_cnt
          
        --CTR By Feed Type
        ,sum(if(
          item_intention =  "try_on_collage"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )
          ,feed_item_click_cnt,0)) as try_on_collage_feed_item_click_cnt
        ,sum(if(
          item_intention =  "try_on_collage"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )
          ,feed_item_view_pv_cnt,0)) as try_on_collage_feed_item_view_pv_cnt


        ,sum(if(
          item_intention =  "gifting"
           and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )         
          ,feed_item_click_cnt,0)) as gifting_feed_item_click_cnt
        ,sum(if(
          item_intention =  "gifting"
           and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )         
          ,feed_item_view_pv_cnt,0)) as gifting_feed_item_view_pv_cnt


        ,sum(if(
          item_intention =  "similar"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )
          ,feed_item_click_cnt,0)) as similar_feed_item_click_cnt
        ,sum(if(
          item_intention =  "similar"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )
          ,feed_item_view_pv_cnt,0)) as similar_feed_item_view_pv_cnt

        ,sum(if(
          item_intention =  "styling"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )
          ,feed_item_click_cnt,0)) as styling_feed_item_click_cnt
        ,sum(if(
          item_intention =  "styling"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )
          ,feed_item_view_pv_cnt,0)) as styling_feed_item_view_pv_cnt 


        ,sum(if(
          item_intention =  "general"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )          
          ,feed_item_click_cnt,0)) as general_feed_item_click_cnt
        ,sum(if(
          item_intention =  "general"
          and (
            ap_name like 'ap_dual_column_feed_for_you_%' 
            or ap_name like 'ap_dual_column_feed_for_man_%'
            or ap_name like 'ap_dual_column_feed_for_woman_%'
          )          
          ,feed_item_view_pv_cnt,0)) as general_feed_item_view_pv_cnt

        --feed detail pv
        ,sum(feed_item_detail_pv_cnt) as feed_item_detail_pv_cnt

        --total feed detail click
        ,sum(if(ap_name='ap_like_btn',feed_detail_click_cnt,0)) as feed_detail_like_btn_click_cnt
        ,sum(if(ap_name='ap_collage_entity_list_entity',feed_detail_click_cnt,0)) as feed_detail_collage_entity_btn_click_cnt
        ,sum(if(ap_name='ap_try_on_bottom_btn',feed_detail_click_cnt,0)) as feed_detail_try_on_bottom_btn_click_cnt
        ,sum(if(ap_name='ap_screen',feed_detail_click_cnt,0)) as feed_detail_screen_btn_click_cnt
        ,sum(if(ap_name='ap_remix_bottom_btn',feed_detail_click_cnt,0)) as feed_detail_remix_btn_click_cnt
        ,sum(if(ap_name='ap_product_list_product',feed_detail_click_cnt,0)) as feed_detail_product_list_btn_click_cnt
        ,sum(if(ap_name='ap_save_btn' and event_action_type='unsave',feed_detail_click_cnt,0)) as feed_detail_unsaved_btn_click_cnt
        ,sum(if(ap_name='ap_save_btn' and event_action_type='save',feed_detail_click_cnt,0)) as feed_detail_saved_btn_click_cnt
        ,sum(if(ap_name='ap_user_info',feed_detail_click_cnt,0)) as feed_detail_user_info_click_cnt
        ,sum(if(ap_name='ap_share_btn',feed_detail_click_cnt,0)) as feed_detail_share_btn_click_cnt
        ,sum(if(ap_name='ap_try_on_side_btn',feed_detail_click_cnt,0)) as feed_detail_try_on_side_btn_click_cnt
        ,(sum(feed_item_detail_pv_cnt)
                  - SUM(
                      IF(ap_name IN (
                          'ap_try_on_side_btn', 'ap_share_btn', 
                          'ap_user_info', 'ap_save_btn', 
                          'ap_product_list_product', 'ap_remix_bottom_btn', 
                          'ap_screen', 'ap_try_on_bottom_btn', 
                          'ap_collage_entity_list_entity', 'ap_like_btn'
                      ), feed_detail_click_cnt, 0)
                  )
              ) AS feed_detail_leave_cnt


        --feed detail tryon  click
        ,sum(if(event_source = "feed_detail@ap_try_on_bottom_btn",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_bottom_btn_click_cnt
        ,sum(if(event_source = "feed_detail@ap_screen",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_shake_click_cnt
        ,sum(if(event_source = "feed_detail@ap_try_on_side_btn",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_side_btn_click_cnt
        ,sum(if(event_source = "product_detail@ap_try_on_btn",feed_item_tryon_click_cnt,0)) as product_detail_tryon_btn_click_cnt
        ,sum(if(event_source = "pseudo_product_detail@ap_try_on_btn",feed_item_tryon_click_cnt,0)) as product_pseudo_detail_tryon_btn_click_cnt
        
        ,sum(if(item_intention = "try_on_collage",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_collage_click_cnt
        ,sum(if(item_intention = "gifting",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_gifting_click_cnt
        ,sum(if(item_intention = "similar",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_similar_click_cnt
        ,sum(if(item_intention = "styling",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_styling_click_cnt
        ,sum(if(item_intention = "general",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_general_click_cnt
        ,sum(if(item_intention = "product",feed_item_tryon_click_cnt,0)) as feed_detail_tryon_product_click_cnt
        ,sum(if(item_intention not in ("try_on_collage","gifting","similar","styling","general","product"),feed_item_tryon_click_cnt,0)) as feed_detail_tryon_others_click_cnt


        ,sum(feed_item_tryon_click_cnt) as feed_tryon_total_click_cnt

        --feed detail remix click
        ,sum(if(event_source = "feed_detail@ap_remix_bottom_btn",feed_item_remix_click_cnt,0)) as feed_detail_remix_bottom_btn_click_cnt
        ,sum(if(event_source = "product_detail@ap_remix_btn",feed_item_remix_click_cnt,0)) as product_detail_remix_btn_click_cnt
        ,sum(if(event_source = "pseudo_product_detail@ap_remix_btn",feed_item_remix_click_cnt,0)) as product_pseudo_detail_remix_btn_click_cnt

        ,sum(if(item_intention = "try_on_collage",feed_item_remix_click_cnt,0)) as feed_detail_remix_collage_click_cnt
        ,sum(if(item_intention = "gifting",feed_item_remix_click_cnt,0)) as feed_detail_remix_gifting_click_cnt
        ,sum(if(item_intention = "similar",feed_item_remix_click_cnt,0)) as feed_detail_remix_similar_click_cnt
        ,sum(if(item_intention = "styling",feed_item_remix_click_cnt,0)) as feed_detail_remix_styling_click_cnt
        ,sum(if(item_intention = "general",feed_item_remix_click_cnt,0)) as feed_detail_remix_general_click_cnt
        ,sum(if(item_intention not in ("try_on_collage","gifting","similar","styling","general"),feed_item_remix_click_cnt,0)) as feed_detail_remix_others_click_cnt

        ,sum(feed_item_remix_click_cnt) as feed_remix_total_click_cnt
        

        --feed detail save share click
        ,sum(if(ap_name='ap_save_btn' and event_action_type='save',feed_item_save_share_click_cnt,0)) as feed_item_save_btn_click_cnt
        ,sum(if(ap_name='ap_share_btn',feed_item_save_share_click_cnt,0)) as feed_item_share_btn_click_cnt
        ,sum(if(ap_name='ap_save_btn' and event_action_type='unsave',feed_item_save_share_click_cnt,0)) as feed_item_unsave_btn_click_cnt
        ,sum(if(refer in ("feed_detail","product_detail","pseudo_product_detail") and event_method='screenshot',feed_item_save_share_click_cnt,0)) as feed_item_screenshot_click_cnt

        ,sum(if(item_intention = "try_on_collage",feed_item_save_share_click_cnt,0)) as feed_item_save_share_tryon_collage_click_cnt
        ,sum(if(item_intention = "gifting",feed_item_save_share_click_cnt,0)) as feed_item_save_share_gifting_click_cnt
        ,sum(if(item_intention = "similar",feed_item_save_share_click_cnt,0)) as feed_item_save_share_similar_click_cnt
        ,sum(if(item_intention = "styling",feed_item_save_share_click_cnt,0)) as feed_item_save_share_styling_click_cnt
        ,sum(if(item_intention = "general",feed_item_save_share_click_cnt,0)) as feed_item_save_share_general_click_cnt
        ,sum(if(item_intention = "product",feed_item_save_share_click_cnt,0)) as feed_item_save_share_product_click_cnt
        ,sum(if(item_intention not in ("try_on_collage","gifting","similar","styling","general","product"),feed_item_save_share_click_cnt,0)) as feed_item_save_share_others_click_cnt

        ,sum(feed_item_save_share_click_cnt) as feed_item_save_share_click_cnt

        --feed detail product click
        ,sum(if(ap_name="ap_product_list_product",feed_detail_click_cnt,0)) as feed_product_detail_list_product_click_cnt
        ,sum(if(ap_name = "ap_collage_entity_list_entity",feed_detail_click_cnt,0)) as feed_product_detail_collage_entity_list_click_cnt
        --使用pseudo_product_detail的PV代替main pic的点击
        ,sum(if(refer = "pseudo_product_detail",feed_product_detail_pv_cnt,0)) as feed_product_detail_main_pic_click_cnt

        ,sum(if(refer = "pseudo_product_detail",feed_product_detail_pv_cnt,
              if(ap_name in ("ap_product_list_product","ap_collage_entity_list_entity"),feed_detail_click_cnt,0)
            )
        ) as feed_product_detail_total_click_cnt
     
        --product detail 
        ,sum(feed_product_detail_pv_cnt) as feed_product_detail_pv_cnt
        ,sum(if(refer="product_detail",feed_product_detail_pv_cnt,0)) as feed_real_product_detail_pv_cnt
        ,sum(if(refer="pseudo_product_detail",feed_product_detail_pv_cnt,0)) as feed_pseudo_product_detail_pv_cnt
        ,sum(if(ap_name = "ap_product_card",feed_product_detail_click_cnt,0)) as feed_product_view_more_click_cnt

        ,sum(if(ap_name = "ap_product_main_pic",feed_product_detail_click_cnt,0)) as feed_product_main_pic_click_cnt
        --,sum(if(ap_name = "ap_product_card",feed_product_detail_click_cnt,0)) as feed_product_product_card_click_cnt
        ,sum(if(ap_name = "ap_remix_btn",feed_product_detail_click_cnt,0)) as feed_product_remix_btn_click_cnt
        ,sum(if(ap_name = "ap_try_on_btn",feed_product_detail_click_cnt,0)) as feed_product_try_on_btn_click_cnt
        ,sum(if(ap_name = "ap_save_btn" and event_action_type='save',feed_product_detail_click_cnt,0)) as feed_product_save_btn_click_cnt
        ,sum(if(ap_name = "ap_save_btn" and event_action_type='unsave',feed_product_detail_click_cnt,0)) as feed_product_unsave_btn_click_cnt
        ,sum(if(ap_name = "ap_dual_column_feed_for_you_list_item_like_btn",feed_product_detail_click_cnt,0)) as feed_product_feed_for_you_list_item_like_btn_click_cnt
        ,sum(if(ap_name = "ap_dual_column_feed_popular_list_item_btn",feed_product_detail_click_cnt,0)) as feed_product_feed_popular_list_item_btne_click_cnt
        ,sum(if(ap_name = "ap_dual_column_feed_for_man_list_item_cover",feed_product_detail_click_cnt,0)) as feed_product_feed_for_man_list_item_cover_click_cnt
        ,sum(if(ap_name = "ap_user_info",feed_product_detail_click_cnt,0)) as feed_product_user_info_click_cnt
        ,sum(if(ap_name = "feed_for_man_list",feed_product_detail_click_cnt,0)) as feed_product_feed_for_man_list_click_cnt
        ,(sum(feed_product_detail_pv_cnt)
                          - SUM(
                              IF(ap_name IN (
                                  'ap_product_main_pic', 'ap_product_card', 
                                  'ap_remix_btn', 'ap_try_on_btn', 'ap_save_btn'
                                   'ap_dual_column_feed_for_you_list_item_like_btn', 
                                  'ap_dual_column_feed_popular_list_item_btn', 'ap_dual_column_feed_for_man_list_item_cover', 
                                  'ap_user_info', 'feed_for_man_list'
                              ), feed_product_detail_click_cnt, 0)
                          )
                      ) AS feed_product_detail_leave_cnt

    from favie_rpt.rpt_gensmo_feed_metrcis_rename_ap_screen_view 
    group by 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group;