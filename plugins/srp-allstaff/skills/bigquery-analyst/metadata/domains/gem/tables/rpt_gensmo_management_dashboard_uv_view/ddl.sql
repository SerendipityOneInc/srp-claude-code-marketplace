CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_uv_view`
AS select
      event_dt
      ,ad_media_source
      ,user_country
      ,last_platform
      ,last_app_version
      ,user_type
      ,mau
      ,dau
      ,wau
    from favie_rpt.rpt_gensmo_management_dashboard_uv_full_1d
    where dt = (
        select max(dt) max_dt
        from favie_rpt.rpt_gensmo_management_dashboard_uv_full_1d
    );