CREATE VIEW `srpproduct-dc37e.favie_dw.dim_decofy_user_ab_config_view`
AS SELECT  
        json_extract_scalar(data,'$._id') as _id,
        json_extract_scalar(data,'$.id') as id,
        timestamp(json_extract_scalar(data,'$.created_at')) as created_at,
        timestamp(json_extract_scalar(data,'$.updated_at')) as updated_at,
        json_extract_scalar(data,'$.description') as `description`,
        cast(json_extract_scalar(data,'$.enabled') as boolean) as `enabled`,
        json_extract_scalar(data,'$.user_id') as user_id,
        json_extract_scalar(data,'$.project') as project,
        json_extract_scalar(data,'$.rewrite_uri') as rewrite_uri,
        json_extract_scalar(data,'$.route_id') as route_id,
        json_extract_scalar(data,'$.router') as router,
        json_extract_scalar(data,'$.service') as `service`,
        timestamp(json_extract_scalar(data,'$.start_date')) as `start_date`,
        timestamp(json_extract_scalar(data,'$.end_date')) as `end_date`,
        json_extract_scalar(data,'$.tags') as tags,
        cast(json_extract_scalar(data,'$.unique_id') as int64) as unique_id,
        json_extract_scalar(data,'$.uri') as uri,
        cast(json_extract_scalar(data,'$.weight') as int64) as weight
    FROM `srpproduct-dc37e.favie_mongodb_integration_airbyte_decofy.decofy_user_ab_config`;