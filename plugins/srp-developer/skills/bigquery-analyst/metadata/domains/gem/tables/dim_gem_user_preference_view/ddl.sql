CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_user_preference_view`
AS with replica_data as (
        select 
            user_id,
            json_extract_scalar(preference, '$.age_group') as age_group,
            json_extract_scalar(preference, '$.body_shape') as body_shape,
            json_extract_scalar(preference, '$.body_type') as body_types,
            json_extract_scalar(preference, '$.gender') as gender,
            json_extract_scalar(preference, '$.glasses') as glasses,
            json_extract_scalar(preference, '$.race') as race,
            json_extract_scalar(preference, '$.other_needs') as other_needs,
            json_value(replica,"$.model_id") as model_id,
            json_value(replica,"$.model_url") as model_url
        from favie_dw.dim_replica_task_view,unnest(json_extract_array(replica_list)) as replica
    )
    select 
        t2.user_id,
        t2.model_id,
        t1.model_url,
        t2.age_group,
        t2.body_shape,
        t2.body_types,
        t2.gender,
        t2.glasses,
        t2.race,
        t2.other_needs
    from (select * from favie_dw.dim_gem_user_replica_view where deleted_timestamp is null) t1
    left outer join replica_data t2
    on t1.user_id = t2.user_id
    and t1.model_id = t2.model_id;