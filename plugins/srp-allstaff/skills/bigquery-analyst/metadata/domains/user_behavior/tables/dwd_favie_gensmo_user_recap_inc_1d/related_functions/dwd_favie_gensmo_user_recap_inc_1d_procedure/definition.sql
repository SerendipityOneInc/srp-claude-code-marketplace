BEGIN
      -- 删除目标日期的现有数据
      DELETE FROM `favie_dw.dwd_favie_gensmo_user_recap_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dwd_favie_gensmo_user_recap_inc_1d` (
      user_id
      ,dt
      ,event_type
      ,event_timestamp
      ,session_id
      ,item_name
      ,item_id
      ,item_type
      ,item_index
      ,image_url
      ,moodboard_content
      )
      SELECT
      user_id
      ,dt
      ,event_type
      ,event_timestamp
      ,session_id
      ,item_name
      ,item_id
      ,item_type
      ,item_index
      ,image_url
      ,moodboard_content
      FROM `favie_dw.dwd_gensmo_user_recap_inc_1d_function`(dt_param);
END