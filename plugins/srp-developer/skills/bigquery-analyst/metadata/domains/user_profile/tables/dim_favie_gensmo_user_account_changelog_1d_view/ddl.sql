CREATE VIEW `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d_view`
AS select 
    scd2_updated_at as process_date,
    scd2_updated_at as updated_at,
    created_at,
    ua.user_id,
    device_id as first_device_id,
    device_id as last_device_id,
    first_access_info.appsflyer_id,
    cast(null as ARRAY<STRING>) as device_ids,
    cast(null as string) as user_name,
    cast(null as string) as user_email,
    ua.user_type,
    is_internal_user,
    first_geo_address as geo_address,
    first_access_info.app_info as app_info
  from favie_dw.dim_favie_gensmo_user_scd2_1d,unnest(user_accounts) as ua
  where is_current = True;