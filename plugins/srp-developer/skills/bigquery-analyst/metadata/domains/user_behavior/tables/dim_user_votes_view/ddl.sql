CREATE VIEW `srpproduct-dc37e.favie_dw.dim_user_votes_view`
AS SELECT
  created_at,
  deleted_at,
  obj_id,
  obj_type,
  reason,
  updated_at,
  user_id,
  user_vote_id,
  vote_value
FROM (
  SELECT
    JSON_VALUE(data, '$.created_at') AS created_at,
    JSON_VALUE(data, '$.deleted_at') AS deleted_at,
    JSON_VALUE(data, '$.obj_id') AS obj_id,
    JSON_VALUE(data, '$.obj_type') AS obj_type,
    JSON_VALUE(data, '$.reason') AS reason,
    JSON_VALUE(data, '$.updated_at') AS updated_at,
    JSON_VALUE(data, '$.user_id') AS user_id,
    JSON_VALUE(data, '$.user_vote_id') AS user_vote_id,
    CAST(JSON_VALUE(data, '$.vote_value') AS INT64) AS vote_value
  FROM srpproduct-dc37e.favie_mongodb_integration_airbyte_decofy.user_votes
);