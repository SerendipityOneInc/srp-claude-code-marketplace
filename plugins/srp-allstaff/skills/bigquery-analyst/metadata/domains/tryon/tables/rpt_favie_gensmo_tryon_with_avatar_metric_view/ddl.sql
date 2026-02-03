CREATE VIEW `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_tryon_with_avatar_metric_view`
AS with id_map_data as (
    select 
      dt,
      user_id,
      device_id
    from (
      select 
        dt,
        user_id,
        device_id,
        row_number() over(partition by user_id,dt order by last_timestamp desc) as rn  
      from srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_inc_1d
    ) where rn=1
  ), 

  base_data as (
    select
      date(created_time) as dt,
      try_on_task_id,
      t1.model_id,
      model_url,
      t2.device_id,
      use_default_model
    from `srpproduct-dc37e.favie_dw.dim_try_on_user_task_view` t1
    left join id_map_data t2
      on t1.user_id = t2.user_id and date(t1.created_time) = t2.dt
    left join `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` t3
      on t1.model_id = t3.model_id and t1.user_id = t3.user_id
    where t1.model_id is not null and t3.model_id is not null and t1.model_id != ''
  )

  select
    dt,
    device_id,
    model_id as avatar_id,
    model_url as avatar_url,
    use_default_model,
    count(distinct try_on_task_id) as tryon_cnt
  from base_data
  group by
    device_id,
    dt,
    model_id,
    model_url,
    use_default_model;