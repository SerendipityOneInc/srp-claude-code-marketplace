CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_retention_metrics_inc_1d_view`
AS select 
        dt,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_segment,
        user_tenure_type,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        user_group,
        retention_type,
        active_user_cnt,
        retention_user_cnt,
        favie_dw.app_minor_version_udf(app_version) as app_minor_version,
        favie_dw.app_patch_version_udf(app_version) as app_patch_version
    from favie_rpt.rpt_gensmo_user_x_retention_metrics_inc_1d
    where dt is not null;