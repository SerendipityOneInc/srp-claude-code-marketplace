BEGIN
      DELETE FROM `favie_dw.dws_favie_gem_search_query_cube_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dws_favie_gem_search_query_cube_inc_1d` (
        raw_query,
        qr_query,
        qp_query,
        query_modality,
        query_source,
        query_intention_level1,
        query_intention_level2,
        user_type,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        raw_query_word_amt,
        qr_query_word_amt,
        qp_query_word_amt,
        query_cnt,
        query_user_uniq_cnt,
        dt
      )
      SELECT
        raw_query,
        qr_query,
        qp_query,
        query_modality,
        query_source,
        query_intention_level1,
        query_intention_level2,
        user_type,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        raw_query_word_amt,
        qr_query_word_amt,
        qp_query_word_amt,
        query_cnt,
        query_user_uniq_cnt,
        dt
      FROM `favie_dw.dws_favie_gem_search_query_cube_inc_1d_function`(dt_param);

END