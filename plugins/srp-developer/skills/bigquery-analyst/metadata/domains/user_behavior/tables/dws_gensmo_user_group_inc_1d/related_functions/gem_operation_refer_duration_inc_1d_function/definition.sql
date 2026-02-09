SELECT
    m.dt,
    m.refer,
    m.data_name,
    m.data_value,
    m.device_id,
    n.user_group,
    n.platform,
    n.app_version,
    n.user_login_type,
    n.user_tenure_type
    FROM `srpproduct-dc37e.favie_dw.dws_gensmo_refer_general_metrics_inc_1d` m
    LEFT JOIN `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` n
    ON m.dt=n.dt and m.device_id=n.device_id
    where m.dt=dt_param