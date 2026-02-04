CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_retention_view`
AS select
        event_dt 
        ,is_new_user
        ,ad_media_source
        ,user_country
        ,last_platform
        ,last_app_version
        ,user_type
        ,d0_active
        ,d1_retention
        ,d2_retention
        ,d6_retention
        ,d1_7_retention
        ,LT_1_to_6
        ,w1_retention
    from favie_rpt.rpt_gensmo_management_dashboard_retention_full_1d
    where dt = (
        select max(dt) max_dt
        from favie_rpt.rpt_gensmo_management_dashboard_retention_full_1d
    );